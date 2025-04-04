#!/bin/bash

# Fail the script if anything fails
set -e

echo "Downloading Flutter..."
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable
fi
export PATH="$PATH:`pwd`/flutter/bin"

echo "Flutter version:"
flutter --version

echo "Enabling web..."
flutter config --enable-web

echo "Getting dependencies..."
flutter pub get

echo "Building web..."
flutter build web

# Overwrite the generated favicon with DeepState logo
cp build/web/deepstate.png build/web/favicon.png
