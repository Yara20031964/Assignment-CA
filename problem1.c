#include<stdio.h>
int main(){
    //another test case
    // 10, 31, 5, 7, 11, 3, 8, 40, 12, 4
    int array[]={11, 2, 3, 7, 5, 10, 9, 22, 6, 1};
    int min=array[0];
    for(int i=1; i<10; i++)
    {
        if(array[i]<min)
            min=array[i];
    }
    printf("Min element is: ");
    printf("%d",min );

    return 0;
}
