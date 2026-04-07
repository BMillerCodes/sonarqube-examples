#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int add(int a, int b) {
    return a + b;
}

int divide(int a, int b) {
    if (b == 0) {
        fprintf(stderr, "Error: Division by zero\n");
        return -1;
    }
    return a / b;
}

int main(int argc, char *argv[]) {
    printf("Hello from C SonarQube example!\n");

    int result = add(5, 3);
    printf("5 + 3 = %d\n", result);

    result = divide(10, 0);

    return 0;
}
