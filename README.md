### Prerequisites

- Docker and Docker compose.
- Before starting the container, make sure the <b>gNB and UE configuration in `.env`</b> is correct.
- Change <b>network configuration in `docker-compose.yaml`</b>.
> [!IMPORTANT]
> Be careful not to mess with other devices running in your network.
> Check which IP's you can use and add all other IP's to the `aux_addresses` section.

### Simulate gNB's: 

- Build the container:

```bash
docker compose build
```

- Start as many containers as gNBs you want to simulate:

```bash
docker compose up --scale ueransim=<number_of_gnb_instances>
```

> [!NOTE]
> The gNB IP is the Docker container IP address.

### Simulate UE's

- Open `create_gnb_and_ue_session_for_container.sh` and specify how many 'nr-ue' processes (<b>ue_processes</b>) and how many UEs per process (<b>ue_on_each_process</b>) you want to run on each gNB. This will create <b>ue_processes</b> * <b>ue_on_each_process</b> UE(s) on that specific gNB.

- Execute the script:
  
```bash
bash create_gnb_and_ue_session_for_container.sh
```

### Test UE's

- Connect to a running container:

```bash
docker exec -it <container> /bin/sh
```

- Test Internet connectivity:

```bash
ping -I uesimtunX google.es
```

> [!NOTE]
> Each UE has a separate <i>uesimtunX</i> interface. If you created 3 UE's, you would find <i>uesimtun0</i>, <i>uesimtun1</i> and <i>uesimtun2</i> interfaces.

### Generate traffic from UE's

- Execute the following script, that will generate traffic from each <i>uesimtunX</i> interface of each gNb by pinging <b>google.es</b>:

```bash
bash ping.sh
```

- To stop it run the following script:

```bash
bash stop.sh
```
