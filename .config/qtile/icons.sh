#!/bin/bash

files=("layout-bsp.png" "layout-floating.png" "layout-max.png" "layout-monadtall.png" "layout-stack.png" "layout-tile.png" "layout-treetab.png" "layout-zoomy.png" "python.png" "qtilelogo.png")
url="https://raw.githubusercontent.com/ani1001/dotfiles/8bac2b189e40186dc9a2ef1d420d412527076b6a/.config/qtile/icons"

for file in "${files[@]}"
do
  wget -c "$url/$file" -P ./icons/
done

