FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# 合併所有 apt 安裝到單一 RUN 層
RUN apt update && apt install -y \
    python3 python3-pip \
    curl unzip wget gnupg \
    xvfb \
    openssh-server openssh-client ssh \
    git \
    fonts-liberation \
    net-tools \
    x11vnc \
    iputils-ping \
    tshark \
    python3-serial \
    isc-dhcp-client \
	telnetd openbsd-inetd telnetd\	
    firefox && \
    rm -rf /var/lib/apt/lists/*

RUN echo "root:password" | chpasswd
RUN echo "telnet stream tcp nowait root /usr/sbin/tcpd /usr/sbin/telnetd" >> /etc/inetd.conf
# 設定 SSH 服務（最簡化版本）
RUN mkdir -p /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    # 允許 root 用密碼登入
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # 啟用密碼認證
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    # 禁用金鑰認證（確保只能用密碼）
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config && \
    # 確保 UsePAM 是開啟的（用於密碼認證）
    sed -i 's/UsePAM no/UsePAM yes/' /etc/ssh/sshd_config

# 暴露 SSH 端口
EXPOSE 22
EXPOSE 23

