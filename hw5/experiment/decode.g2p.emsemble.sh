#!/bin/bash
exp_path="/export/b18/xma/course/machine_translation/en600.468/hw5/experiment/"
data_path="${exp_path}/data/g2p"
#model_path="${exp_path}/model/model.nll_6.80.epoch_5"
pretrained_model="/export/b18/xma/course/machine_translation/mt-hw5-data/model.param"

tool="/export/b18/xma/course/machine_translation/en600.468/hw5"

source activate NeuralHawkes

# Availible GPU
device=`/home/xma/tools/bin/free-gpu`
echo "GPU:${device}"

# Necessary environment variables
LD_LIBRARY_PATH=/export/b18/xma/libs/cudnn-6/cuda/lib64:/opt/NVIDIA/cuda-8/lib64/
CPATH=/export/b18/xma/libs/cudnn-6/cuda/include
LIBRARY_PATH=/export/b18/xma/libs/cudnn-6/cuda/lib64

#mkdir -p model
CUDA_VISIBLE_DEVICES=${device} python ${tool}/decode.beam.py \
    --data_file ${data_path} \
    --model $@ \
    --src_lang words \
    --trg_lang phoneme \
    --gpuid 0
${tool}/scripts/multi-bleu.perl ../../../g2p-data/cmudict.phoneme.tst < $1.out
