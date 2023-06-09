#!/bin/bash

email=xxxx@qq.com
password=xxx
your_web_password=1234qwer

# 检查 Docker 是否已经安装
if ! command -v docker &> /dev/null; then
    # 如果 Docker 没有安装，则安装 Docker
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum update -y && sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# 检查 Python 3 是否已经安装
if ! command -v python3 &> /dev/null; then
    # 如果 Python 3 没有安装，则安装 Python 3
    sudo yum install -y epel-release
    sudo yum install -y python3
fi

# 检查 OpenAIAuth 库是否已经安装
if ! python3 -c "import OpenAIAuth" &> /dev/null; then
    # 如果 OpenAIAuth 库没有安装，则使用 pip3 安装
    sudo pip3 install OpenAIAuth
fi

# 检查 PyYAML 是否已安装
if python3 -c "import yaml" &> /dev/null; then
  echo "PyYAML 已安装"
else
  echo "PyYAML 未安装，开始安装..."
  # 安装 PyYAML
  if sudo yum install -y python3-PyYAML; then
    echo "PyYAML 安装成功"
  else
    echo "PyYAML 安装失败"
  fi
fi


python3 get-accessToken.py $email $password $your_web_password 2>&1


# 检查 Docker Compose 是否已经安装
if ! docker-compose -v &> /dev/null
then
    echo "Docker Compose 未安装"
    
    # 安装 Docker Compose
    echo "正在安装 Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # 验证安装是否成功
    if docker-compose -v &> /dev/null
    then
        echo "Docker Compose 已成功安装"
    else
        echo "Docker Compose 安装失败，请重试"
    fi
else
    echo "Docker Compose 已安装，版本号：$(docker-compose --version)"
fi

docker-compose up --force-recreate --build -d