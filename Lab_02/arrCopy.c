#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void printArr(int *a, int size, char *name){
	printf("%s array's contents:", name);
    for(int i = 0; i < size; i++){
        printf(" %d", *(a+i));
    }
    printf("\n");
}

int* arrCopy(int *a, int size){
	int* newArr = (int*) calloc(size, sizeof(int));
    for(int i = size-1; i >= 0; i--) {
        *(newArr+(size-1-i)) = *(a+i);
    }
    return newArr;
}

int main(){
    int n;
    int *arr;
    int *arr_copy;
    int i;
    printf("Enter the size of array you wish to create: ");
    scanf("%d", &n);

    //Dynamically create an int array of n items
    arr = (int*) calloc(n, sizeof(int));

    //Ask user to input content of array
    for (i = 0; i < n; i++) {
    	printf("Enter the array element #%d: ", i+1);
        scanf("%d", (arr+i));
    }
	
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	//Print original array
    printArr(arr, n, "Original");

	//Copy array with contents in reverse order
    arr_copy = arrCopy(arr, n);

	//Print new array
    printArr(arr_copy, n, "Copied");

    printf("\n");

    return 0;
}