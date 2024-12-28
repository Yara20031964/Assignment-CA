#include <stdio.h>

void DecimalToOther(int decimal, int system) {
    if (system < 2 || system > 16) {
        printf("Unsupported system. Please choose a base between 2 and 16.\n");
        return;
    }

    // Handle zero case
    if (decimal == 0) {
        printf("Result: 0\n");
        return;
    }

    char digits[] = "0123456789ABCDEF";
    char result[64];  // Array to store the result (sufficient size for most conversions)
    int i = 0;

    // Perform the conversion
    while (decimal > 0) {
        result[i] = digits[decimal % system];
        decimal /= system;
        i++;
    }

    // Print the result in reverse order
    printf("Result: ");
    for (int j = i - 1; j >= 0; j--) {
        printf("%c", result[j]);
    }
    printf("\n");
}

int main() {
    int decimal, system;
    printf("Enter a decimal number: ");
    scanf("%d", &decimal);
    printf("Enter the system (from 2 to 16): ");
    scanf("%d", &system);

    DecimalToOther(decimal, system);
    
    return 0;
}
