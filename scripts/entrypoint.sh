#!/bin/bash

set -e

if [ ! -f "/home/runner/.download-complete" ] ; then
	echo "########################################"
	echo "Downloading models"
	echo "########################################"

	aria2c --allow-overwrite=false --auto-file-renaming=false --continue=true \
		--max-connection-per-server=5 --input-file=/home/scripts/download.txt

	touch /home/runner/.download-complete
fi

echo "########################################"
echo "Starting ComfyUI..."
echo "########################################"

python3.10 main.py --listen --port 8188 ${CLI_ARGS}
