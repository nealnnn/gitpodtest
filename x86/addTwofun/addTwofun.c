#include <stdio.h>

// Add the two integer parameters and return the result
int addTwofun (int a, int b)
  { return a + b;
  }

int main()
  { int x = 10;
    int y = 7;
    printf("The sum of 10 and 7 is: %d\n", addTwofun(x,y));
  }
