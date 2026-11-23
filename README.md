# ChangeMyDailyStatus

毎日 00:00 JST に GitHub ステータスを `words.tsv` の次の行（絵文字＋単語）へ変更する。
次に使う行番号はリポジトリ変数 `NEXT_INDEX`（0始まり）に保存される。Settings → Secrets and variables → Actions → Variables から手動で書き換えれば次の単語を指定できる。
Busy（limited availability）と有効期限は現在のステータスから引き継ぐ。

## セットアップ
1. `user` と `repo` スコープを持つ Classic PAT を作成する（Fine-grained PAT はステータス変更に未対応）。
2. リポジトリの Settings → Secrets and variables → Actions に `STATUS_TOKEN` として登録。
3. Actions タブから `Rotate GitHub status` を手動実行して動作確認。
