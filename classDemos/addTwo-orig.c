include <stdio.h>
include <stdlib.h>
int main( int n, char* args[]) {
  int num1, num2;

  printf ("Number of command line arguments is %d\n", n);
  num1 = atoi(args[1]);
  num2 = atoi(args[2]);

  printf ("The sum of %d and %d is %d\n", num1, num2, num1 + num2);
  return 0;
}
