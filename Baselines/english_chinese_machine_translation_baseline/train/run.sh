#!/usr/bin/env bash

python t2t-trainer --registry_help

#export CUDA_VISIBLE_DEVICES=""
PROBLEM=translate_enzh_wmt32k
MODEL=transformer
#HPARAMS=transformer_base_single_gpu
HPARAMS=transformer_base
HOME=`pwd`
DATA_DIR=$HOME/t2t_data
TMP_DIR=$DATA_DIR

mkdir -p $DATA_DIR $TMP_DIR

# Generate data
t2t-datagen \
  --data_dir=$DATA_DIR \
  --tmp_dir=$TMP_DIR \
  --problem=$PROBLEM

# Train
# *  If you run out of memory, add --hparams='batch_size=2048' or even 1024.
PROBLEM=${PROBLEM}_rev
#echo "PROBLEM:" $PROBLEM "DATA_DIR:" $DATA_DIR "MODEL:" $MODEL "HPARAMS:" $HPARAMS "TRAIN_DIR:" $TRAIN_DIR

TRAIN_DIR=$HOME/t2t_train/$PROBLEM/$MODEL-$HPARAMS
mkdir -p $TRAIN_DIR

t2t-trainer \
  --data_dir=$DATA_DIR \
  --problem=$PROBLEM \
  --model=$MODEL \
  --hparams_set=$HPARAMS \
  --output_dir=$TRAIN_DIR
