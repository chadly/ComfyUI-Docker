#!/bin/bash

set -e

echo "########################################"
echo "Starting ComfyUI..."
echo "########################################"

python3.10 main.py --listen --port 8188 ${CLI_ARGS}
