// Author: TheBeerex
// punishment.c

#include <stdio.h>

int main(){
    int lines, typo, i;
    while (1) {
        printf("Enter the number of times to repeat the punishment phrase: ");
        scanf("%i", &lines);
        if (lines < 1) {
            printf("You entered an invalid value for the number of repetitions!\n");
        } else {
            break;
        }
    }

    while (1) {
        printf("Enter the repetition line where you want to introduce the typo: ");
        scanf("%i", &typo);
        if (typo > 0 && typo <= lines) {
            break;
        } else {
            printf("You entered an invalid value for the typo placement!\n");
        }
    }

    for (i = 1; i <= lines; i++) {
        if (i==typo) {
            printf("Progranming in c is phun!\n");
        } else {
            printf("Programming in C is fun!\n");
        }
    }
    return 0;
}