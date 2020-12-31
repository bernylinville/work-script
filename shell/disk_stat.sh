#!/bin/bash
# 磁盘空间监控
partition_list=$(df -h | awk 'NF>3&&NR>1{sub(/%/,"",$(NF-1));print$NF,$(NF-1)}')
criticial=90

notification_email() {
  email_user='notification@email.com'
  email_passwd='password'
  email_smtp='smtp.email.com'
  sento='admin@email.com'
  title='Disk Space Alarm'
  sendEmail -f "${email_user}" -t "${sento}" -s "${email_smtp}" -u "${title}" -xu "${email_user}" -xp "${email_passwd}"
}

crit_info=""
for (( i=0;i<${#partition_list[@]};i+=2 )); do
  if [[ "${partition_list[((i+1))]}" -lt "${criticial}" ]]; then
    echo "OK! ${partition_list[i]} used ${partition_list[((i+1))]}%"
  else
    crit_info=${crit_info}"Warning!!!   ${partition_list[i]} used ${partition_list[((i+1))]}%"
  fi
done

if [[ "${crit_info}" != "" ]]; then
  echo -e "${crit_info}" | notification_email
fi