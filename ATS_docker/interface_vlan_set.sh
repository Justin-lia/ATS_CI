# 1. 啟用網卡混雜模式 (Promiscuous mode)，讓它能接收非自己 MAC 的封包
sudo ip link set enp3s0f1 promisc on

# 2. 建立 VLAN 子介面 (這會產生 eth0.20, eth0.30, eth0.40)
# 注意：這只是暫時生效，重開機需重設，建議寫入 Netplan 永久生效
sudo ip link add link enp3s0f1 name enp3s0f1.20 type vlan id 20
sudo ip link add link enp3s0f1 name enp3s0f1.30 type vlan id 30
sudo ip link add link enp3s0f1 name enp3s0f1.99 type vlan id 99

# 3. 啟動介面
sudo ip link set enp3s0f1.20 up
sudo ip link set enp3s0f1.30 up
sudo ip link set enp3s0f1.99 up
