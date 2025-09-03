import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tic_tac_toe_app/main.dart'; // アプリのエントリーポイント

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // テストバインディングの初期化

  testWidgets('ボタンを押してテキストを変更する', (WidgetTester tester) async {
    // テスト対象のアプリを起動
    await tester.pumpWidget(const TicTacToeApp());

    // 初期状態で表示されているテキストを確認
    expect(find.text('人 vs 人'), findsOneWidget);

    // ボタンをタップして画面遷移を行う
    await tester.tap(find.text('人 vs 人'));
    await tester.pumpAndSettle();

    // TicTacToeGame画面に遷移したことを確認します。
    expect(find.byType(TicTacToeGame), findsOneWidget);

    // 遷移後の画面のisVsComputerプロパティがfalseであることを確認します。
    final ticTacToeGameWidget = tester.widget<TicTacToeGame>(
      find.byType(TicTacToeGame),
    );
    expect(ticTacToeGameWidget.isVsComputer, isFalse);
  });
}
