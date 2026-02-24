#!/usr/bin/env bash

out_file="/tmp/qa_file_write_example.txt"
echo "qa check line at $(date)" > "$out_file"
echo "wrote file: $out_file"
wc -c "$out_file"