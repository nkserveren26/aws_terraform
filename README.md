"# aws_terraform" 
## Github Actions で AWS リソースをデプロイする Terraform コードを実行
### AWS 側の設定
#### ID プロバイダーの作成
以下の内容の ID プロバイダーを作成する。
- プロバイダのタイプ：OpenID Connect
- プロバイダのURL：https://token.actions.githubusercontent.com
- 対象者：sts.amazonaws.com


#### IAM ロールの作成