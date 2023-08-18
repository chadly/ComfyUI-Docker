#!/bin/bash

set -e

if [ ! -f "/home/runner/.download-complete" ] ; then
	echo "########################################"
	echo "Installing Custom Nodes..."
	echo "########################################"

	python3.10 custom_nodes/ComfyUI-Impact-Pack/install.py
	pip install -r custom_nodes/comfyui_controlnet_aux/requirements.txt
	pip install -r custom_nodes/efficiency-nodes-comfyui/requirements.txt
	pip install -r custom_nodes/was-node-suite-comfyui/requirements.txt
	python3.10 custom_nodes/comfy_mtb/install.py

	touch /home/runner/.download-complete
fi

echo "########################################"
echo "Starting ComfyUI..."
echo "########################################"

python3.10 main.py --listen --port 8188 ${CLI_ARGS}
