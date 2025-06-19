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
OBJ=box
HAND=dex3_hand
CLIP=${OBJ}-0-600
python retargeting/parallel_retarget.py --clip $CLIP --hand ${HAND} --control_steps 2000 --save_name para --save -ow 
```

## Contact Retargeting 

Next we can use the kinematic retargeting results to set the robot to human-like motions, then use these robot poses to find where the hand-object contacts should be on the robot hand. For this, you need both processed ARCTIC data in `assets/arctic/processed`, and run something like:
```
HAND=dex3_hand
FNAME=assets/arctic/processed/s01/box_use_01.npy
python retargeting/map_contacts.py --hand $HAND --load_fname $FNAME
```
This will save a new file to `assets/contact_retarget/dex3_hand/s01/box_use_01.npy`. 

**Now you are all setup to train RL policy with this hand+demo clip combo!**