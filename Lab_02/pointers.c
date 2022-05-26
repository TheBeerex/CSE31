#include <stdio.h>

int main() {
    int x=2, y=7, *px=&x, *py=&y;
    int arr[10] = {0,1,2,3,4,5,6,7,8,9};

    printf("%p ", px);
    printf("%p ", &x);
    printf("%d ", *px);
    printf("%d ", x);
    
    printf("%p ", py);
    printf("%p ", &y);
    printf("%d ", *py);
    printf("%d ", y);

    printf("%p ", arr);
    printf("%p ", &arr[0]);

    for (int i = 0; i < 10; i++) {
        printf("%d ", *(arr+i));
    }

    return 0;
}