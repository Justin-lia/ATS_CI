# ============================
# Robot Framework (Chrome + SSH)
# ============================
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

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
    firefox \
    && \
    # 安裝 Google Chrome
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt update && apt install -y google-chrome-stable && \
    # 安裝 ChromeDriver（自動匹配 Chrome 版本）
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d'.' -f1) && \
    DRIVER_VERSION=$(curl -s "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_VERSION}") && \
    wget -q "https://storage.googleapis.com/chrome-for-testing-public/${DRIVER_VERSION}/linux64/chromedriver-linux64.zip" && \
    #wget -q "https://storage.googleapis.com/chrome-for-testing-public/142.0.7444.175/linux64/chromedriver-linux64.zip" && \
    unzip chromedriver-linux64.zip -d /usr/local/bin && \
    mv /usr/local/bin/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    # 清理暫存檔
    apt autoremove -y && \
    apt clean && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        chromedriver-linux64.zip \
        /usr/local/bin/chromedriver-linux64 \
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
