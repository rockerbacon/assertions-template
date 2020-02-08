#!/bin/bash
source apt-package/install.sh cmake
source apt-package/install.sh make
source apt-package/install.sh g++
source git/install.sh rockerbacon/assertions-test --local-only --version v2.2
source git/install.sh rockerbacon/cpp-bash --local-only --version v1.1
