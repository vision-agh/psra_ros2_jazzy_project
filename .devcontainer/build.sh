#!/bin/bash
set -e
cd /home/developer/ros2_ws

# Hide harmless "Unbuilt egg for pytest-repeat" warning from Ubuntu's setuptools
export PYTHONWARNINGS="ignore:Unbuilt egg:UserWarning"

# Set the default build type
BUILD_TYPE=RelWithDebInfo
colcon build \
        --merge-install \
        --symlink-install \
        --cmake-args "-DCMAKE_BUILD_TYPE=$BUILD_TYPE" "-DCMAKE_EXPORT_COMPILE_COMMANDS=On" \
        -Wall -Wextra -Wpedantic
