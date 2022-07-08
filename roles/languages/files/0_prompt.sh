#! /bin/bash

export OMP_THEME="$(brew --prefix oh-my-posh)/themes/blue-owl.omp.json"
eval "$(oh-my-posh init bash --config ${OMP_THEME})"
