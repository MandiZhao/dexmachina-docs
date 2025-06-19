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

## RL Evaluation

Provide full checkpoint path saved from one of the rl training runs, e.g.
```
CK=logs/rl_games/inspire_hand/RUN_NAME/nn/inspire_hand.pth
python dexmachina/rl/eval_rl_games.py -B 1 --checkpoint $CK -v 
```