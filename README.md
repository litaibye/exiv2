# exiv2TestOsxIntegration
Test integration of exiv2 library to Mac OSx application
The source of exiv2 dynamic library downloaded from http://www.exiv2.org/

The main reason of this project was determination of xCode project settings to build with exiv2 c++ dylib inside.

the test project reads exiv data from bundled image
using bridge ObjC++ file between c++ exiv2 library and other ObjC code.
for swift projects you could add TextExiv file to your bridging-header to use it in swift also.
