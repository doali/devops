#include <iostream>

void say();

void add_msg(std::string msg) {
  std::cout << __func__ << std::endl;
  std::cout << msg << std::endl;
}

int main(int argc, char **argv) {
  std::cout << argv[0] << " is running !!" << std::endl;
  add_msg("...now !!");
  say();
}
