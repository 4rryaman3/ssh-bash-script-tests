#!/usr/bin/env bash

_return_or_exit() {
  local code="$1"
  return "$code" 2>/dev/null || exit "$code"
}

in_file="/tmp/qa_file_write_example.txt"
if [[ -f "$in_file" ]]; then
  echo "reading: $in_file"
  cat "$in_file"
else
  echo "missing file: $in_file"
  _return_or_exit 1
fi