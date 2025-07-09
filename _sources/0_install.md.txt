# Installation

## Minimal Requirements
1. We recommend using conda environment with Python=3.10
```
conda create -n dexmachina python=3.10
conda activate dexmachina
```
2. Clone and install this custom fork version of Genesis (a modified version that supports entity-to-entity contact position reading, disable default visualizer, group-based collision filtering, etc) 
```
pip install torch==2.5.1
git clone https://github.com/MandiZhao/Genesis.git
cd Genesis
pip install -e .
pip install libigl==2.5.1 # NOTE: this is a temporary fix specifically for my fork of Genesis

git clone https://github.com/MandiZhao/rl_games.git
cd rl_games
pip install -e .
```
3. Install additional packages for RL training:
```
pip install gymnasium ray seaborn wandb trimesh
```

4. Local install the `dexmachina` package:
```
cd dexmachina
pip install -e .
```
**If you'd like to install the full conda environment that includes all the packages, use the below yaml file:**
```
# this is obtained from: conda export -f dexmachina.yaml
conda env create -f dexmachina.yaml
```


## Additional Package Dependencies 

### Kinematic retargeting
- Install the [dex-retargeting](https://github.com/dexsuite/dex-retargeting) package:
```
pip install dex_retargeting
```
Note that this might downgrade your numpy to `numpy==1.26.4`, but it runs fine with rest of the codebase.
If you see import error from `networkx`, run `pip install networkx==3.4.2`

- Minor but also need to install sklearn for mapping contacts -> this is needed if you want to process new data
```
pip install scikit-learn
```

### Process Additional ARCTIC data 
Follow instructions from ARCTIC repo and install in a *separate* conda environment: https://github.com/zc-alexfan/arctic/blob/master/docs/setup.md

### Raytracing rendering 
This must be built separately. Below instructions are tested for `dexmachina` conda environment with Python=3.10
- You might need sudo install a new cuda driver globally: Try `wget` to install [this link](https://developer.nvidia.com/cuda-12-2-2-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local) -- it installs the latest driver 570 and cuda12.8

1. Update git submodules
```
# inside Genesis/
git submodule update --init --recursive
pip install -e ".[render]"
```


2. Install/upgrad g++ and gcc (to) version >= 11.
```
sudo apt install build-essential manpages-dev software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update && sudo apt install gcc-11 g++-11
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 110
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 110

# verify version
g++ --version
gcc --version
```

3. Install CMake if your local version does not meet the required version. 
```
sudo snap install cmake --classic
cmake --version
```

4. Install other dependencies
```
sudo apt install libvulkan-dev xorg-dev # Vulkan, X11 & RandR
sudo apt-get install uuid-dev # UUID 
sudo apt-get install zlib1g-dev # zlib
```
Optionally for non-sudo users:
```
conda install -c conda-forge gcc=11.4 gxx=11.4 
conda install -c conda-forge cmake=3.26.1
conda install -c conda-forge vulkan-tools vulkan-headers xorg-xproto # Vulkan, X11 & RandR
conda install -c conda-forge libuuid # UUID
conda install -c conda-forge zlib # zlib
```


5. Build LuisaRender. Note here I set `PYTHON_VERSIONS=3.10`. Remember to use the correct cmake. By default, it uses OptiX denoiser (For CUDA backend only). If you need OIDN denoiser, append `-D LUISA_COMPUTE_DOWNLOAD_OIDN=ON`

```
cd genesis/ext/LuisaRender
cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D PYTHON_VERSIONS=3.10 -D LUISA_COMPUTE_DOWNLOAD_NVCOMP=ON -D LUISA_COMPUTE_ENABLE_GUI=OFF -D LUISA_RENDER_BUILD_TESTS=OFF # remember to check python version
cmake --build build -j $(nproc)
```

- Build instructions are originally from the official instructions [here](https://genesis-world.readthedocs.io/en/latest/user_guide/getting_started/visualization.html#photo-realistic-ray-tracing-rendering)

