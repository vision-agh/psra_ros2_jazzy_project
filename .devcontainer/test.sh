#!/bin/bash
set -e
cd /home/developer/ros2_ws

if [ -f install/setup.bash ]; then source install/setup.bash; fi
colcon test --merge-install
colcon test-result
