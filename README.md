
# I'm left over

テクノロジーが進歩する中、その恩恵を受けれる人の差がより開いている時代となりました。

技術の発展は平等に人々の生活を豊かにするべきです。
IT関連(スマホの操作やPCのセットアップ)で困っている人と、それを解決できる人をマッチングさせるプラットフォームを作りました。

テクノロジー発展の恩恵をより多くの人々に受けてもらいたい、
それをオンライン上のプラットフォームで紡げるようにしたい、
という想いで作成しました。




## テストユーザー

email: test@example.com
password: password


## 使用技術

  - rails 6.0.3
  - docker, docker-compose
    - mysql
    - redis
    - sidekiq
    - chrome driver(テスト用)
  - CercleCI CI/CD
  - AWS S3
  - heroku
    - Cityのseedデータに関しまして、フルで挿入すると1時間当たりのクエリ発行上限に達するため、東京都,愛知県,京都府,大阪府,兵庫県,福岡県の6都市のみデータを入れております。

  チャレンジ 
  - AWS CodeBuildとCodeDeployを使ったEC2へのCI/CD
  - health checkによるjob監視
  - マルチDBにしてレプリケーション・負荷分散

## 見ていただきたい点
  - reservations controllerでのメタプログラミング *@ハックを参照してください
  - パフォーマンスチューニング
    - N+1問題の解消
    - STI ポリモーフィック関連の活用 (微々たるものですが無駄なテーブルを削減)


## 反省点
  - それぞれが違ったロジックで認可をしているため、correct_userが複数のcontrollerに点在する
    - ルーティングが後付けでめちゃくちゃ、共通のパターンを意識しないとダメ

  - Comment model に関して
     - 命名をReview modelにすれば良かった。
     - 評価の平均点をとる処理に関して、毎回aveで集計する実装は間違っている。
      - ~~解決策としては、user projetそれぞれにscore_aveカラムを持たせて定期jobで平均を集計しupdateしてあげれば良い~~
      ↓
      - performances table(実績テーブル)を作成し解決

  - 足りない機能だらけだが、最低限必要なものを取捨選択し実装するべきである

## ワンポイント

reservationsコントローラでは@ハックにチャレンジ
[コントローラから`@`ハックを消し去ろう](https://techracho.bpsinc.jp/hachi8833/2018_06_14/58056)
(試行錯誤なので他のコントローラは通常実装)

```
def index
  @unchecked_active_reservations = Reservation.sort_reservations_by_status(user, requester: true, status: 'unchecked')
  
  @checked_active_reservations   = Reservation.sort_reservations_by_status(user, requester: true, status: 'checked')
  
  @finished_active_reservations  = Reservation.sort_reservations_by_status(user, requester: true, status: 'finished')
  
  @canceled_active_reservations  = Reservation.sort_reservations_by_status(user, requester: true, status: 'canceled')
end

```

インスタンス変数に格納するのではなく,
メソッドで定義してviewから呼び出せばよくね?

ということで

define_methodを使ってメタプログラミングっぽく定義

```
def index; end

STATUS = Reservation.statuses.keys.freeze

STATUS.each do |status|
  method_name = "#{status}_active_reservations"
  define_method method_name do |user|
    Reservation.sort_reservations_by_status(user, requester: true, status: status)
  end
  helper_method method_name.to_sym
end

```

helperメソッドにしたことで
viewでは

```
<%= unchecked_active_reservations(current_user).each do |reservation| %>
 ・
 ・
 ・
<% end %>
```

のように使える。

- メリット
  - コードが美しい
  - viewで直感的にオブジェクトを扱える(モデル操作のように扱える)

- デメリット
  - controllerをみてぱっと見何をやっているのか把握しづらい
  - どのviewでなんの変数を使っているのかconntrollerからは把握できない(viewを見て確認するしかない)
  - インスタンスに入っていないためメソッドを呼び出すたびに都度DBへのアクセスが必要(define_methodの戻り値をメモ化する方法を模索中)


### @ハックのすゝめ

concernsのディレクトリ構成

```
controller
└── concerns
  　└── define_method
       └── **_mehthods.rb
```


controller/concerns/define_method/**_methods.rb

```

module DefineMethod::**Methods
  extend ActiveSupport::Concern

  def any_method
  end
end

```

controller/application_controller.rb

```
def define_helper_methods
  define_module = "DefineMethod::#{controller_name.camelize.singularize}Methods".constantize
  define_module.instance_methods.each do |method|
    ApplicationController.helper_method method
  end
end
```
上記メソッドを定義

controller配下の**s_controller.rbにて

```
include DefineMethod::ReservationMethods

before_action :define_helper_method
```

をしてあげると
**_methods.rbにて定義したメソッドはcontroller内でも、viewでも使える。

これでcontrollerがスッキリしました！

対応するコントローラのビュー以外でメソッドを使ってしまうとバグの原因になるので

```
config.action_controller.include_all_helpers = false
```
を設定してあげるのが良さそうです。



## 自分用小言

- systemテストについて
  - 粒度を意識しよう！
    - 個別の部品についてテスト
      - 各セクションに必要なテキストはあるか
      - jsの動きは正しいか
    - その後ページ全体のロジックをテスト
      - ビジネスロジックに沿ってデータの変更は適正にできているか

- requestテストについて
  - 粒度を意識しよう　→　describeとcontextをうまく使い適性に場合分してテストする
    1. describe どのリクエストに対してのテストなのか
    2.  context どの権限からのテストなのか
    3. it どのように振舞うのか

- その他テストに関して
  - メソッドのテスト
    - argがnil, blank, emptyなど様々な角度でテストすべし
    

- controllerの処理
  - ビジネスロジックは書くべきではない
  - メタプログラミングを意識しすぎると可読性が下がる
  - helperとの共存,model操作はhelperに書くべきではない(できるけど)

- STIはサブクラスが増える可能性のあるmodelに適用しよう
- ポリモーフィック関連を活用して関連先が増えてもテーブルをいじらないで済む
  - nitifications tableをポリモーフィックにしたことで新たな通知modelが出てきても簡単に実装できる






