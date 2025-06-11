# RL Training and Evaluation

## Installation
Our RL training code is based on rl-games, install the package requirements below:

```
pip install gymnasium ray seaborn wandb trimesh
```
Next, fork and local-install our custom fork of rl-games repo:

```
git clone https://github.com/MandiZhao/rl_games.git
cd rl_games
pip install -e . 
```

## RL Training 
Assume wandb logging is [setup](https://wandb.ai/). Run the bash script below:
```
cd dexmachina
bash examples/train_rl.sh
```