#!/usr/bin/env zsh

set -euxo pipefail

# readonly pex_cmd="${PEX_CMD:-pex}"
readonly pex_cmd="${PEX_CMD:-../pex/pex-c2fa813}"
# The pex fails to find __main__ when we execute it unless we remove the output file in advance.
# TODO: this is probably a pex bug, when the output file "fawkes.pex" is named the same as the
# module containing __main__ (which in this case is named "fawkes")!
readonly output_file="${OUTPUT_FILE:-./fawkes-runner.pex}"

PATH="/home/cosmicexplorer/tools/s2/opt/spack/linux-ubuntu22.10-zen3/gcc-12.2.0/python-3.8.16-aa6figfsbchmev4h5xiwa7tcqgzlbs5h/bin:${PATH}"

exec "$pex_cmd" \
     -vvvvvvvvv \
     --resolver-version=pip-2020-resolver \
     --python=python3.8 \
     'numpy>=1.19.5' 'tensorflow-gpu==2.5.3' 'keras==2.4.3' 'mtcnn' 'pillow>=7.0.0' \
     'bleach>=2.1.0' \
     -D . \
     -e fawkes:main --validate-entry-point \
     -o "$output_file"
