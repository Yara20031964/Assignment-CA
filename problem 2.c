#include<stdio.h>
int main(){
    int arr[10];
    int i=0;
    int count=0;
    for(i=0;i<10;i++){
        scanf("%d", &arr[i]);
        if(arr[i]%2==0){
            ++count;
        }
    }
    printf("Count of even numbers is: %d", count);
    return 0;

}