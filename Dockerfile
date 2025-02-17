FROM ghcr.io/chadly/pytorch:latest

WORKDIR /home/runner

RUN git clone "https://github.com/comfyanonymous/ComfyUI.git"

WORKDIR /home/runner/ComfyUI
RUN pip install -r requirements.txt

WORKDIR /home/runner/ComfyUI/custom_nodes/

RUN git clone "https://github.com/ltdrdata/ComfyUI-Manager.git"
RUN pip install -r ComfyUI-Manager/requirements.txt

COPY scripts/. /home/scripts/

EXPOSE 8188
ENV CLI_ARGS=""
WORKDIR /home/runner/ComfyUI

CMD ["bash","/home/scripts/entrypoint.sh", "--user-directory /home/runner/ComfyUI/user"]
