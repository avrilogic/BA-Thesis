file(REMOVE_RECURSE
  "libcustomlib_shared.pdb"
  "libcustomlib_shared.so"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/customlib_shared.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
