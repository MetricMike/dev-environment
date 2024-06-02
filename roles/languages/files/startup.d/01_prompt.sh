#! /bin/bash

OMP_PREFIX=$(oh-my-posh cache path)
export OMP_THEME="${OMP_PREFIX}/themes/blue-owl.omp.json"
eval "$(oh-my-posh init bash --config "${OMP_THEME}")"
