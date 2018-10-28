#!/bin/bash
set -v

docker stop mysql-dc1 
docker rm mysql-dc1
docker stop mysql-dc2
docker rm mysql-dc2
docker stop dtle-dc1
docker rm dtle-dc1
docker stop dtle-dc2
docker rm dtle-dc2
docker network rm dtle-net-dc1
docker network rm dtle-net-dc2
docker network rm dtle-net-public

docker network create dtle-net-dc1 
docker network create dtle-net-dc2 
docker network create dtle-net-public --subnet=172.24.0.0/16
sleep 2
docker run --name mysql-dc1 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_ROOT_HOST=% -e MYSQL_DATABASE=demo --network=dtle-net-dc1 -d mysql/mysql-server:5.7 --gtid-mode=ON --enforce-gtid-consistency=1 --log-bin=bin --server-id=1
docker run --name mysql-dc2 -e MYSQL_ROOT_PASSWORD=pass -e MYSQL_ROOT_HOST=% -e MYSQL_DATABASE=demo --network=dtle-net-dc2 -d mysql/mysql-server:5.7 --gtid-mode=ON --enforce-gtid-consistency=1 --log-bin=bin --server-id=2

docker run --name dtle-dc1 -p 8191:8190 --network=dtle-net-dc1 -d actiontech/dtle
docker run --name dtle-dc2 -p 8192:8190 --network=dtle-net-dc2 -d actiontech/dtle
sleep 2
docker network connect dtle-net-public dtle-dc1
docker network connect dtle-net-public dtle-dc2

docker exec -u root -i dtle-dc1 sh -c 'cat > /etc/dtle/dtle.conf' << EOF
# Setup data dir
data_dir = "/dtle/data"
log_level = "DEBUG"
bind_addr = "172.24.0.2"
advertise {
    rpc = "172.24.0.2"
}

# Modify our port to avoid a collision with server
ports {
    http = 8190
}

# Enable the manager
manager {
    enabled = true
    join = [ "dtle-dc1" ]
}

# Enable the agent
agent {
    enabled = true
    managers = ["dtle-dc1:8191"]
}
EOF
docker exec -u root -it dtle-dc1 rm -rf /dtle/data
docker restart dtle-dc1

docker exec -u root -i dtle-dc2 sh -c 'cat > /etc/dtle/dtle.conf' << EOF
# Setup data dir
data_dir = "/dtle/data"
log_level = "DEBUG"
bind_addr = "172.24.0.3"
advertise {
    rpc = "172.24.0.3"
}

# Modify our port to avoid a collision with server
ports {
    http = 8190
}

# Enable the manager
manager {
    enabled = false
}

# Enable the agent
agent {
    enabled = true
    managers = ["dtle-dc1:8191"]
}
EOF
docker exec -u root -it dtle-dc2 rm -rf /dtle/data
docker restart dtle-dc2
sleep 1
docker ps