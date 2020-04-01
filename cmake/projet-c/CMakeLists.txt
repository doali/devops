cmake_minimum_required(VERSION 2.8)

project(calculator C)

add_subdirectory(include)
add_subdirectory(src)

include_directories(include)

enable_testing()

add_test(test_1_add src/calculator 0 + 0) 
add_test(test_2_sub src/calculator 1 - 1) 
add_test(test_3_mul src/calculator 0 * 1) 
add_test(test_4_div src/calculator 0 / 1)
add_test(test_5_add src/calculator 0 + 1) 
add_test(test_6_sub src/calculator 2 - 1) 
add_test(test_7_mul src/calculator 1 * 1) 
add_test(test_8_div src/calculator 1 / 1)
