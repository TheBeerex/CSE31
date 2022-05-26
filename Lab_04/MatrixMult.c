
#include <stdio.h>
#include <malloc.h>

int** matMult(int **a, int **b, int size) {
	// (4) Implement your matrix multiplication here. You will need to create a new matrix to store the product.
	int i=0, j=0;

	//Create Output Array
	int** matOut;
	matOut = (int**)malloc(size * sizeof(int*));
	for (i=0; i<size; i++) {
		*(matOut+i) = (int*)malloc(size * sizeof(int));
	}
	for (i=0; i<size; i++) {
		for (j=0; j<size; j++) {
			*(*(matOut+i)+j) = (int) 0;
		}
	}

	// Multiply matrices, outputting to matOut

	for (i=0; i<size; i++) {
		for (j=0; j<size; j++) {
			int product = 0;
			for (int k = 0; k < size; k++)
				product += *(*(a+i)+k) * *(*(b+k)+j);
			*(*(matOut+i)+j) = product;
		}
	}

	return matOut;

}

void printArray(int **arr, int n) {
	// (2) Implement your printArray function here
	int i=0, j=0;

	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			printf("%d;", *(*(arr+i)+j));
		}
		printf("\n");
	}
}

int main() {
	int n = 5;
	int **matA, **matB, **matC;
	// (1) Define 2 (n x n) arrays (matrices). 
	int i=0, j=0;

	matA = (int**)malloc(n * sizeof(int*));

	for (i=0; i<n; i++) {
		*(matA+i) = (int*)malloc(n * sizeof(int));
	}
	
	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			*(*(matA+i)+j) = i+j;
		}
	}


	matB = (int**)malloc(n * sizeof(int*));

	for (i=0; i<n; i++) {
		*(matB+i) = (int*)malloc(n * sizeof(int));
	}

	for (i=0; i<n; i++) {
		for (j=0; j<n; j++) {
			*(*(matB+i)+j) = i+j;
		}
	}

	// (3) Call printArray to print out the 2 arrays here.
	printArray(matA,n);
	printf("\n");

	printArray(matB,n);
	printf("\n");
	
	// (5) Call matMult to multiply the 2 arrays here.
	matC = matMult(matA, matB, n);
	
	// (6) Call printArray to print out resulting array here.
	printArray(matC,n);

    return 0;
}