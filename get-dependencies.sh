#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm cmake qt5-base qt5-multimedia qt5-script qt5-serialport qt5-tools

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

make-aur-package qt5-websockets

echo "Building Candle..."
echo "---------------------------------------------------------------"
REPO="https://github.com/Denvi/Candle"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --depth 1 "$REPO" ./Candle
echo "$VERSION" > ~/version

cmake -S ./Candle -B build \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/opt/candle
cmake --build build
cmake --install build
