import 'dart:io';

class Calculator {
  int add(int a, int b) => a + b;

  double divide(int a, int b) {
    if (b == 0) {
      throw ArgumentError('Division by zero');
    }
    return a / b;
  }
}

Future<void> main() async {
  print('Hello from Dart SonarQube example!');

  final calculator = Calculator();
  final result = calculator.add(5, 3);
  print('5 + 3 = $result');

  try {
    final result = calculator.divide(10, 0);
    print('Result: $result');
  } on ArgumentError catch (e) {
    print('Error: ${e.message}');
  }

  final file = File('example.txt');
  try {
    final content = await file.readAsString();
    print(content);
  } on FileSystemException catch (e) {
    print('File error: ${e.message}');
  }
}