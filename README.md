# Meets Eats
## Concept
ご飯を奢りたい人と奢られたい人が食事を共にするマッチングアプリ
## Overview
HotpepperAPIを使用して、食事をご馳走する代わりに誰かと会話を楽しみたい人、又は空いた時間を利用して誰かの話し相手になる代わりに無料で食事を楽しみたい人向けのアプリケーションです。
## How to Use
* ご飯を奢りたい人
1. お店検索（Hotpapper API)でお店を選択した後、日時・話したいテーマ・料理ジャンル・受付終了時間を入力してイベントを投稿することができます。  
2. 指定した受付時間までに参加希望した複数のユーザーのプロフィールを確認したり、チャットのやり取りを通して食事する相手を決めます。（１対１。）  
3. 食事後、参加者が先にイベントを評価します。参加者の評価が確認できたら主催者が評価します。（履歴にマッチング情報が残ります）
  
* ご飯を奢られたい人
1. 話したいテーマやエリア別のカテゴリーを選んだ後、奢りたい人のイベント投稿一覧の中から参加します。(事前にチャットで連絡取り合うことも可）
2. 後日イベント主催者（奢りたい人）から選ばれたら当選通知がメールで来ます。（選ばれなかった場合もメールの通知有り）
3. 食事後、参加者が先にイベントを評価します。参加者の評価が確認できたら主催者が評価します。（履歴にマッチング情報が残ります） 
 
# バージョン
Ruby 2.6.5  
Rails 5.2.4

## gem
- devise
- ransack
- kaminari
- letter_opener_web
- carrierwave

# カタログ設計/テーブル設計
https://docs.google.com/spreadsheets/d/1KrwlcPG1McH3fofyQokyc2YuyWp_wUfdmRyIsOi0je8/edit?usp=sharing
# ER図
![ER diagram](https://user-images.githubusercontent.com/56712012/90004686-077b0600-dcd1-11ea-8cb1-4bae9fc15597.png)
# 画面遷移図
![Screen trasition diagram](https://user-images.githubusercontent.com/56712012/89975919-02eb2900-dca2-11ea-954f-9f3044cea7f1.png)
# Wireframe
![Wireframe](https://user-images.githubusercontent.com/56712012/89975921-041c5600-dca2-11ea-82f1-dac7e8eab4e8.png)

