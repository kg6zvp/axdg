#!/bin/bash

dnf update
dnf install -y \
gcc-gnat fedora-gnat-project-common gprbuild \
ahven{,-devel} #testing
