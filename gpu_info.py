#!/usr/bin/python3

import os
import sys
import pwd
import xml.etree.ElementTree as ET

from datetime import datetime


def get_pid_owner(pid):
    # the /proc/PID is owned by process creator
    proc_stat_file = os.stat(f"/proc/{pid}")
    # get UID via stat call
    uid = proc_stat_file.st_uid
    # look up the username from uid
    username = pwd.getpwuid(uid)[0]
    return username


def get_gpu_info(gpu_id, gpu_elem):
    ret = None
    proc_info = gpu_elem.find('processes').find('process_info')
    if proc_info is not None:
        pid = proc_info.find('pid').text
        user = get_pid_owner(pid)
        gpu_util_text = gpu_elem.find('utilization').find('gpu_util').text
        mem = int(gpu_util_text.split(' ')[0])
        ret = (user, pid, gpu_id, mem)
    return ret


# head: timestamp,user,pid,gpu,usage
all_info = []
empty_data = ('-', '-', '-', 0)
timestamp = str(datetime.timestamp(
    datetime.now().replace(second=0, microsecond=0)
)).split('.')[0]
tree = ET.parse(sys.stdin)
root = tree.getroot()

for gpu_id, gpu_elem in enumerate(root.findall('gpu')):
    gpu_info = get_gpu_info(gpu_id, gpu_elem)
    if gpu_info is not None:
        all_info.append(gpu_info)

if len(all_info) == 0:
    all_info.append(empty_data)

for info in all_info:
    print(','.join([timestamp] + [str(i) for i in info]))
