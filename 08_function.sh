#!/usr/bin/env bash

say_hi() {
  local name="$1"
  echo "hi $name"
}

say_hi "qa"