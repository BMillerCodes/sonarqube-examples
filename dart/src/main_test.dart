import 'main.dart';

void main() {
  final calculator = Calculator();

  final addResult = calculator.add(2, 3);
  assert(addResult == 5, 'Expected 5');

  final divideResult = calculator.divide(10, 2);
  assert(divideResult == 5.0, 'Expected 5.0');

  bool caught = false;
  try {
    calculator.divide(1, 0);
  } on ArgumentError {
    caught = true;
  }
  assert(caught, 'Should have thrown');

  print('All tests passed!');
}