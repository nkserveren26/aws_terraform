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

実行操作に応じて、IAMロールに付与する権限を設定する。

### Github Actions の設定
#### Github Actions でやること
- Terraform のセットアップ
```yaml
- name: Setup Terraform
  uses: hashicorp/setup-terraform@v3
```

- 作成した IAM ロールで認証
  - `aws-actions/configure-aws-credentials@v1` を使用する。
  - with 内で以下を設定
    - aws-region：対象リージョンを指定
    - role-to-assume：使用する IAM ロールを指定
```yaml
- name: Authenticate IAM Role
  uses: aws-actions/configure-aws-credentials@v1
  with:
    aws-region: 'ap-northeast-1'
    role-to-assume: 'arn:aws:iam::xxxxxxxxx:role/<IAMロール名>'
```

- `terraform init` コマンド実行
```yaml
- name: Terraform Init
  run: terraform init
```

- `terraform plan` コマンド実行
  - 現在のインフラ状態と Terraform 定義との差分を確認するコマンド
  - `terraform apply` 実行前の事前確認として利用される
  - 作成・変更・削除されるリソースの差分を出力する
  - state ファイルと実環境を元に差分を算出する
- `terraform apply` コマンド実行
  - Terraform 定義に基づき、インフラリソースの作成・変更・削除を実行するコマンド
  - `terraform plan` で確認した差分を実際の環境に反映する
  - 実行後、state ファイルが最新の状態に更新される