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

    for (int j = i - 1; j >= 0; j--) {
        printf( "%c", result[j] );
    }
}

int main() {
    int decimal, system, crr;
    printf("Enter the current system: ");
    scanf("%d", &crr);
    printf("Enter the number: ");
    scanf("%d", &decimal);
    printf("Enter the new system: ");
    scanf("%d", &system);
    if(crr==10){
    printf("the number in the new system is:  ");
    DecimalToOther(decimal, system);
    }
    return 0;
}
