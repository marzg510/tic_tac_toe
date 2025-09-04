# tic_tac_toe

Tic Tac Toe built by Flutter

## Dev

### run

cd tic_tac_toe_app
flutter run -d web-server --web-port 3000

### create

flutter create tic_tac_toe_app

### Test with Real Devices

- 開発者モードへは、ビルド番号7回タップで移行できる
- USBデバッグモードをONにする

### リリースビルド

```shell
flutter build appbundle
```

### Building Environment

#### Web Only(VS Code etc)

Constructing...

#### VS Code on Windows(for App Build)

- [公式サイト](https://docs.flutter.dev/get-started/install)
- [公式手順](https://docs.flutter.dev/get-started/install/windows/mobile)

1. Install Flutter
2. Install Android Studio
3. Install Flutter Plugin
4. Create Virtual Device

##### Install Flutter

###### Install Flutter Extention

- [VS Code拡張機能](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [初めてのFlutterアプリ](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=ja#0)

##### Install Android Studio

1. ダウンロード＆インストール
2. SDK Managerから API35,コマンドラインツール19(latest)をインストール

##### Create Virtual Device

##### Androidライセンスに同意する


#### 署名

``` PowerShell
&"D:\Program Files\Android\Android Studio\jbr\bin\keytool" `
  -genkey -v -keystore .\upload-keystore.jks `
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
  -alias upload
```
