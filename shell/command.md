```shell
for pid in $(ps -ef | grep -v grep | grep java | awk '{print $2}');do echo "${pid}" > /tmp/a.txt;cat /proc/"${pid}"/status | grep Threads > /tmp/b.txt;paste /tmp/a.txt /tmp/b.txt;done |sort -k3 -rn
```

```shell
ps -e -o stat,ppid,pid,cmd | egrep '^[Zz]' | awk '{print $2}' | xargs kill -9
```

```shell
ps aux | head -1;ps aux | sort -rn -k3 | head -10

ps aux | head -1;ps aux | sort -rn -k4 | head -10
```