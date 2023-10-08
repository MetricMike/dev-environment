#! /bin/bash

OMP_PREFIX=$(brew --prefix oh-my-posh)
export OMP_THEME="${OMP_PREFIX}/themes/blue-owl.omp.json"
eval "$(oh-my-posh init bash --config "${OMP_THEME}")"
