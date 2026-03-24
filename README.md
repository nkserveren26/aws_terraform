"# aws_terraform" 
## Github Actions で AWS リソースをデプロイする Terraform コードを実行
### AWS 側の設定
#### ID プロバイダーの作成
以下の内容の ID プロバイダーを作成する。
- プロバイダのタイプ：OpenID Connect
- プロバイダのURL：https://token.actions.githubusercontent.com
- 対象者：sts.amazonaws.com


#### IAM ロールの作成
以下の内容の IAM ロールを作成する。

- 信頼ポリシー
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<AWSアカウントID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo:nkserveren26/aws_terraform:ref:refs/heads/main",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

- 付与する権限
  - EC2FullAccess
  - VPCFullAccess