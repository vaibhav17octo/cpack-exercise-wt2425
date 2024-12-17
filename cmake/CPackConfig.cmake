set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "gilvv")
set(CPACK_PACKAGE_CONTACT "Vaibhav Gil<st191590@stud.uni-stuttgart.de>")

set(CPACK_PACKAGE_HOMEPAGE_URL "https://github.com/Menkalian/cpack-exercise-wt2425")
set(CPACK_GENERATOR "TGZ;DEB")
set(CPACK_STRIP_FILES TRUE)

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "C++ code testing cpack and cmake along with packaging for Software simulation Engineering.")
 string(CONCAT CPACK_PACKAGE_DESCRIPTION
     "#${PROJECT_NAME}\n"
    "Sample C++ code.\n"
    "This project includes multiple dependencies,\n"
    "and was built using cpack, cmake, and make"
 )

 include(CPack)