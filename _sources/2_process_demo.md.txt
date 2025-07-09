# ARCTIC Human Demonstration Data Processing 

## Process raw ARCTIC data
If you want to add a new object/demonstration clip in order to make a new task environment, you would need to process more data from ARCTIC. 

First, follow the installation instructions from the [ARCTIC](https://github.com/zc-alexfan/arctic) repo (preferablly in a separate conda environment). To download raw ARCTIC data, use their bash scripts: `./bash/download_misc.sh` and `./bash/download_body_models.sh` 

```{note}
The ARCTIC dataset demonstrations are labeled either `use_01, use_02,...` or `grab_01, grab_02, ...`. Current `dexmachina` codebase assumes only using the `use_01`, `use_02` clips, e.g. a clip `box-0-600-s01-u01` is from arctic repo's downloaded `downloads/data/raw_seqs/s01/box_use_01.mano.npy` raw file. You would need to make bigger changes in order to incoporate the `grab_` series data.
```   


The raw data you downloaded from ARCTIC will contain only the essential data, which needs to be further processed to generate per-step object and MANO hand meshes (we need this for contact estimatation). To process the raw data, go to the `arctic` repo and install their contact environment. Run the below script once for every demonstration clip. For example, to process this clip collected by subject 01, run:
```
conda activate arctic
python scripts_data/process_seqs.py --mano_p downloads/data/raw_seqs/s01/laptop_use_01.mano.npy --export_verts
```

which will generate a full sequence at `./outputs/processed_verts/seqs/s01/laptop_use_01.npy`. ARCTIC has a nice built-in viewer that can load the demonstration and visualize them locally, the command looks something like:
```
python scripts_data/visualizer.py --no_image --seq_p ./outputs/processed_verts/seqs/s01/laptop_use_01.npy --mano --object
```

## Contact Approximation

You would need to first register account and download the official MANO models from their website: https://mano.is.tue.mpg.de/download.php. Click the "Models & Code" (highlighted in the screenshot below) to download the `.zip` file. The unzipped folder should contain `mano_v1_2/models/xxx`, which we need for the `process_arctic.py` script below.

![mano](media/mano_download_page.png)


Next, come back to this `dexmachina` repo and run `process_arctic.py` to further process the output demonstration sequences.

```
conda activate dexmachina
cd ../dexmachina/dexmachina
FNAME=${HOME}/arctic/outputs/processed_verts/seqs/s01/laptop_use_01.npy
MANO_MODEL_DIR=${HOME} # say the mano_v1_2 folder is in your /home directory

python retargeting/process_arctic.py -p $FNAME -mmd $MANO_MODEL_DIR --farthest_sample --save
```
This will default save to the asset folder in `dexmachina/dexmachina/assets`. Add the `--save_dir` flag to modify the save path.

```{note}
If you get this error from `chumpy`: `ImportError: cannot import name 'bool' from 'numpy' (/home/mandi/miniconda3/envs/dexmachina/lib/python3.10/site-packages/numpy/__init__.py)`, re-install `chumpy`: `pip install git+https://github.com/mattloper/chumpy`
```   

*The above steps only need to be run once for each human demonstration clips, in the next section we run kinematic-retargeting to process the data for different dexterous hands.*
## Convex Decomposition on Collision Mesh
We use V-HACD for collision shape decomposition. The articulated object URDFs are pre-processed and in `dexmachina/dexmachina/assets/arctic`.