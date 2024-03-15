#include "ffigen_test_plugin.h"

char *hello_world()
{
  return "Hello, World!";
}
char *hello_world_delayed()
{
#if _WIN32
  Sleep(1000);
#else
  sleep(1);
#endif
  return "Hello, World!";
}
int add(int a, int b)
{
  return a + b;
}
int subtract(int a, int b)
{
  return a - b;
}
int multiply(int a, int b)
{
  return a * b;
}
int divide(int a, int b)
{
  return a / b;
}
int *add2(int *a, int *b)
{
  int *result = (int *)malloc(sizeof(int));
  *result = *a + *b;
  return result;
}
char *reverse(char *str)
{
  int length = 0;
  char *temp = str;
  while (*temp != '\0')
  {
    length++;
    temp++;
  }
  char *result = (char *)malloc(length + 1);
  for (int i = 0; i < length; i++)
  {
    result[i] = str[length - i - 1];
  }
  result[length] = '\0';
  return result;
}
