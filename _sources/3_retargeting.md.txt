# Kinematic Retargeting

We require kinematic retargeting for every combination of dexterous hand and human hand-object demonstration clip. The same procedure is applied to all existing tasks and hands, and documented below for adding new assets. 

```{note}
Additionally need to install [dex-retargeting](https://github.com/dexsuite/dex-retargeting):`pip install dex_retargeting`. 
```   

## Hand Config Preparation 
**See the previous page {doc}`1_process_hands` for full details on processing new dexterous hand assets.** 

For each new pair of dexterous hands, you would need to add its URDF and mesh assets into `assets` folder, and manually add a new `assets/hand_folder/retarget_config.yaml` file, which specifies the desired fingertip mapping from dexterous hand keypoints to human hands (MANO hands). 

## Collision-aware Physics-enabled Retargeting

We propose a simple object-aware retargeting scheme that leverages the parallel simulation environments. Run two stages so that first stage gives collision-free joints on individual steps, then second stage loads the result and roll-out in a single-threaded environment to get smoothed-out motions. 
```
OBJ=laptop
HAND=xhand
CLIP=${OBJ}-0-600
python retargeting/parallel_retarget.py --clip $CLIP --hand ${HAND} --control_steps 2000 --save_name para --save -ow 
```
This script will run kinematic-only retargeting first, and save it in `assets/retargeter_results/xhand/laptop_use_01_vector.npy`. Then, it will also save a new file in `dexmachina/dexmachina/assets/retargeted/xhand/s01/laptop_use_01_vector_para.pt`. Notice how this is now hand-specific. You would need to rerun for different hands for the same demonstration.

## Contact Retargeting 

For contact retargeting, we use the kinematic retargeting results (e.g. `assets/retargeter_results/xhand/laptop_use_01_vector.npy`) to set the robot to human-like motions, then use these robot poses to find where the hand-object contacts should be on the robot hand. For this, you need both processed ARCTIC data in `assets/arctic/processed` and the retargeter results in `assets/retargeter_results` and run something like:
```
HAND=xhand
FNAME=assets/arctic/processed/s01/laptop_use_01.npy
python retargeting/map_contacts.py --hand $HAND --load_fname $FNAME 
```
This will look for files in `assets/retargeter_results/{hand_name}/{subject_name}`, and the script will save a new file to `assets/contact_retarget/xhand/s01/laptop_use_01.npy`.

**Now you are all setup to train RL policy with this hand+demo clip combo!**
As a minimal sanity check, run a small offline run with only 2 parallel environments and no curriculum on your new clip:

``` 
wandb offline
CLIP=laptop-30-230-s01-u01
HAND=xhand 
python rl/train_rl_games.py -B 10 -obf -obt --max_epochs 10 --retarget_name para --horizon 16  -imw 0.5  --contact_beta 10  --group_collisions --clip $CLIP -imi 0.3 -bc 0.3 -con 3 -ert 0.5 --action_penalty 0.01 --use_retarget_contact  -exp tester --hand $HAND
```