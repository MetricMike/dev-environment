#! /bin/bash

eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

uv sync --quiet
