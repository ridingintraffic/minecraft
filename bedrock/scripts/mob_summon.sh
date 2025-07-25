#!/bin/bash

# Define mob categories
hostile_mobs=(
  blaze cave_spider creeper drowned elder_guardian endermite evoker ghast guardian
  hoglin husk magma_cube phantom piglin piglin_brute pillager ravager shulker
  silverfish skeleton slime spider stray vex vindication_illager vindicator warden
  witch wither wither_skeleton zoglin zombie zombie_villager zombified_piglin
)

peaceful_mobs=(
  allay axolotl bat cat chicken cow donkey fox frog glow_squid horse iron_golem
  llama mooshroom mule ocelot panda parrot pig sheep snow_golem squid strider
  turtle villager wandering_trader wolf
)

players=(claracorn4105 lukey2894 ridingintraffic)

echo "1. Choose mob category:"
select category in "Hostile" "Not Hostile"; do
  if [[ $category == "Hostile" ]]; then
    mob_list=("${hostile_mobs[@]}")
    break
  elif [[ $category == "Not Hostile" ]]; then
    mob_list=("${peaceful_mobs[@]}")
    break
  else
    echo "Invalid selection."
  fi
done

# List all mobs in two columns if more than 20
echo
echo "2. Choose a mob to summon:"

half=$(( (${#mob_list[@]} + 1) / 2 ))

for ((i=0; i<half; i++)); do
  left_index=$i
  right_index=$((i + half))

  left_entry=$(printf "%3d. %-20s" $((left_index + 1)) "${mob_list[left_index]}")

  if [[ $right_index -lt ${#mob_list[@]} ]]; then
    right_entry=$(printf "%3d. %s" $((right_index + 1)) "${mob_list[right_index]}")
    echo "$left_entry $right_entry"
  else
    echo "$left_entry"
  fi
done

read -p "Enter the number of the mob: " mob_choice
mob_index=$((mob_choice - 1))
if [[ $mob_index -ge 0 && $mob_index -lt ${#mob_list[@]} ]]; then
  mob="${mob_list[$mob_index]}"
else
  echo "Invalid mob choice."
  exit 1
fi

# Number to summon
read -p "3. How many $mob do you want to summon? " count
if ! [[ "$count" =~ ^[0-9]+$ ]]; then
  echo "Please enter a valid number."
  exit 1
fi

# Choose player
echo
echo "4. Choose which player to summon near:"
select target_player in "${players[@]}"; do
  if [[ -n "$target_player" ]]; then
    break
  else
    echo "Invalid player."
  fi
done

# Run summon command loop
echo
echo "Summoning $count x $mob near $target_player..."

for ((i=1; i<=count; i++)); do
  docker exec bds send-command "execute as $target_player at @s run summon $mob ~2 ~ ~"
done
