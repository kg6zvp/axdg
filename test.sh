#!/bin/bash

gprclean axdg.gpr
gprclean test/axdg-tests.gpr
gprbuild test/axdg-tests.gpr #-gnata
./test/bin/runner
