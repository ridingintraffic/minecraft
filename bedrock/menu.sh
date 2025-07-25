#!/bin/bash

SCRIPTS_DIR="/home/t0rque/git/minecraft/bedrock/scripts"

# Collect script list and base names
scripts=("$SCRIPTS_DIR"/*.sh)
names=()
for script in "${scripts[@]}"; do
  names+=("$(basename "$script")")
done

echo "Select a script to run:"

# Calculate number of rows for 2-column layout
total=${#names[@]}
half=$(( (total + 1) / 2 ))

for ((i = 0; i < half; i++)); do
  left_index=$i
  right_index=$((i + half))

  left="[$((left_index + 1))] ${names[left_index]}"

  if [[ $right_index -lt $total ]]; then
    right="[$((right_index + 1))] ${names[right_index]}"
    printf "%-40s %s\n" "$left" "$right"
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
