#!/bin/bash

set -e

if [ ! -f "/home/runner/.download-complete" ] ; then
	echo "########################################"
	echo "Installing Custom Nodes..."
	echo "########################################"

	python3.10 custom_nodes/ComfyUI-Impact-Pack/install.py
	python3.10 custom_nodes/comfy_mtb/install.py

	touch /home/runner/.download-complete
fi

echo "########################################"
echo "Starting ComfyUI..."
echo "########################################"

python3.10 main.py --listen --port 8188 ${CLI_ARGS}
