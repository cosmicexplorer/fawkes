#!/usr/bin/env zsh

set -eux

readonly protection_mode="${MODE:-low}"
readonly pex_file="${OUTPUT_FILE:-./fawkes.pex}"

export LD_LIBRARY_PATH='/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cuda-11.2.2-4zo5zrp65dhdizjexsdf4nadnywnuh4h/targets/x86_64-linux/lib:/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cudnn-8.7.0.84-11.8-eeziikgbkjtctzsfj7xnlz5cwymfjp6k/lib:/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cuda-11.0.3-goviprkcgyeyukopcizps2fpa264dwko/targets/x86_64-linux/lib'

# NB: this was necessary at one point, but the error messages are no longer showing up!
# See this page regarding stream buffering (is this part even necessary?):
# https://unix.stackexchange.com/questions/25372/turn-off-buffering-in-pipe
function handle-weird-errors {
  unbuffer 2>&1 "$@" \
    | unbuffer -p grep -v -F 'not defined for option' \
    | unbuffer -p grep -v -E '^[[:space:]]*$'
}

exec "$pex_file" \
     -d ./test-images/ \
     --format jpg \
     --mode "$protection_mode"
