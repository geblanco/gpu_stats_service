#!/bin/bash

log_dir="${HOME:-1}/gpu_stats"
log_file="${log_dir}/$(date +%Y%m%d)_gpu_stats.csv"
header="timestamp,user,pid,gpu,usage"

print_gpu_stat(){
    local timestamp=$(date +%s)
    local nvidia_info=$(nvidia-smi -q -x)
    local nof_gpus_inuse=$(echo "$nvidia_info" | grep pid | wc -l)
    local gpu_num_rows=$(seq 1 $nof_gpus_inuse)
    local timerows=$(for i in `seq 1 $nof_gpus_inuse`; do echo $timestamp; done)
    local user_pid_rows=$(echo "$nvidia_info" | grep pid | sed -e 's/<pid>//g' -e 's/<\/pid>//g' -e 's/^[[:space:]]*//' | xargs -n 1 ps --no-headers -up | awk '{print $1,$2}')
    local gpu_util_rows=$(echo "$nvidia_info" | grep gpu_util | sed -e 's/<gpu_util>//g' -e 's/<\/gpu_util>//g' -e 's/^[[:space:]]*//' -e 's/\%//')
    paste <(echo -n "$timerows") <(echo -n "$user_pid_rows") <(echo -n "$gpu_num_rows") <(echo -n "$gpu_util_rows") | column -t -o ","
}

[[ ! -d "${log_dir}" ]] && mkdir -p "${log_dir}"
[[ ! -f "${log_file}" ]] && echo "${header}" > "${log_file}"
print_gpu_stat >> "${log_file}"
