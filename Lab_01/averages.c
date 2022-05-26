// Author: TheBeerex
// averages.c

#include <stdio.h>
#include <stdbool.h>
int main() {
    int avg_even=0, avg_odd=0, count_even=0, count_odd=0, input;
    while (1) {
        printf("Please enter the %ith integer: ", count_even + count_odd + 1);
        scanf("%d", &input);
        if (input == 0)
            break;
        else {
            int mod, sum=0, real=input;
            if(input < 0)
                input = input * -1;
            
            while (input > 0) {
                mod = input % 10;
                sum = sum + mod;
                input = input / 10;
            }
            
            if (sum % 2 == 0) {
                count_even++;
                avg_even = avg_even + real;
            } else {
                count_odd++;
                avg_odd = avg_odd + real;
            }
        }
    }
    if(count_even+count_odd == 0)
        printf("There is no average to compute.\n");
    else {
        if(count_even != 0) {
            double mean_even = (double) avg_even / count_even;
            printf("Average of inputs whose digits sum up to an even number: %f\n", mean_even);
        }
        if(count_odd != 0) {
            double mean_odd = (double) avg_odd / count_odd;
            printf("Average of inputs whose digits sum up to an odd number: %f\n", mean_odd);
        }
    }
    return 0;
}
