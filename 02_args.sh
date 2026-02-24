#!/usr/bin/env bash

echo "script: ${BASH_SOURCE[0]}"
echo "current_dir: $(pwd)"
echo "file_count: $(ls -1 2>/dev/null | wc -l)"