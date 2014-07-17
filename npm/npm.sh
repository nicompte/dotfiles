#!/bin/bash

packages=(
bower
grunt-cli
gulp
yo
)

npm install -g n
n stable

for package in ${packages[@]} ; do
  npm install -g $package
done
