# comfy-docker
Basic and easily customizable docker image for ComfyUI with:
- host mounted model and output directories
- persistent python environment

# build
```bash
docker build -t comfy:0.1.0 .
```

# use
start a ComfyUI instance
```bash
# specify the model and output directories
cat >> ./comfy.env << EOF
COMFY_MODEL_DIR=/my/model/dir
COMFY_OUT_DIR=/my/out/dir
EOF

./run.sh
```

update ComfyUI
```bash
./run.sh git pull
```

install a pip package
```bash
./run.sh venv/bin/pip install bitsandbytes
```

install a custom node
```bash
./run.sh git -C custom_nodes clone https://github.com/rgthree/rgthree-comfy
```

install controlnet_aux (requires an opencv workaround)
```bash
./run.sh /bin/bash
root@[...]:/workspace# git -C custom_nodes clone https://github.com/Fannovel16/comfyui_controlnet_aux
root@[...]:/workspace# venv/bin/pip install $(sed "s/opencv-python>=\(.*\)/opencv-python-headless>=\1/g" custom_nodes/comfyui_controlnet_aux/requirements.txt)
```
