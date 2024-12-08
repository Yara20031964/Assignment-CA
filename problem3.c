#include<stdio.h>
int main(){

      int array[]={1,2,3,4,5,6,7,8,9,10};
      double average=0;
        for(int i=0; i<10; i++)
            average+=array[i];
            printf("Average is:");
          printf("%.2f\n", average / 10);

      int array2[]={7,2,5,11,4,6,1,1,8,3};
      average=0;
        for(int i=0; i<10; i++)
            average+=array2[i];
          printf("Average is:");
          printf("%.1f\n", average / 10);    
  return 0; 
}
