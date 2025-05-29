import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_finan/main.dart'; // Ajuste para o nome do seu pacote

void main() {
  testWidgets('Teste inicial do ExpensesApp', (WidgetTester tester) async {
    // 1. Construa nosso widget
    await tester.pumpWidget(const ExpensesApp());

    // 2. Verifique se o AppBar está presente
    expect(find.byType(AppBar), findsOneWidget);

    // 3. Verifique se o texto do título está correto
    expect(find.text('Despesas Pessoais'), findsOneWidget);

    // 4. Verifique se o Card do gráfico está presente
    expect(find.byType(Card), findsOneWidget);
  });
}