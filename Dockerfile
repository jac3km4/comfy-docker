ARG UBUNTU_VERSION="24.04"
FROM ubuntu:${UBUNTU_VERSION}

ARG TORCH_INDEX="https://download.pytorch.org/whl/cu124"
ARG COMFY_GIT="https://github.com/comfyanonymous/ComfyUI"

RUN apt-get update && \
    apt-get install -y git python3 python3-venv python3-pip && \
    apt-get clean

RUN git clone ${COMFY_GIT} /workspace

WORKDIR /workspace

RUN python3 -m venv venv && \
    venv/bin/pip install torch torchvision torchaudio --extra-index-url ${TORCH_INDEX} && \
    venv/bin/pip install -r requirements.txt

VOLUME ["/workspace", "/workspace/output", "/data"]

CMD ["venv/bin/python", "main.py"]
