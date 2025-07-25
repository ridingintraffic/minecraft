#!/bin/bash

SCRIPTS_DIR="$pwd/scripts"

echo "Select a script to run:"
select script in "$SCRIPTS_DIR"/*.sh; do
  if [[ -n "$script" ]]; then
    echo "Running $script..."
    bash "$script"
    break
  else
    echo "Invalid selection"
  fi
done
