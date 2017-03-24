#!/bin/bash

# Run a command in a docker container
function docker_execute {
  docker run --rm -v $(pwd):/src -w /src ibmcom/swift-ubuntu /bin/bash -c "$1"
}

# Build the application
function build {
  if [[ $1 == "docker" ]]; then
    echo "Building in a Docker container"
  docker_execute "swift build"
  fi

  if [[ $1 != "docker" ]]; then
    echo "Building locally"
    swift build -Xlinker -L/usr/local/lib
  fi
}

# Test the application
function test {
  if [[ $1 == "docker" ]]; then
    echo "Testing in a Docker container"
  docker_execute "swift test"
  fi

  if [[ $1 != "docker" ]]; then
    echo "Building locally"
    swift test -Xlinker -L/usr/local/lib
  fi
}

function shell {
  docker run --rm -it -v $(pwd):/src -w /src ibmcom/swift-ubuntu /bin/bash
}

# Use the first argument to determine what to do
case $1 in 
  build)
    build $2
  ;;
  test)
    test $2
  ;;
  shell)
    shell $2
  ;;
esac
