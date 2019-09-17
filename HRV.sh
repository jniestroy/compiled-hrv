#!/bin/bash
file_name=UVA0023_rr.mat
pre=_pre.mat
echo $file_name
file_2=${file_name%.mat}$pre
python readdata.py $file_name
echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/mcr/v96/runtime/glnxa64:/opt/mcr/v96/bin/glnxa64:/opt/mcr/v96/sys/os/glnxa64:/opt/mcr/v96/extern/bin/glnxa64
./InitializeHRVparams test-docker
./RRIntervalPreprocess $file_name "HRVparams.mat"
./Main_HRV_Analysis $file_2 "HRVparams"
export LD_LIBRARY_PATH=
python write_data.py
