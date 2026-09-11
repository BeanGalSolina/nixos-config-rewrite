#!/usr/bin/env zsh

flags=(
    "aroace"
    "lesbian"
    "trans"
)

blahaj -s -c "${flags[$(( RANDOM % ${#flags[@]} + 1 ))]}"

