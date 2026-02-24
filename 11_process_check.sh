#!/usr/bin/env bash

_return_or_exit() {
  local code="$1"
  return "$code" 2>/dev/null || exit "$code"
}

proc_name="sshd"
if ps -ef | grep -v grep | grep -q "$proc_name"; then
  echo "process found: $proc_name"
else
  echo "process not found: $proc_name"
  _return_or_exit 1
fi