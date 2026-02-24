#!/usr/bin/env bash

value=10
if (( value > 5 )); then
  echo "value $value is greater than 5"
else
  echo "value $value is 5 or less"
fi