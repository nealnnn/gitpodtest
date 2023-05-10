#include <stdio.h>
#include <stdlib.h>
int main( int n, char* args[]) {
  int num1, num2, theMax;

  printf ("Number of command line arguments is %d\n", n);

  if (n != 3) {
    printf ("usage: ./max2in int int\n");
    return -1;
  }

  num1 = atoi(args[1]);
  num2 = atoi(args[2]);

  if (num1 > num2) {theMax = num1; }
  else { theMax = num2; }

  printf ("The max of %d and %d is %d\n", num1, num2, theMax);
  return 0;
}
