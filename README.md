# ChangeMyDailyStatus

毎日 00:00 JST に GitHub ステータスを `words.tsv` の次の行（絵文字＋単語）へ変更する。
次に使う行番号は `next_index`（0始まり）に保存され、Actions が毎回コミットする。
Busy（limited availability）と有効期限は現在のステータスから引き継ぐ。

## セットアップ
1. `user` スコープを持つ Classic PAT を作成する（Fine-grained PAT はステータス変更に未対応）。
2. リポジトリの Settings → Secrets and variables → Actions に `STATUS_TOKEN` として登録。
3. Settings → Actions → General → Workflow permissions を "Read and write" にする。
4. Actions タブから `Rotate GitHub status` を手動実行して動作確認。
