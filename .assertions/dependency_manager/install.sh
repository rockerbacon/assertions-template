#!/bin/bash
source apt-package/install.sh cmake
source apt-package/install.sh make
source apt-package/install.sh g++
source git/install.sh rockerbacon/assertions-test --local-only --version v2.2
