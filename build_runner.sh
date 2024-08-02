#!/bin/bash

function run() {
  if command -v fvm &> /dev/null
  then
    flutter_command="fvm flutter"
    dart_command="fvm dart"
  else
    flutter_command=flutter
    dart_command=dart
  fi

  eval "$flutter_command clean"
  eval "$flutter_command pub get"
  eval "$dart_command run build_runner build --delete-conflicting-outputs"
  eval "$dart_command run pigeon --input pigeons/*"
}

pwd
run

exit
