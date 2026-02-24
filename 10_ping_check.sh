#!/usr/bin/env bash

_return_or_exit() {
  local code="$1"
  return "$code" 2>/dev/null || exit "$code"
}

target="8.8.8.8"
if command -v ping >/dev/null 2>&1; then
  ping -c 2 "$target"
else
  echo "ping not found"
  _return_or_exit 1
fi