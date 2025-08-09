#include <stdio.h>

extern int asm_add(int a, int b);
extern int asm_sub(int a, int b);
extern int asm_mul(int a, int b);
extern int asm_div(int a, int b);

int main() {
    int a, b, result;
    char op;

    printf("Enter first number: ");
    scanf("%d", &a);

    printf("Enter operation (+ - * /): ");
    scanf(" %c", &op);

    printf("Enter second number: ");
    scanf("%d", &b);

    switch (op) {
        case '+':
            result = asm_add(a, b);
            break;
        case '-':
            result = asm_sub(a, b);
            break;
        case '*':
            result = asm_mul(a, b);
            break;
        case '/':
            if (b == 0) {
                printf("Error: Division by zero!\n");
                return 1;
            }
            result = asm_div(a, b);
            break;
        default:
            printf("Error: Invalid operation!\n");
            return 1;
    }

    printf("Result: %d\n", result);
    return 0;
}
