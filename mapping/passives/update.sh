#!/usr/bin/env bash

# all credits goes to to https://github.com/KrisCris/Palworld-Pal-Editor

thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

curl -s https://raw.githubusercontent.com/KrisCris/Palworld-Pal-Editor/develop/src/palworld_pal_editor/assets/data/pal_passives.json |
jq 'map(
  {
    InternalName:    .InternalName,
    FriendlyName:    .I18n.en.Name,
    SuggestedRating: .Rating,
    Description:     .I18n.en.Description
  }
)' > "${thisScriptDir}/pal_passives.json"
