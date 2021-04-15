#!/bin/bash

log_dir="${HOME:-1}/gpu_stats"
log_file="${log_dir}/$(date +%Y%m%d)_gpu_stats.csv"
header="timestamp,user,pid,gpu,usage"

[[ ! -d "${log_dir}" ]] && mkdir -p "${log_dir}"
[[ ! -f "${log_file}" ]] && echo "${header}" > "${log_file}"
nvidia-smi -x -q | python gpu_info.py >> "${log_file}"
