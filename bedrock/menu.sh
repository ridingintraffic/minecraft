#!/bin/bash

SCRIPTS_DIR="/users/home/t0rque/git/minecraft/bedrock/scripts"

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
