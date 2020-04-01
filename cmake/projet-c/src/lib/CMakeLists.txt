file(GLOB LIB . *.c)

add_library(lib-calculator ${LIB})

install(TARGETS lib-calculator DESTINATION lib)
