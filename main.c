#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "m1p1.h"

#define BUF_SIZE 1024

int main(int argc, char *argv[])
{
  char buffer[BUF_SIZE];
  size_t contentSize = 1; // includes NULL
  /* Preallocate space.  We could just allocate one char here,
  but that wouldn't be efficient. */
  char *content = malloc(sizeof(char) * BUF_SIZE);
  if (content == NULL)
  {
    // Failed to allocate content
    exit(1);
  }
  content[0] = '\0'; // make null-terminated
  while (fgets(buffer, BUF_SIZE, stdin))
  {
    char *old = content;
    contentSize += strlen(buffer);
    content = realloc(content, contentSize);
    if (content == NULL)
    {
      // Failed to reallocate content
      free(old);
      exit(2);
    }
    strcat(content, buffer);
  }

  printf("Content before:\n%s", content);
  // m1p1(content);
  printf("Content after:\n%s", content);

  free(content);

  return 0;
}
