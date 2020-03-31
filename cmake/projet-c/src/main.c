#include "./../include/calculator.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void usage() { printf("Usage <number> <+|-|*|/> <number>\n"); }

void display(double d) { printf("%lf\n", d); }

int main(int argc, char *argv[]) {
  if (argc == 4) {
    const char *a = argv[1];
    const char *op = argv[2];
    const char *b = argv[3];
    double r = 0;

    if (strcmp(op, "+") == 0) {
      r = _add(atof(a), atof(b));
      display(r);
    } else if (strcmp(op, "-") == 0) {
      r = _sub(atof(a), atof(b));
      display(r);
    } else if (strcmp(op, "*") == 0) {
      r = _mul(atof(a), atof(b));
      display(r);
    } else if (strcmp(op, "/") == 0) {
      r = _div(atof(a), atof(b));
      display(r);
    } else {
      usage();
    }
  } else {
    usage();
  }
  return EXIT_SUCCESS;
}
