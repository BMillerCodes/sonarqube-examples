int multiply(int a, int b) => a * b;

bool isValid(int value) => value >= 0 && value <= 100;

String formatMessage(String message) => '[INFO] $message';

List<int> fibonacci(int n) {
  if (n <= 0) return [];
  if (n == 1) return [1];

  final list = [1, 1];
  for (int i = 2; i < n; i++) {
    list.add(list[i - 1] + list[i - 2]);
  }
  return list;
}