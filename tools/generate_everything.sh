#!/bin/bash

script_dir="$(realpath "$(dirname "${0}")")"

rm -rf "${script_dir}/../archives/*"

"${script_dir}/batch_theme_rendering.sh"
"${script_dir}/generate_hyprcursors.sh"

cat "${script_dir}/../archives/checksums"
