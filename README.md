# UBO Layout template for Duisburg-Essen
This is an experimental proof-of-concept layer for re-designing the original UBO-Application (https://github.com/MyCoRe-Org/ubo) that is built on top of MyCoRe (http://www.mycore.de/).


## Installation instructions
This layer is built with the standard maven build process, which yields a standalone JAR file that needs to be placed inside the "lib"-directory of the parent project (in this case UBO).
For convenience, the "dir"-parameter can be used to automate the placement of the JAR file, for example: "clean install -Ddir=..\..\AppData\Local\MyCoRe\ubo\lib" (Windows).