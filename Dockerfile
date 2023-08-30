FROM ghcr.io/chadly/pytorch:latest

WORKDIR /home/runner

RUN git clone "https://github.com/comfyanonymous/ComfyUI.git"

WORKDIR /home/runner/ComfyUI
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt

WORKDIR /home/runner/ComfyUI/custom_nodes/
RUN git clone "https://github.com/ltdrdata/ComfyUI-Manager.git"
RUN --mount=type=cache,target=/root/.cache/pip pip install -r ComfyUI-Manager/requirements.txt

RUN git clone "https://github.com/Fannovel16/comfyui_controlnet_aux/"
RUN --mount=type=cache,target=/root/.cache/pip pip install -r comfyui_controlnet_aux/requirements.txt

RUN git clone "https://github.com/LucianoCirino/efficiency-nodes-comfyui.git"
RUN --mount=type=cache,target=/root/.cache/pip pip install -r efficiency-nodes-comfyui/requirements.txt

RUN git clone "https://github.com/WASasquatch/was-node-suite-comfyui.git"
RUN --mount=type=cache,target=/root/.cache/pip pip install -r was-node-suite-comfyui/requirements.txt

RUN git clone "https://github.com/BadCafeCode/masquerade-nodes-comfyui.git"

RUN git clone "https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git"

RUN git clone "https://github.com/melMass/comfy_mtb.git"
WORKDIR /home/runner/ComfyUI/custom_nodes/comfy_mtb
RUN git submodule update --init --recursive
RUN --mount=type=cache,target=/root/.cache/pip python3.10 install.py

WORKDIR /home/runner/ComfyUI/custom_nodes/

RUN git clone "https://github.com/chadly/ComfyUI-Impact-Pack.git"
WORKDIR /home/runner/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
RUN git submodule update --init --recursive
RUN --mount=type=cache,target=/root/.cache/pip python3.10 install.py

WORKDIR /home/runner/ComfyUI/custom_nodes/

RUN git clone "https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git"

COPY scripts/. /home/scripts/

EXPOSE 8188
ENV CLI_ARGS=""
WORKDIR /home/runner/ComfyUI

CMD ["bash","/home/scripts/entrypoint.sh"]
