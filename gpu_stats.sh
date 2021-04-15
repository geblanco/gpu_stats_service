#!/bin/bash

log_dir="${HOME:-1}/gpu_stats"
log_file="${log_dir}/$(date +%Y%m%d)_gpu_stats.csv"
header="timestamp,user,pid,gpu,usage"

[[ ! -d "${log_dir}" ]] && mkdir -p "${log_dir}"
[[ ! -f "${log_file}" ]] && echo "${header}" > "${log_file}"
nvidia-smi -x -q | gpu_info.py 2>&1 >> "${log_file}"
