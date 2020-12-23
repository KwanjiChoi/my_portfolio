## 実装予定

- ツリー構造のカテゴリ(隣接リストモデルかな) *SQLアンチパターン参照
- 支払い機能
- teacher accountをactivateする際のチェック機能
- リアルタイムチャット
- treacherのスケジュール共有
- いいね
- follow
- 通知機能
- 友達紹介
- オンラインレッスン


## 使用技術

  - rails 6.0.3
  - docker
    - mysql
    - redis
    - sidekiq
    - chorme driver(テスト用)
  - CercleCI CI/CD
  - AWS S3
  - heroku

  - チャレンジ AWS CodeBuildとCodeDeployを使ったEC2へのCI/CD

## 反省点
  - それぞれが違ったロジックで認可をしているため、correct_userが複数のcontrollerに点在する
    - ルーティングが後付けでめちゃくちゃ、共通のパターンを意識しないとダメ

  - Comment model に関して
     - 命名をReview modelにすれば良かった。
     - 評価の平均点をとる処理に関して、毎回aveで集計する実装は間違っている。
      - 解決策としては、user projetそれぞれにscore_aveカラムを持たせて定期jobで平均を集計しupdateしてあげれば良い


## 自分用

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
    

- controllerの処理
  - ビジネスロジックは書くべきではない
  - メタプログラミングを意識しすぎると可読性が下がる
  - helperとの共存,model操作はhelperに書くべきではない(できるけど)

- STIはサブクラスが増える可能性のあるmodelに適用しよう



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
  - インスタンスに入っていないためメソッドを呼び出すたびに都度DBへのアクセスが必要(define_methodの戻り値をメモ化する方法を模索中)


controller/concerns/define_method/**.rb
に定義したメソッドは全てhelperになるよう調整

