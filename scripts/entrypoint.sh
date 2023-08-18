#!/bin/bash

set -e

/home/scripts/update.sh

if [ ! -f "/home/runner/.download-complete" ] ; then
	echo "########################################"
	echo "Downloading models..."
	echo "########################################"

	if ! aria2c \
		--input-file=/home/scripts/download.txt \
		--console-log-level=warn \
		--allow-overwrite=false \
		--auto-file-renaming=false \
		--continue=true \
		--max-connection-per-server=5; then
		echo "Warning: aria2c download failed. Continuing..."
	fi

	# ensure face swapper has access to roop model
	mkdir -p custom_nodes/comfyui-reactor-node/models/roop/
	cp models/roop/inswapper_128.onnx custom_nodes/comfyui-reactor-node/models/roop/inswapper_128.onnx

	echo "########################################"
	echo "Installing Custom Nodes..."
	echo "########################################"

	python3.10 custom_nodes/ComfyUI-Impact-Pack/install.py
	python3.10 custom_nodes/comfy_controlnet_preprocessors/install.py --no_download_ckpts
	pip install -r custom_nodes/efficiency-nodes-comfyui/requirements.txt
	pip install -r custom_nodes/comfyui-reactor-node/requirements.txt
	pip install -r custom_nodes/was-node-suite-comfyui/requirements.txt
	python3.10 custom_nodes/comfy_mtb/install.py

	touch /home/runner/.download-complete
fi

echo "########################################"
echo "Starting ComfyUI..."
echo "########################################"

python3.10 main.py --listen --port 8188 ${CLI_ARGS}
