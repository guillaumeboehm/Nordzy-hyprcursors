#!/bin/sh

root_dir="$(dirname "$(dirname "$(realpath "$0")")")"

tmp_dir="$root_dir/tmp_dir"
mkdir -p "$tmp_dir"

desc="Hyprcursor port of https://github.com/alvatip/Nordzy-cursors."
mkdir -p "$root_dir/hyprcursors"
mkdir -p "$root_dir/archives"
rm /tmp/hyprcursor_shasums.txt

themes='Nordzy-cursors Nordzy-cursors-white'
for theme in $themes; do
    hyprcursor-util --extract "$root_dir/themes/$theme" -o "$tmp_dir"
    sed -i -E "s/^(name[[:space:]]*=[[:space:]]*)(.*)$/\1$theme/" "$tmp_dir/extracted_$theme/manifest.hl"
    sed -i -E "s|^(description[[:space:]]*=[[:space:]]*)(.*)$|\1$desc|" "$tmp_dir/extracted_$theme/manifest.hl"
    hyprcursor-util --create "$tmp_dir/extracted_$theme" -o "$tmp_dir"

    rm -rf "$root_dir/hyprcursors/${theme}-hyprcursor"
    mv "$tmp_dir/theme_$theme" "$root_dir/hyprcursors/${theme}-hyprcursor"

    (cd "$root_dir/hyprcursors" &&
        tar zcvf "$root_dir/${theme}-hyprcursor.tar.gz" "${theme}-hyprcursor")
    sha256sum "$root_dir/${theme}-hyprcursor.tar.gz" >> /tmp/hyprcursor_shasums.txt
    mv "$root_dir/${theme}-hyprcursor.tar.gz" "$root_dir/archives"
done

cat /tmp/hyprcursor_shasums.txt

rm -rf "$tmp_dir"
