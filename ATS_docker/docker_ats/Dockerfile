# ============================
# Robot Framework (Chrome + SSH)
# ============================
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace


    # 安裝 Google Chrome
RUN apt update && apt install -y \
	curl unzip wget gnupg software-properties-common locales x11-xserver-utils && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && apt install -y google-chrome-stable && \

    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && apt install -y google-chrome-stable && \

    # 安裝 ChromeDriver（自動匹配 Chrome 版本）
    wget -q "https://storage.googleapis.com/chrome-for-testing-public/142.0.7444.175/linux64/chromedriver-linux64.zip" && \
    unzip chromedriver-linux64.zip -d /usr/local/bin && \
    mv /usr/local/bin/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \

    # 移除 Snap 佔位符
    apt remove --purge -y firefox* snapd gnome-software-plugin-snap && \
    # 添加 Mozilla PPA
    add-apt-repository ppa:mozillateam/ppa -y && \
    # 使用 \n 來表示檔案中的換行，整個命令在 Dockerfile 中只佔一行
    echo "Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1000" > /etc/apt/preferences.d/mozilla-ppa && \
    apt update && \
    apt install -y firefox && \
    # 安裝真正的 Firefox
    apt install -y firefox && \
    # 步驟 2: 下載並安裝 GeckoDriver
    GECKODRIVER_URL="https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-linux64.tar.gz" && \
    wget -q -O /tmp/geckodriver.tar.gz ${GECKODRIVER_URL} && \
    tar -xzf /tmp/geckodriver.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm /tmp/geckodriver.tar.gz && \
	
    # 清理暫存檔
    apt autoremove -y && \
    apt clean && \
	apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        chromedriver-linux64.zip \
        /usr/local/bin/chromedriver-linux64 \
        /root/.cache \
        /var/cache/apt/*

# 合併所有 apt 安裝到單一 RUN 層
RUN apt update && apt install -y \
    python3 python3-pip \
    curl unzip wget gnupg \
    xvfb \
    ssh \
    git \
    fonts-liberation \
    net-tools \
    x11vnc \
    iputils-ping \
    tshark \
    python3-serial \
    isc-dhcp-client \ 
	&&\
    # 清理暫存檔
    apt autoremove -y && \
    apt clean && \
	apt-get clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /root/.cache \
        /var/cache/apt/*

# 安裝 Robot Framework 與相關 Library（單獨一層以便快取）
RUN pip3 install --no-cache-dir --break-system-packages \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-sshlibrary \
    robotframework-pabot \
    robotframework-jsonlibrary \
    robotframework-requests \
    robotframework-seriallibrary \
    pyserial

# 設定虛擬顯示
ENV DISPLAY=:99

# 啟動 Xvfb 並保持容器開啟
CMD Xvfb :99 -screen 0 1280x1024x24 & \
    sleep 2 && \
    bash
