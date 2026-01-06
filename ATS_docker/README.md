markdown
```

├── README.md
├── start_env.sh
├── interface_vlan_set.sh
├── remove_vlan_interface.sh
├── fix_interface_name_wan.sh
├── fix_interface_name_lan.sh
├── fix_interface_name_ats.sh
├── config.sh
├── docker_ats/
├── docker_lan/
└── docker_wan/

```

---

# 1. Configure `config.sh`

The network configuration depends on how many physical NICs the Host PC has.

---

## Scenario A — Host PC has only 1 NIC (Using a Switch + VLAN)

Topology:

```

HOST PC ──[Switch]── WAN (DUT)
                  ├─ LAN (DUT)
                  └─ Internet

````

All ATS, LAN, and WAN traffic share the same physical NIC and are separated by VLAN.

Edit `config.sh`:

```bash
ats_interface='enp3s0f1'   # Host PC NIC connected to switch
lan_interface='enp3s0f1'   # Same physical NIC
wan_interface='enp3s0f1'   # Same physical NIC

lan_vlan_id='20'          # VLAN for DUT LAN
wan_vlan_id='30'          # VLAN for DUT WAN
backup_vlan_id='99'       # Backup
````

---

## Scenario B — Host PC has 3 NICs (No Switch)

Topology:

```
HOST PC ── Internet
        ├─ WAN (DUT)
        └─ LAN (DUT)
```

Each DUT port and HOST PC uses a dedicated NIC.

Edit `config.sh`:

```bash
ats_interface='enp3s0'     # Connected to Internet
lan_interface='enp4s0'     # Connected to DUT LAN
wan_interface='enp5s0'     # Connected to DUT WAN

lan_vlan_id='20'          # Not used
wan_vlan_id='30'          # Not used
backup_vlan_id='99'       # Used on ats_interface
```

---

# 2. Setup Host Interfaces

Run the following scripts in order:

```bash
./remove_vlan_interface.sh
./interface_vlan_set.sh
./start_env.sh
```

Descriptions:

* `remove_vlan_interface.sh`
  Removes all existing VLAN interfaces.

* `interface_vlan_set.sh`
  Creates VLAN interfaces based on `config.sh`.

* `start_env.sh`
  Builds and starts the Docker environment (creates images on first run).

---

# 3. Test Case Location

Place test cases under:

```
./ATS_CI/ATS_docker/docker_ats/tests/
```

Example:

```
./ATS_CI/ATS_docker/docker_ats/tests/White_label_ATS-WREQ-130BE/
```

---

# 4. Execute Test Cases

Check the execution script:

```bash
cat ./ATS_CI/ATS_docker/robot_test/execute_test.sh
```

Actual execution:

```bash
docker exec -w /workspace/tests/White_label_ATS-WREQ-130BE env-ats sh ./test.sh
```

Explanation:

| Item                                          | Description                  |
| --------------------------------------------- | ---------------------------- |
| `env-ats`                                     | ATS Docker container         |
| `/workspace/tests/White_label_ATS-WREQ-130BE` | Test folder inside container |
| `test.sh`                                     | Test execution script        |

---

# 5. Test Reports

Reports are generated in:

```
./ATS_CI/ATS_docker/docker_ats/tests/White_label_ATS-WREQ-130BE/report/
```

The report directory is defined inside `test.sh`.

---

# 6. Full Test Flow

```
1. Setup Host PC network
2. ./remove_vlan_interface.sh     # Clean VLANs
3. ./interface_vlan_set.sh        # Create VLANs
4. ./start_env.sh                 # Start Docker environment
5. ./robot_test/execute_test.sh   # Run tests
```
