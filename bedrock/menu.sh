#!/bin/bash

SCRIPTS_DIR="/home/t0rque/git/minecraft/bedrock/scripts"

# Collect script list and base names
scripts=("$SCRIPTS_DIR"/*.sh)
names=()
for script in "${scripts[@]}"; do
  names+=("$(basename "$script")")
done

# Display numbered list in one or two columns
echo "Select a script to run:"

for ((i = 0; i < ${#names[@]}; i++)); do
  left="[$((i + 1))] ${names[i]}"
  right=""
  if [[ $i -lt 12 && $((i + 13)) -lt ${#names[@]} ]]; then
    right="[$((i + 13))] ${names[i + 12]}"
    printf "%-30s %s\n" "$left" "$right"
  elif [[ $i -ge 12 ]]; then
    break
  else
    printf "%s\n" "$left"
  fi
done

# Prompt for choice
echo
read -p "Enter the number of the script to run: " choice
index=$((choice - 1))

# Validate and run
if [[ $index -ge 0 && $index -lt ${#scripts[@]} ]]; then
  echo "Running ${names[$index]}..."
  bash "${scripts[$index]}"
else
  echo "Invalid selection"
fi
