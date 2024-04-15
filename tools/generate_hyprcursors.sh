#!/bin/sh

root_dir="$(dirname "$(dirname "$(realpath "$0")")")"

tmp_dir="$root_dir/tmp_dir"
mkdir -p "$tmp_dir"

desc="Hyprcursor port of https://github.com/alvatip/Nordzy-cursors."
mkdir -p "$root_dir/hyprcursors"
mkdir -p "$root_dir/archives"

themes='Nordzy-cursors Nordzy-cursors-white'

for theme in $themes; do
    hyprcursor-util --extract "$root_dir/themes/$theme" -o "$tmp_dir"
    sed -i -E "s/^(name[[:space:]]*=[[:space:]]*)(.*)$/\1$theme/" "$tmp_dir/extracted_$theme/manifest.hl"
    sed -i -E "s|^(description[[:space:]]*=[[:space:]]*)(.*)$|\1$desc|" "$tmp_dir/extracted_$theme/manifest.hl"
    hyprcursor-util --create "$tmp_dir/extracted_$theme" -o "$tmp_dir"

    rm -rf "$root_dir/hyprcursors/${theme}-hyprcursor"
    mv "$tmp_dir/theme_$theme" "$root_dir/hyprcursors/${theme}-hyprcursor"

    tar zcvf "$root_dir/${theme}-hyprcursor.tar.gz" "$root_dir/hyprcursors/${theme}-hyprcursor"
    mv "$root_dir/${theme}-hyprcursor.tar.gz" "$root_dir/archives"
done

rm -rf "$tmp_dir"
