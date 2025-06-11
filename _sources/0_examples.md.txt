# Example Usage

## Inspect Dexterous Hands and ARCTIC objects

### Load one dexterous hand into a basic Genesis scene
- This default loads the left side hand to the scene
```
python examples/inspect_hand.py --hand allegro_hand --vis
```
Update 06/10/2025: this script now supports all 6 hands used in our [paper preprint](http://arxiv.org/abs/2505.24853). Run the following (add `--vis` tag for on-screen viewer):
```
python examples/inspect_hand.py --hand ability_hand
python examples/inspect_hand.py --hand allegro_hand
python examples/inspect_hand.py --hand dexrobot_hand
python examples/inspect_hand.py --hand inspire_hand
python examples/inspect_hand.py --hand schunk_hand
python examples/inspect_hand.py --hand xhand
```


### Load a pre-processed ARCTIC object and show one human demonstration trajectory:
```
python examples/load_object.py --obj_name box 
```
