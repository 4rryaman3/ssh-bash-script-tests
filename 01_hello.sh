#!/usr/bin/env bash

_return_or_exit() {
  local code="$1"
  return "$code" 2>/dev/null || exit "$code"
}

echo "hello from endpoint"
echo "host: $(hostname)"
echo "user: $(whoami)"
echo "time: $(date)"