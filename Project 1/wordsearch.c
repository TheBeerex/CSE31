// Author: TheBeerex

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

// Utility function to convert a char to uppercase if lowercase
char* charToUpper(char* str) {
    if (*str >= 'a' && *str <= 'z') {
        *str = *str - 'a' + 'A'; 
    }
    return str;
}

// Utility function to convert a string to upper
char* strToUpper(char* str) {
    int len = strlen(str);
    int i;

    for (i = 0; i < len; i++) {
        charToUpper(str+i);
    }
    return str;
}

// Utility function to print 2D int array in proper formatting
void print2DIntArr(int** arr) {
    for(int i = 0; i < bSize; i++) {
        for(int j = 0; j < bSize; j++) {
            printf("%d\t", *(*(arr+i)+j));
        }
        printf("\n");
    }
}


void printPuzzle(char** arr) {
	// This function will print out the complete puzzle grid (arr). 
    // It must produce the output in the SAME format as the samples 
    // in the instructions.
    // Your implementation here...
    for(int i = 0; i < bSize; i++) {
        for(int j = 0; j < bSize; j++) {
            printf("%c ", *(*(arr+i)+j));
        }
        printf("\n");
    }
    printf("\n");
}


// Recursive function that searches for a sufficient local path of nearby elements that make the word
int searchPath(char** arr, int x, int y, char* word, int currentIndex, int** foundArray) {
    if (currentIndex >= strlen(word)){ // Base case1: reached end of the path needed to take to find the word.
        return currentIndex;
    } else {
        // Check surrounding items, [(x-1,y-1):(x+1,y+1)], for next character of word
        for (int i = x-1; i <= x+1; i++) {
            for (int j = y-1; j <= y+1; j++) {
                // if found the character, search for path containing next character of word
                if ( !(i < 0 || i >= bSize || j < 0 || j >= bSize || (i==x && j==y) ) && *(*(arr + i) + j) == *(word+currentIndex)) {
                    if ( searchPath(arr, i, j, word, currentIndex+1, foundArray) != -1) { // if we found a full path
                        *(*(foundArray+i)+j) = *(*(foundArray+i)+j) * 10 + currentIndex+1; // write current location to foundArray
                        return currentIndex;
                    }
                }
            }
        }
        return -1; // Base case2: did not find a path
    }
}


void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the 
    // word appears in arr, it will print out a message and the path 
    // as shown in the sample runs. If not found, it will print a 
    // different message as shown in the sample runs.
    // Your implementation here...

    // Convert given word to uppercase
    word = strToUpper(word);

    // Found array declaration and filling with default 0s
    int i, j;
    
    int** found = (int**)malloc(bSize * sizeof(int*));
    
    for (i = 0; i < bSize; i++) {
        *(found + i) = (int*)malloc(bSize * sizeof(int));
        for (j = 0; j < bSize; j++) {
            *(*(found + i) + j) = 0;
        }
    }

    int hasWord = 0;
    // Search puzzle for coords of first letter of word and attempt to find a local path that 
    for (i = 0; i < bSize; i++) {
        for (j = 0; j < bSize; j++) {
            if (*(*(arr + i) + j) == *word) { // If we found the letter, try searching for a path
                if ( searchPath(arr, i, j, word, 1, found) != -1) { // If we found a path
                    hasWord = 1;
                    *(*(found+i)+j) = *(*(found+i)+j) * 10 + 1;
                }
            }
        }
    }

    // If we have found the word, print the path map found
    if(hasWord){
        printf("Word found!\nPrinting the search path:\n\n");
        print2DIntArr(found);
    } else
        printf("Word not found!\n");
}
