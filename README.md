# own-chatgpt-web
centos7 下一键搭建chatgpt-web
以下环境成功搭建：
   1 vCPU Core
   10 GB Storage
   512 MB RAM 
   centos7
   
## 使用方式
1. 在/home目录下执行
````
git clone https://github.com/vvvsk/own-chatgpt-web.git
cd own-chatgpt-web
````
2. 配置`run.sh`文件中三个值

```
email=xxxx@qq.com #你的gpt账号
password=xxx #你的gpt密码
your_web_password=1234qwer #访问你的gpt网站所需密码
```

3. 执行命令 `bash run.sh`，访问http://your_vps_ip:3002，即可访问chatgpt-web，端口需要开放，也可以在docker-compose.yml改成其他端口

## 因为登录信息14天会过期，因此建议设置每周执行一次脚本。以下是步骤：

1. 打开终端，输入以下命令以编辑cron表：

   ```
   crontab -e
   ```

2. 在cron表中添加以下行来指定每周一运行脚本：

   ```
   0 0 */10 * * /home/own-chat-web/run.sh
   ```

   这将在每个星期一的午夜（0点）运行指定的脚本。

3. 查看是否有定时任务

   ```sudo crontab -l
   sudo crontab -l
