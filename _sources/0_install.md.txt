# Installation

*If you'd like to install the entire conda environment that includes all the packages, use the yaml file:*
```
cd dexmachina
conda env create -f dexmachina.yml
```

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
```

3. Install this custom version of rl-games, which supports wandb logging and curriculum setting.
First, install prerequisites for rl-games:
```
pip install gymnasium ray 
```
Next, fork and local-install this repo:
```
git clone https://github.com/MandiZhao/rl_games.git
cd rl_games
pip install -e .
```
4. Install additional packages for logging, plotting, video export, etc.
```
pip install seaborn wandb trimesh
```


## Additional Package Dependencies 

### Kinematic retargeting
Install the [dex-retargeting](https://github.com/dexsuite/dex-retargeting) package:
```
pip install dex_retargeting
```
Note that this might downgrade your numpy to `numpy==1.26.4`, but it runs fine with rest of the codebase.

### Process Additional ARCTIC data 
Follow instructions from ARCTIC repo and install in a *separate* conda environment: https://github.com/zc-alexfan/arctic/blob/master/docs/setup.md

### Raytracing rendering 
- Follow the official instruction to build this separate raytracer package: [here](https://genesis-world.readthedocs.io/en/latest/user_guide/getting_started/visualization.html#photo-realistic-ray-tracing-rendering)
- You might need sudo install a new cuda driver globally: Try `wget` to install [this link](https://developer.nvidia.com/cuda-12-2-2-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_local) -- it installs the latest driver 570 and cuda12.8
