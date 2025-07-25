#!/bin/bash

# List of hostile mobs
mobs=(
  blaze cave_spider
  creeper drowned
  elder_guardian endermite
  evoker ghast
  guardian hoglin
  husk magma_cube
  phantom piglin
  piglin_brute pillager
  ravager shulker
  silverfish skeleton
  slime spider
  stray vex
  vindication_illager vindicator
  warden witch
  wither wither_skeleton
  zoglin zombie
  zombie_villager zombified_piglin
  enderman ender_dragon
)

# Print header
echo "Select a mob to kill:"

# Display in two columns with numbered options
for ((i=0; i<${#mobs[@]}; i+=2)); do
  left="$((i+1)). ${mobs[i]}"
  right=""
  if [[ $((i+1)) -lt ${#mobs[@]} ]]; then
    right="$((i+2)). ${mobs[i+1]}"
  fi
  printf "%-30s %s\n" "$left" "$right"
done

# Prompt for selection
echo
read -p "Enter the number of the mob to kill: " choice

# Validate and map to mob
index=$((choice - 1))
if [[ $index -ge 0 && $index -lt ${#mobs[@]} ]]; then
  selected_mob="${mobs[$index]}"
  echo "Killing all: $selected_mob"
  docker exec bds send-command "kill @e[type=$selected_mob]"
else
  echo "Invalid selection. Exiting."
fi
