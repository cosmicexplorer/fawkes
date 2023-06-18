#!/usr/bin/env zsh

set -euxo pipefail

# readonly pex_cmd="${PEX_CMD:-pex}"
readonly pex_cmd="${PEX_CMD:-../pex/pex-c2fa813}"
readonly output_file="${OUTPUT_FILE:-./fawkes.pex}"

# The pex fails to find __main__ when we execute it unless we remove the output file in advance.
# TODO: this is probably a pex bug, when the output file "fawkes.pex" is named the same as the
# module containing __main__ (which in this case is named "fawkes")!
rm -fv "$output_file"

"$pex_cmd" \
  -vvvvvvvvv \
  --resolver-version=pip-2020-resolver \
  --python=python3.8 \
  'numpy>=1.19.5' 'tensorflow-gpu==2.5.3' 'keras==2.4.3' 'mtcnn' 'pillow>=7.0.0' 'bleach>=2.1.0' \
  -D . -e fawkes:main --validate-entry-point \
  -o fawkes.pex
