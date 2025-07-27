# asdf-redmine

[RedmineCLI](https://github.com/arstella-ltd/RedmineCLI) plugin for the [asdf version manager](https://asdf-vm.com) and [mise](https://github.com/jdx/mise).

RedmineCLIは、Redmineチケットを管理するためのGitHub CLI風のコマンドラインインターフェースツールです。

## 必要な依存関係

- `bash`, `curl`, `unzip` - これらは通常、POSIX標準のOSにプリインストールされています。

## インストール

### asdfを使用する場合

プラグイン:

```shell
asdf plugin add redmine
# または
asdf plugin add redmine https://github.com/arstella-ltd/asdf-redmine.git
```

redmine:

```shell
# 最新バージョンを表示
asdf list-all redmine

# 特定のバージョンをインストール
asdf install redmine latest

# グローバルバージョンを設定
asdf global redmine latest

# プロジェクトのバージョンファイルに記載されたバージョンをインストール
asdf install
```

### miseを使用する場合

```shell
# プラグインを追加
mise plugin add redmine https://github.com/arstella-ltd/asdf-redmine.git

# 最新バージョンをインストール
mise install redmine@latest

# グローバルに使用
mise global redmine@latest

# プロジェクト固有の設定
mise use redmine@0.8.0
```

## 使用方法

[asdfのドキュメント](https://asdf-vm.com/guide/getting-started.html)を確認してください。

## サポートされているプラットフォーム

- Linux (x64, ARM64)
- macOS (Intel, Apple Silicon)
- Windows (x64) ※ WSL経由での使用を推奨

## バージョン更新時の注意

RedmineCLIのバージョン更新（例：0.8.1から0.8.2）に伴うasdf-redmineプラグインの更新は不要です。
プラグインは自動的に新しいバージョンのダウンロードURLを生成するため、特別な対応は必要ありません。

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/arstella-ltd/asdf-redmine/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Arstella Ltd](https://github.com/arstella-ltd/)