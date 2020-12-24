#!/bin/bash

date_time="$(date +%Y_%m_%d)"
readonly DAYS='7'
readonly BACKUP_USER='user1'
readonly BACKUP_DIR='/data/backup/data' # 备份文件保存路径
backup_data="${BACKUP_USER}"_"${date_time}".tar.gz # 备份产生的文件名称，以当前时间命名
backup_log="${BACKUP_USER}"_"${date_time}".log
readonly BACKUP_SRC_DIR='/data/mysql/data' # 需要备份的文件
readonly REMOTE_BACKUP_DIR='/data/backup/db' # 远程备份路径
readonly REMOTE_IP='192.168.50.33'

mkdir -p "${BACKUP_DIR}"/"${BACKUP_USER}"
echo "Backup start at ${date_time}" > "${BACKUP_DIR}"/"${BACKUP_USER}"/"${backup_log}"
echo "----------------------------" >> "${BACKUP_DIR}"/"${BACKUP_USER}"/"${backup_log}"
cd "${BACKUP_DIR}"/"${BACKUP_USER}" || exit
tar -zcvf "${backup_data}" --absolute-names "${BACKUP_SRC_DIR}" "${backup_log}" # -P, --absolute-names don't strip leading `/'s from file names

find "${BACKUP_DIR}"/"${BACKUP_USER}" -type -f -name "*.log" -exec rm {} \; # 删除备份过程中产生的日志
find "${BACKUP_DIR}"/"${BACKUP_USER}" -type -f -name "*.tar.gz" -mtime +"${DAYS}" -exec rm -rf {} \; # 删除7天之前的备份

rsync -avzPL "${backup_data}" "${REMOTE_IP}":"${REMOTE_BACKUP_DIR}" # rsync 传输备份文件到远程主机
