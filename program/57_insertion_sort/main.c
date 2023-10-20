#include <stdio.h>
#include <stdlib.h>


void insertion_sort(int* arr, int len) {
    int i = 0;
    while (i < len) {
        int mem = arr[i];
        int j = i - 1;
        while (j >= 0 && mem < arr[j]) {
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = mem;
        i++;
    }
}


int main(void)
{
    int a[1] = {1};
    int len = 1;


    insertion_sort(a, len);
    for (int i = 0; i < len; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
    return EXIT_SUCCESS;
}
