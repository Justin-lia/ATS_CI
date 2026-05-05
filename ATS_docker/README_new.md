# Automated Testing Environment with Docker

This repository provides an automated testing environment leveraging Docker and Robot Framework. It allows for flexible network configurations (VLAN-based or dedicated NICs) to test Devices Under Test (DUTs) for WAN, LAN, and ATS functionalities.

## 1. Project Structure

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
│   ├── send_mail_note/       # Scripts for test reporting and email notification
│   └── White_label_ATS-WREQ-130BE/ # Example Robot Framework test suite
└── robot_test/               # Scripts for executing tests
    └── execute_test.sh       # Main test execution script
```

## 2. Configure `config.sh`

The `config.sh` script defines network interfaces, VLAN IDs, and MAC addresses for the Docker containers. It also includes an auto-update mechanism for interface and VLAN configurations.

*   `ats_interface`: The physical host NIC connected to the ATS environment (could be direct to DUT or to a switch).
*   `lan_interface`: The logical or physical interface for the DUT's LAN side. If using VLANs, this will be `ats_interface.<VLAN_ID>`.
*   `wan_interface`: The logical or physical interface for the DUT's WAN side. If using VLANs, this will be `ats_interface.<VLAN_ID>`.
*   `lan_vlan_id`, `wan_vlan_id`, `backup_vlan_id`: VLAN IDs used when sharing a single physical NIC.

**Scenario A — Host PC has only 1 NIC (Using a Switch + VLAN)**

Topology:
```
HOST PC ──[Switch]── WAN (DUT)
                  ├─ LAN (DUT)
                  └─ Internet
```
All ATS, LAN, and WAN traffic share the same physical NIC and are separated by VLANs.

Edit `config.sh` as follows:
```bash
ats_interface='enp3s0f1'   # Host PC NIC connected to switch
lan_interface='enp3s0f1.20' # Same physical NIC with VLAN 20
wan_interface='enp3s0f1.30' # Same physical NIC with VLAN 30

lan_vlan_id='20'          # VLAN for DUT LAN
wan_vlan_id='30'          # VLAN for DUT WAN
backup_vlan_id='99'       # Backup VLAN for Docker internal network
```
*Note: When setting `lan_interface` or `wan_interface` with a VLAN ID (e.g., `enp3s0f1.20`), the script will automatically update the corresponding `lan_vlan_id` or `wan_vlan_id` variable.*

**Scenario B — Host PC has 3 NICs (No Switch)**

Topology:
```
HOST PC ── Internet
        ├─ WAN (DUT)
        └─ LAN (DUT)
```
Each DUT port and Host PC uses a dedicated NIC.

Edit `config.sh` as follows:
```bash
ats_interface='enp3s0'     # Connected to Internet
lan_interface='enp4s0'     # Connected to DUT LAN
wan_interface='enp5s0'     # Connected to DUT WAN

lan_vlan_id='20'          # Not used in this scenario, but defined
wan_vlan_id='30'          # Not used in this scenario, but defined
backup_vlan_id='99'       # Used on ats_interface for Docker internal network
```

## 3. Setup Host Interfaces and Start Docker Environment

Run the following scripts in order to set up your host network and start the Docker containers:

```bash
./remove_vlan_interface.sh
./interface_vlan_set.sh
./start_env.sh
```

**Script Descriptions:**

*   `remove_vlan_interface.sh`: Deletes any existing VLAN interfaces configured on the host based on `config.sh`.
*   `interface_vlan_set.sh`: Creates VLAN sub-interfaces on the host based on the `ats_interface`, `lan_vlan_id`, `wan_vlan_id`, and `backup_vlan_id` defined in `config.sh`. It also enables promiscuous mode on the main `ats_interface`.
*   `start_env.sh`:
    *   Sources `config.sh` and exports all interface and MAC address variables for Docker Compose.
    *   Creates an external `macvlan` Docker network named `env_net` (subnet `192.168.100.0/24`), using the configured `env_backup_interface` as its parent. This network facilitates communication between the Docker containers.
    *   Navigates into `docker_ats`, `docker_lan`, and `docker_wan` directories and executes `docker compose up -d` to build (if not already built) and start the respective Docker services in detached mode.

## 4. Docker Environment Details

The environment consists of three Docker containers:

*   **`env-ats` (ATS Container)**:
    *   **Image**: `env-ats:v1`
    *   **Networks**:
        *   `env_net` (connected to `env_backup_interface` on host, IP `192.168.100.10`) for backend communication.
        *   `ats_net_dut_lan` (macvlan, parent `env_lan_interface` on host, subnet `192.168.1.0/24`) for connecting to DUT's LAN.
        *   `ats_net_internet` (macvlan, parent `env_ats_interface` on host) for internet access.
    *   **Volumes**: Mounts `./tests` to `/workspace/tests` (containing `config.sh` and `fix_interface_name_ats.sh`), `../robot_script` to `/workspace/tests/robot_script` (containing actual Robot Framework tests), and `~/.ssh` for SSH access.
    *   **Entrypoint**: `fix_interface_name_ats.sh` renames container interfaces to `eth-back`, `eth-lan`, `eth-inet`.
    *   **Command**: Starts Xvfb (virtual display) and x11vnc for GUI interaction.
*   **`env-lan` (LAN Container)**:
    *   **Image**: `env-lan:v1`
    *   **Networks**:
        *   `env_net` (connected to `env_backup_interface` on host, IP `192.168.100.20`) for backend communication.
        *   `lan_net_dut_lan` (macvlan, parent `env_lan_interface` on host) for connecting to DUT's LAN.
    *   **Entrypoint**: `fix_interface_name_lan.sh` renames interfaces.
    *   **Command**: Starts `inetd` and `sshd`.
*   **`env-wan` (WAN Container)**:
    *   **Image**: `env-wan:v1`
    *   **Networks**:
        *   `env_net` (connected to `env_backup_interface` on host, IP `192.168.100.30`) for backend communication.
        *   `wan_net_dut_wan` (macvlan, parent `env_wan_interface` on host, IPv6 enabled) for connecting to DUT's WAN.
    *   **Entrypoint**: `fix_interface_name_wan.sh` renames interfaces.
    *   **Command**: Starts `inetd`, `ntpd`, and `sshd`.

## 5. Test Case Location

Robot Framework test suites are located in the `robot_script/` directory on the host. For example:

```
/home/gtk/gemini_cli/ATS_docker/robot_script/White_label_ATS-WREQ-130BE/
```

Inside the `env-ats` Docker container, these test suites are accessible under:

```
/workspace/tests/robot_script/White_label_ATS-WREQ-130BE/
```

## 6. Execute Test Cases

The primary script for executing tests is `./robot_test/execute_test.sh`. This script is designed to run a specific test suite within the `env-ats` container.

Check the execution script:
```bash
cat ./robot_test/execute_test.sh
```

Example execution (as defined in `execute_test.sh`):
```bash
docker exec -w /workspace/tests/robot_script/White_label_ATS-WREQ-130BE env-ats sh ./test.sh
```

**Explanation:**

| Item                                                        | Description                                                                                                                                                                                                                                                                                                                                             |
| :---------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `env-ats`                                                   | The name of the ATS Docker container.                                                                                                                                                                                                                                                                                                                   |
| `/workspace/tests/robot_script/White_label_ATS-WREQ-130BE` | The working directory *inside the container* where the test suite is located. This corresponds to `/home/gtk/gemini_cli/ATS_docker/robot_script/White_label_ATS-WREQ-130BE/` on your host machine. **Ensure a `test.sh` script exists in your chosen test suite directory for `execute_test.sh` to function correctly.** |
| `./test.sh`                                                 | The script to be executed *inside the container* to start the Robot Framework tests.                                                                                                                                                                                                                                                                     |

*Note: The `robot_script/send_mail_note/run_test.sh` script is for generating test reports and sending email notifications, not for direct test execution.*

## 7. Stop the Environment

To stop all running Docker containers and prune unused networks, execute:

```bash
./stop_all_docker.sh
```

## 8. Test Reports

Test reports (e.g., `output.xml`, `log.html`, `report.html`) are typically generated within the test suite directory. For the example `White_label_ATS-WREQ-130BE` suite, reports would be found in a `report/` subdirectory within the test suite, such as:

```
/home/gtk/gemini_cli/ATS_docker/robot_script/White_label_ATS-WREQ-130BE/report/
```
The exact report location can be defined within the `test.sh` script of the specific test suite.

## 9. Full Test Flow

1.  **Configure `config.sh`**: Set up host interfaces and VLAN IDs based on your hardware topology (1 NIC with VLANs or multiple dedicated NICs).
2.  **Clean VLANs**: `./remove_vlan_interface.sh`
3.  **Create VLANs**: `./interface_vlan_set.sh`
4.  **Start Docker Environment**: `./start_env.sh` (This will build images if needed and start `env-ats`, `env-lan`, `env-wan` containers).
5.  **Run Tests**: `./robot_test/execute_test.sh` (This will execute the specified `test.sh` script within the `env-ats` container).
6.  **Stop Docker Environment (Optional)**: `./stop_all_docker.sh`
