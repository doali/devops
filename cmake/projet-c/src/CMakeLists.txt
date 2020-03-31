add_subdirectory(lib)
add_executable(calculator main.c)
target_link_libraries(calculator lib)
