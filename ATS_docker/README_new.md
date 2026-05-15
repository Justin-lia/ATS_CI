# ATS Docker — Claude Code Guide

## Project Overview

Automated Testing System (ATS) using Docker + Robot Framework + pytest to test network DUTs (routers/APs). Three containers simulate WAN, LAN, and ATS (test runner) environments via macvlan networks.

Working directory: `/home/gtk/claude_code_cli/ATS_docker/`

---

## Architecture

### Containers

| Container | Image | IPs | Role |
|-----------|-------|-----|------|
| `env-ats` | `env-ats:v1` | `192.168.100.10` (back), DHCP (lan/inet) | Test runner (Robot Framework, pytest, VNC) |
| `env-lan` | `env-lan:v1` | `192.168.100.20` (back) | LAN-side simulator (inetd, sshd) |
| `env-wan` | `env-wan:v1` | `192.168.100.30` (back) | WAN-side simulator (inetd, ntpd, sshd) |

### Networks

- `env_net`: macvlan `192.168.100.0/24` — inter-container backend (parent: `ats_interface.<backup_vlan_id>`)
- `ats_net_dut_lan`: macvlan — ATS↔DUT LAN (parent: `env_lan_interface`)
- `ats_net_internet`: macvlan — ATS internet access (parent: `env_ats_interface`)
- `lan_net_dut_lan` / `wan_net_dut_wan`: per-container DUT connections

### Container Interface Names

Inside containers, interfaces are renamed by `fix_interface_name_*.sh`:

| Logical Name | Binding |
|---|---|
| `eth-back` | Backend network (`env_net`) |
| `eth-lan`  | DUT LAN side |
| `eth-inet` | Internet / ATS side |
| `eth-wan`  | DUT WAN side |

---

## Network Topologies

**Scenario A — 1 NIC + Switch + VLAN** (current default in `config.sh`):
```
HOST PC ──[Switch]── WAN (DUT), LAN (DUT), Internet
ats_interface='enp3s0f1'
lan_interface='enp3s0f1.20'   # VLAN 20
wan_interface='enp3s0f1.30'   # VLAN 30
backup_vlan_id='99'
```

**Scenario B — 3 NICs, no switch**:
```
ats_interface='enp3s0'     # Internet
lan_interface='enp4s0'     # DUT LAN
wan_interface='enp5s0'     # DUT WAN
backup_vlan_id='99'        # still used on ats_interface
```

---

## Configuration

`config.sh` stores all network interface names, VLAN IDs, and Docker MAC addresses.  
It supports self-update: `./config.sh lan_interface 'enp3s0f1.20'` will patch the file and sync `lan_vlan_id` automatically.

---

## Common Commands

### Environment lifecycle
```bash
# Full startup (run in order from ATS_docker/)
./remove_vlan_interface.sh     # Remove stale VLAN interfaces
./interface_vlan_set.sh        # Create VLAN sub-interfaces
./start_env.sh                 # Create macvlan network + start all containers

# Teardown
./stop_all_docker.sh           # Stop containers + prune networks
```

### Useful inspection commands
```bash
docker ps                                    # Check container status
docker logs env-ats                          # ATS container logs
docker exec -it env-ats bash                 # Shell into ATS container
docker network ls | grep env                 # Check macvlan networks
```

---

## Test Framework Layout

```
/home/gtk/gemini_cli/ATS_docker/
├── README.md                 # This file
├── config.sh                 # Network configuration and Docker MAC addresses
├── start_env.sh              # Starts the Docker environment
├── interface_vlan_set.sh     # Sets up VLAN interfaces on the host
├── remove_vlan_interface.sh  # Removes VLAN interfaces from the host
├── stop_all_docker.sh        # Stops all Docker containers and prunes networks
├── docker_ats/               # Dockerfile and docker-compose for ATS container
├── docker_lan/               # Dockerfile and docker-compose for LAN container
├── docker_wan/               # Dockerfile and docker-compose for WAN container
├── fix_interface_name/       # Scripts to fix interface names inside containers
│   ├── fix_interface_name_ats.sh
│   ├── fix_interface_name_lan.sh
│   └── fix_interface_name_wan.sh
├── robot_script/             # Root for Robot Framework test suites
│   └── pytest_router/
│          
│		├── run_test.sh               # 測試入口（支援 --fresh）
│		├── pytest.ini                # pytest 設定（log、marks）
│		├── config.py                 # 全域設定（讀 local.env + 環境變數）
│		├── local.env                 # 本地測試參數（不 commit 密碼進 git）
│		├── requirements.txt          # Python 套件需求
│		│
│		├── tests/
│		│   ├── conftest.py           # 全域 fixtures（serial_console、wan_server、lan_client…）
│		│   ├── connectivity/
│		│   │   └── test_lan_wan_basic.py   # LAN→WAN 端對端測試
│		│   ├── wifi/                 # WiFi 測試（需 WIFI_CLIENT_HOST）
│		│   ├── mesh/                 # Smart Mesh 測試
│		│   ├── routing/              # NAT / 防火牆測試
│		│   ├── system/               # 出廠重置 / 韌體升級
│		│   └── perf/                 # 效能測試
│		│
│		├── lib/
│		│   ├── ssh_helper.py         # paramiko SSH client（支援 Ed25519 / ECDSA / RSA）
│		│   ├── wan_server.py         # env-wan 操作（start_dhcp、restore 等）
│		│   ├── lan_client.py         # env-lan 操作（ping、wget、wait_for_ip 等）
│		│   ├── wifi_client.py        # WiFi client 操作（BPI-R4）
│		│   ├── serial_console.py     # DUT serial console（send_and_wait、diagnostics）
│		│   ├── selenium_helpers.py   # Selenium 共用工具（make_driver、safe_click、checkbox…）
│		│   ├── dut.py                # DUT SSH helper（collect_diagnostics）
│		│   └── dut_setups/
│		│       ├── __init__.py       # 機型 registry（get_setup(model)）
│		│       ├── base.py           # Protocol 定義
│		│       └── wreq_130be.py     # WREQ-130BE 初始設定精靈
│		│
│		├── docs/
│		│   └── lan_wan_test_fixes.md # 關鍵修補記錄
│		│
│		└── reports/                  # 測試報告（git ignore 建議）
│		    └── <YYYYMMDD_HHMMSS>/
│		        ├── report.html
│		        ├── pytest.log
│		        ├── serial.log
│		        ├── allure_results/
│		        └── allure_report/
│
└── robot_test/               # Scripts for executing tests
    └── execute_test.sh       # Main test execution script

```

---

## Host Path ↔ Container Path Mapping

| Host | Container (`env-ats`) |
|---|---|
| `ATS_docker/robot_script/` | `/workspace/tests/robot_script/` |
| `ATS_docker/docker_ats/tests/` | `/workspace/tests/` |
| `~/.ssh` | `/root/.ssh` |

---

## pytest_router 框架（新框架，主要開發中）

路徑：`ATS_docker/robot_script/pytest_router/`
Container 內路徑：`/workspace/tests/robot_script/pytest_router/`

### 執行方式

```bash
# 從 host 執行（在 pytest_router/ 目錄下）
./run_test.sh                          # 執行全部 tests
./run_test.sh tests/connectivity/      # 執行特定目錄
./run_test.sh -m nat                   # 執行特定 mark
./run_test.sh --fresh                  # 先重啟所有 docker，再執行
```

報告輸出到 `reports/<TIMESTAMP>/`：
- `report.html` — pytest-html
- `allure_report/index.html` — Allure 報告（需用 HTTP 伺服器開啟，不可直接 file://）
- `pytest.log` — 完整 DEBUG log（含 paramiko 詳細訊息）
- `serial.log` — 串口輸出
- `capture.pcap` — 封包捕捉（test_nat_with_capture 產生）

### 設定檔

| 檔案 | 說明 |
|---|---|
| `local.env` | 本機覆蓋設定（不 commit）|
| `config.py` | 所有設定讀取入口，先載入 local.env |

重要設定項目（在 `local.env` 或環境變數設定）：

| 變數 | 預設值 | 說明 |
|---|---|---|
| `SELENIUM_HEADLESS` | `false` | false = VNC 可觀察 Firefox |
| `RUN_WAN_MODES` | `false` | true = 執行 wan_dhcp / wan_pppoe 測試 |
| `DUT_IP` | `192.168.1.1` | DUT 管理 IP |
| `SERIAL_PORT` | `/dev/ttyUSB0` | 串口路徑 |

### 測試目錄結構

```
tests/
├── connectivity/          # 基本連線確認（先跑）
│   ├── test_connectivity.py     # env-ats/env-lan/env-wan 互通
│   ├── test_lan_wan_basic.py    # DUT wizard 設定 + LAN→WAN 完整流程
│   ├── test_wan_dhcp.py         # WAN DHCP 模式（RUN_WAN_MODES=true 才跑）
│   └── test_wan_pppoe.py        # WAN PPPoE 模式（RUN_WAN_MODES=true 才跑）
├── routing/
│   └── test_nat.py              # NAT 轉發測試
└── wifi/
    └── test_wifi.py             # WiFi 測試（需 WIFI_CLIENT_HOST 設定）
```

### 重要設計決策

- **`ENV_WAN_HOST`（192.168.100.30）= eth-back IP，不可用於 NAT/WAN 流量測試**
  - NAT 測試應使用 `wan_server.get_wan_iface_ip()` 取得 eth-wan IP（172.16.0.1）
- **`wan_dhcp` / `wan_pppoe` mark 預設 skip**，由 `RUN_WAN_MODES` 控制
- **`lan_client.py` 封包捕捉使用 tshark**（env-lan 沒有 tcpdump）
  - `capture_start()` 使用 `setsid` 確保 process 存活
  - `capture_stop()` 透過 SFTP 將 pcap 下載到 reports 目錄
  - **`wget()` 結尾有 `time.sleep(5)`**：確保 kernel packet buffer 完全 flush 到 tshark 的 BPF socket 後才 return，避免 `capture_stop` kill tshark 時封包尚未被捕捉（0-packet 問題的修正）

### lib/ 主要元件

| 檔案 | 說明 |
|---|---|
| `lan_client.py` | 操作 env-lan：ping、wget、tshark 捕捉、DHCP |
| `wan_server.py` | 操作 env-wan：MAP-E test server start/stop/restore |
| `dut.py` | DUT SSH 連線與診斷 |
| `dut_setups/wreq_130be.py` | WREQ-130BE wizard 自動設定 |
| `serial_console.py` | 串口 console（session 級別，`_wait_ready()` 等待 prompt）|
| `selenium_helpers.py` | Firefox WebDriver（`SELENIUM_HEADLESS` 控制）|
| `ssh_helper.py` | paramiko SSHClient wrapper |

### env-wan MAP-E Test Server

路徑（container 內）：`/workspace/tests/Ubuntu_MAP-E_Test-server/`
路徑（host）：`ATS_docker/docker_wan/tests/Ubuntu_MAP-E_Test-server/`（volume mount，重啟不消失）

`start.sh -D`：啟動 DHCPv4 server，eth-wan 設定 `172.16.0.1/24`
`start.sh -P`：啟動 PPPoE server
`stop.sh`：停止所有服務，清除 routing（會清掉 eth-back route，由 `_BACK_RESTORE` 補回）
`restore.sh`：完整還原（目前有 bug：`[: TRUE: unary operator expected`，rc=1）

> **注意**：`restore.sh` 目前會 fail（sub_routine.sh line 464 bash 比較語法錯誤），
> 但不影響主要 stop/start 流程。
