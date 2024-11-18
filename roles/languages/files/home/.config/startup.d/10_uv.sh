#! /bin/bash

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# shellcheck source=/dev/null
. "${HOME}/.venv/bin/activate"
uv sync --quiet
