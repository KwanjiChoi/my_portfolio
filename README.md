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
  - CercleCI
  - AWS S3
  - heroku


## 自分用

- systemテストについて
  - 粒度を意識しよう！
    - 個別の部品についてテスト
      - 各セクションに必要なテキストはあるか
      - jsの動きは正しいか
    - その後ページ全体のロジックをテスト
      - ビジネスロジックに沿ってデータの変更は適正にできているか

- controllerの処理
  - ビジネスロジックは書くべきではない
  - メタプログラミングを意識しすぎると可読性が下がる
  - helperとの共存,model操作はhelperに書くべきではない(できるけど)



## ワンポイント

reservationsコントローラでは@をなくすことでコードの冗長性を排除いたしました。
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
<%= unchecked_active_reservations.each do |reservation| %>
 ・
 ・
 ・
<% end %>
```

のように使える。

- メリット
  - コードが美しい
  - viewで直感的にオブジェクトを扱える

- デメリット
  - controllerをみてぱっと見何をやっているのか把握しづらい
  - インスタンスに入っていないためメソッドを呼び出すたびに都度DBへのアクセスが必要(絶対良い方法があるはず)

