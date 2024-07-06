#!/usr/bin/env bash
set -euo pipefail

# all credits goes to https://github.com/OwenVey

thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

jqScript='map(
  {
    InternalName:     .internalName,
    FriendlyName:     .name,
    Description:      (.description // ""),
    ElementType1:     (.elementType1 // ""),
    ElementType2:     (.elementType2 // ""),
    FoodAmount:       (.foodAmount // ""),
    CraftSpeed:       (.craftSpeed // ""),
    PartnerSkillName: (.partnerSkill.name // ""),
    PartnerSkillDesc: (.partnerSkill.description // ""),
    Rarity:           (.rarity // ""),
    RunSpeed:         (.runSpeed // ""),
    Size:             (.size // ""),
    TransportSpeed:   (.transportSpeed // "")
  }
)'

array1url='https://raw.githubusercontent.com/OwenVey/palwiz/main/src/data/normal-pals.json'
array2url='https://raw.githubusercontent.com/OwenVey/palwiz/main/src/data/alpha-pals.json'

curl -sL "$array1url" | jq "$jqScript" > "${thisScriptDir}/pal_data_normal.json"
curl -sL "$array2url" | jq "$jqScript" > "${thisScriptDir}/pal_data_alpha.json"

# use jq to merge the two arrays
jq -s 'add' "${thisScriptDir}/pal_data_normal.json" "${thisScriptDir}/pal_data_alpha.json" > "${thisScriptDir}/pal_data.json"

# remove the temporary files
rm "${thisScriptDir}/pal_data_normal.json" "${thisScriptDir}/pal_data_alpha.json"
