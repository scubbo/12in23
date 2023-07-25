# CMake generated Testfile for 
# Source directory: /Users/scubbo/Code/12in23/fortran/hello-world
# Build directory: /Users/scubbo/Code/12in23/fortran/hello-world
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(hello-world_test "hello-world")
set_tests_properties(hello-world_test PROPERTIES  _BACKTRACE_TRIPLES "/Users/scubbo/Code/12in23/fortran/hello-world/CMakeLists.txt;67;add_test;/Users/scubbo/Code/12in23/fortran/hello-world/CMakeLists.txt;0;")
subdirs("testlib")
