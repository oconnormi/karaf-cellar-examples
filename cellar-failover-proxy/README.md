# Karaf HA Failover Example


**NOTE:** This is a work in progress (fair warning ;-P )


The goal of this example is to Configure three Karaf nodes in a cluster with the first node acting as a cellar-http-balancer to the two other backend nodes. The cellar-http-balancer should handle failover between the two backend nodes when one becomes unresponsive

![Failover Diagram](http://g.gravizo.com/g?
  digraph failover {
    "cellar-http-balancer" [shape=box];
    karaf1 [shape=box];
    karaf2 [shape=box];
    "cellar-http-balancer" -> karaf1;
    "cellar-http-balancer" -> karaf2 [style="dotted", label="failover"];
    subgraph backend {
      rank = same; karaf1; karaf2;
      karaf1 -> karaf2 [label="Sync configs/features", dir="both"];
    }
  }
)

# Run example

From this directory run

```shell
docker-compose up
```

This will bring up all three nodes and configure them. After the setup is done go to `http://localhost:8181/system/console` to perform further configuration

# Node Configurations

The goal is that the backend nodes should always be in sync while the load-balancer simply receives http route updates

## Load Balancer Node Configuration

### Cluster Event Configurations
*   **Cluster Group:** load-balancer
*   **BundleEventHandler:** false
*   **ConfigurationEventHandler:** false
*   **FeaturesEventHandler:** false
*   **RemoteServiceCallHandler:** false
*   **ClusterEventHandler:** false
*   **ObrBundleEventHandler:** false
*   **ObrUrlEventHandler:** false
*   **BalancerEventHandler:** true

### Local Listener Configurations
*   **Cluster Event Producer:** false
*   **Cluster Event Consumer:** true
*   **Bundle Listener:** false
*   **Config Listener:** false
*   **Feature Listener:** false

## Backend Node Configuration

### Cluster Event Configurations
*   **Cluster Group:** load-balancer, web
*   **BundleEventHandler:** true
*   **ConfigurationEventHandler:** true
*   **FeaturesEventHandler:** true
*   **RemoteServiceCallHandler:** true
*   **ClusterEventHandler:** true
*   **ObrBundleEventHandler:** true
*   **ObrUrlEventHandler:** true
*   **BalancerEventHandler:** true

### Local Listener Configurations
*   **Cluster Event Producer:** true
*   **Cluster Event Consumer:** true
*   **Bundle Listener:** true
*   **Config Listener:** true
*   **Feature Listener:** true
