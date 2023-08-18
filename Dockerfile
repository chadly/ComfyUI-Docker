################################################################################
# Dockerfile that builds 'yanwk/comfyui-boot:latest'
# A runtime environment for https://github.com/comfyanonymous/ComfyUI
################################################################################

FROM opensuse/tumbleweed:latest

LABEL maintainer="code@yanwk.fun"

RUN --mount=type=cache,target=/var/cache/zypp \
    set -eu \
    && zypper refresh \
    && zypper install --no-confirm \
        python310 python310-pip \
        python310-devel \
        shadow git aria2 \
        Mesa-libGL1 \
        gcc gcc-c++ make \
        ffmpeg ffmpeg-4

# Install PyTorch nightly
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install wheel setuptools numpy \
    && pip install --pre torch torchvision \
        --index-url https://download.pytorch.org/whl/nightly/cu118 

# Install xFormers from wheel file we just compiled
COPY --from=yanwk/comfyui-boot:xformers /wheels /root/wheels

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install /root/wheels/*.whl \
    && rm -rf /root/wheels

# Fix for CuDNN
WORKDIR /usr/lib64/python3.10/site-packages/torch/lib
RUN ln -s libnvrtc-672ee683.so.11.2 libnvrtc.so 
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib64/python3.10/site-packages/torch/lib"

WORKDIR /home/runner

RUN git clone "https://github.com/comfyanonymous/ComfyUI.git"

WORKDIR /home/runner/ComfyUI
RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt

WORKDIR /home/runner/ComfyUI/custom_nodes/
RUN git clone "https://github.com/ltdrdata/ComfyUI-Manager.git"
RUN git clone "https://github.com/Fannovel16/comfyui_controlnet_aux/"
RUN git clone "https://github.com/LucianoCirino/efficiency-nodes-comfyui.git"
RUN git clone "https://github.com/space-nuko/ComfyUI-OpenPose-Editor.git"
RUN git clone "https://github.com/Gourieff/comfyui-reactor-node.git"
RUN git clone "https://github.com/WASasquatch/was-node-suite-comfyui.git"
RUN git clone "https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git"
RUN git clone "https://github.com/melMass/comfy_mtb.git"
RUN git clone "https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git"
RUN git clone "https://github.com/ltdrdata/ComfyUI-Impact-Pack.git"

WORKDIR /home/runner/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
RUN git submodule update --init --recursive

COPY scripts/. /home/scripts/

EXPOSE 8188
ENV CLI_ARGS=""
WORKDIR /home/runner/ComfyUI

CMD ["bash","/home/scripts/entrypoint.sh"]
