cmake_minimum_required(VERSION 2.8)

project("Titi")

message(STATUS "before add_exec")

add_executable(titi titi.cpp)

target_link_libraries(titi titou)
message(WARNING "after add_exec")
message(AUTHOR_WARNING "me !!")

message("cmake --trace ..")
message("make VERBOSE=1")

message(${Titi_SOURCE_DIR})
message(${CMAKE_SOURCE_DIR})
message("---")
message(${Titi_BINARY_DIR})
message(${CMAKE_BINARY_DIR})

add_subdirectory(titou)

SET(recursif " ")
SET(recursif ${recursif} "a")
SET(recursif ${recursif} "b")
SET(recursif ${recursif} "c")

message("append recursif" ${recursif})

set(test_list a b c d e f)
foreach(element ${test_list})
	message(${element})
endforeach()
message(${test_list})

set(ENV{env_titou} test)
message($ENV{env_titou})
