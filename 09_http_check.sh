#!/usr/bin/env bash

_return_or_exit() {
  local code="$1"
  return "$code" 2>/dev/null || exit "$code"
}

url="https://example.com"
if command -v curl >/dev/null 2>&1; then
  code="$(curl -s -o /dev/null -w "%{http_code}" "$url")"
  echo "url=$url status=$code"
else
  echo "curl not found"
  _return_or_exit 1
fi