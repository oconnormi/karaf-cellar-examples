# Karaf HA Failover Example

The goal of this example is to Configure three Karaf nodes in a cluster with the first node acting as a proxy to the two other backend nodes. The proxy should handle failover between the two backend nodes when one becomes unresponsive

![Alt text](http://g.gravizo.com/g?
  digraph failover {
    proxy [shape=box];
    node1 [shape=box];
    node2 [shape=box];
    proxy -> node1;
    proxy -> node2 [style="dotted", label="failover"]
    subgraph backend {
      rank = same; node1; node2;
      node1 -> node2 [label="Sync configs/features", dir="both"];
    }
  }
)

-----

# Run example

From this directory run

```shell
docker-compose up
```

This will bring up all three nodes and configure them. After the setup is done go to `http://localhost:8181/system/console` to perform further configuration
