
# 時間Todo -所要時間が設定できるシンプルなTodoリスト

![mts](https://user-images.githubusercontent.com/58395096/233432233-a7b9c1df-64e5-4327-9376-abb0f8271c5c.png)

### [App Store リンク](https://apps.apple.com/us/app/minutetodo-%E6%89%80%E8%A6%81%E6%99%82%E9%96%93%E3%81%8C%E8%A8%AD%E5%AE%9A%E3%81%A7%E3%81%8D%E3%82%8B%E3%82%B7%E3%83%B3%E3%83%97%E3%83%ABtodo/id6446017739)

## 使用ライブラリ
- RealmSwift

## ポイント
- StoryBoardを使わず、UIKitとAutoLayoutでUIを開発
- UITableViewCellのcontentViewに余白を設けたため、デフォルトのスワイプアクションだと余白や角丸を考慮せずに削除ボタンが表示されてしまう。そのため、contentViewの形に合うように自分で編集・削除ボタンを用意し、UIPanGestureRecognizerでスワイプ処理を実装した。（画像２枚目を参照）<br>
またこの時の工夫点として、スワイプしてもタイトルラベル（画像だと「買い物に行く」）が動かないようにした。デフォルトのスワイプアクションだとタイトルラベルも一緒に動くため、スワイプするとタイトルの左側が見切れてしまう。<br>
[対応箇所のコード](https://github.com/yusame0308/MinuteTodo/blob/ce40df46b75fe25d8bc7cef8e307431a6e82d26d/DailyPlan/Views/Home/TaskTableViewCell.swift#L236-L290)
