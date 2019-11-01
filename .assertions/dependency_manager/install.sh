#!/bin/bash
apt-package/install.sh g++
apt-package/install.sh cmake
apt-package/install.sh make
git/install.sh https://github.com/rockerbacon/assertions-test.git e6838d6adba46b7254d922567bccc1707e1840b4
systemlib/install.sh pthread
