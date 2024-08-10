## ERaft
ERaft is a raft algorithm library with rich features, based on the algorithm library, we provided an example implementation of a distributed KV storage system.

> :warning: ERaft is still being developed, you can find a golang version for ebooks - [Distributed Data Services](https://3.cn/1W-jAWMR) at branch [eraftbook](https://github.com/eraft-io/eraft/tree/eraftbook) 

## ERaft Features
- Strong and consistent data storage ensures secure and reliable data persistence in distributed systems.
- Support KV data type operations, including PUT, GET, DEL, and SCAN operations on keys. When users operate on cluster data, they must ensure the persistence of the operation and the sequential consistency of reading and writing.
- Dynamically configure the cluster, including adding and deleting nodes, adding and deleting cluster sharding configurations, including which keyrange the cluster sharding is responsible for.
- Support for snapshot taking with the raft to compress and merge logs. During the snapshot, it is required to not block data read and write.
- Support switching to a specifying leader.
- Raft elections support PreVote, and newly added nodes do not participate in the election by tracking data to avoid triggering unnecessary elections.
- Raft read optimization: adding a read queue ensures that the leader node returns a read request after submitting it, and unnecessary logs are not written.
- Support data migration, multi-shard scale out.

# Getting Started

## Build 

Execute follow build command on the machine with docker installed.

```
sudo make build-dev
```

## Run demo in docker

- step 1, create docker sub net

```
sudo make create-net
```

command output
```
docker network create --subnet=172.18.0.0/16 mytestnetwork
f57ad3d454f27f4b84efca3ce61bf4764bd30ce3d4971b85477daf05c6ae28a3
```

- step 2, run cluster in shard mode

```
sudo make run-demo
```

- step 3, use eraftkv-ctl to operator the cluster

```
add_group: ./eraftkv-ctl [metaserver addresses] add_group [groupid] [group server addresses]
remove_group: ./eraftkv-ctl [metaserver addresses] remove_group [group id] [node id]
query_groups: ./eraftkv-ctl [metaserver addresses] query_groups
set_slot: ./eraftkv-ctl [metaserver addresses] set_slot [groupid] [startSlot-endSlot]
put_kv: ./eraftkv-ctl [metaserver addresses] put_kv [key] [value]
get_kv: ./eraftkv-ctl [metaserver addresses] get_kv [key]
```

You can use follow command to run a basic rw bench test with ERaftKV
```
sudo make run-demo-test
```

- step 4, clean all
```
sudo make stop-demo
sudo make rm-net
```

# Contributing

You can quickly participate in development by following the instructions in [CONTROLUTING.md](https://github.com/eraft-io/eraft/blob/master/CONTRIBUTING.md)
