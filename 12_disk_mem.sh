#!/usr/bin/env bash

echo "disk usage:"
df -h /
echo
echo "memory usage:"
if command -v free >/dev/null 2>&1; then
  free -h
else
  echo "free command not found"
fi