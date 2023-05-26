#!/bin/bash
#
# Parallel run with GNU parallel
#
# which you can install with `sudo apt install parallel`
#
########################################

ROOT_DIR="/datasets/rolling-shutter/diffSfM"
UNREAL_DATASETS="shake1 shake2 shake4 Adornment Pink_Castle"
BLENDER_DATASETS="Factory"

########################################

UNREAL_SEQS=()
for DATASET in $UNREAL_DATASETS
do
    SEQS="$ROOT_DIR/$DATASET/*"
    for SEQ in $SEQS
    do
        UNREAL_SEQS="$UNREAL_SEQS $SEQ"
    done
done

for SEQ in $UNREAL_SEQS
do
    echo $SEQ
done

run_unreal() {
    echo "\033[0;36m[INFO]\033[0m Running Unreal Sequence $1"
    ./build/diff_RS_SfM $1 Unreal
}

export -f run_unreal

parallel -j 16 run_unreal ::: $UNREAL_SEQS

########################################

BLENDER_SEQS=()
for DATASET in $BLENDER_DATASETS
do
    SEQS="$ROOT_DIR/$DATASET/*"
    for SEQ in $SEQS
    do
        BLENDER_SEQS="$BLENDER_SEQS $SEQ"
    done
done

for SEQ in $BLENDER_SEQS
do
    echo $SEQ
done

run_blender() {
    echo "\033[0;36m[INFO]\033[0m Running Blender Sequence $1"
    ./build/diff_RS_SfM $1 Blender
}

export -f run_blender

parallel -j 16 run_blender ::: $BLENDER_SEQS
