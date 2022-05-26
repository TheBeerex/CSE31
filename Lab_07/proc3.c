#include<stdio.h>

int bar(int a, int b, int c) {
    return c - a << b;
}

int foo(int m, int n, int o) {
    int p = bar(m + n, n + o, o + m);
    int q = bar(m - o, n - m, 2 * n);
    return p + q;
}

int main() {
    int x = 2, y = 3, z = 4;
    z = x + y + z + foo(x, y, z);
    printf("%d\n", z);
    return 0;
}
