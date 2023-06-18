#!/usr/bin/env zsh

set -eux

export LD_LIBRARY_PATH='/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cuda-11.2.2-4zo5zrp65dhdizjexsdf4nadnywnuh4h/targets/x86_64-linux/lib:/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cudnn-8.7.0.84-11.8-eeziikgbkjtctzsfj7xnlz5cwymfjp6k/lib:/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/cuda-11.0.3-goviprkcgyeyukopcizps2fpa264dwko/targets/x86_64-linux/lib'

unbuffer ./fawkes.pex \
         -d ./test-images/ \
         --format jpg \
         --mode low 2>&1 \
  | unbuffer -p grep -v -F 'not defined for option' \
  | unbuffer -p grep -v -E '^[[:space:]]*$'
