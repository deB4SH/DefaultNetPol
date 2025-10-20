Helm Chart for Kubernetes Network Policies
===

This Helm chart provides a flexible way to deploy Kubernetes [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) resources. It allows you to define and manage network policies through a values.yaml file, enabling fine-grained control over pod-to-pod communication within your cluster.

# Installation
1) Add the Helm repository (if hosted publicly):
```bash
helm repo add netpol TODO_REPO_HERE
```
2) Fetch and install the chart:
```bash
helm install mynetpols netpol/defaultnetpol
```
3) Customize configuration via values.yaml (see Configuration section).

# Configuration
```yaml
netPol:
  enabled: false  # Enable/Disable network policy deployment
  policies:       # Array of network policy definitions
    - name: "example-policy"
      namespace: "default"
      annotations:
        "example.com/annotation": "value"
      labels:
        "app": "example"
      policyTypes:
        - "Ingress"
        - "Egress"
      ingress:
        - from:
            - ipBlock:
                cidr: "192.168.1.0/24"
                except:
                  - "192.16.1.100/32"
      egress:
        - to:
            - ipBlock:
                cidr: "0.0.0.0/0"
      podSelector:
        matchLabels:
          app: "example"
```
Key Parameters
* `enabled`: Enable or disable the deployment of network policies.
* `name`: Unique name for the network policy.
* `namespace`: Namespace where the policy will be applied (default: default).
* `annotations`: Custom annotations for the policy.
* `labels`: Labels to apply to the policy resource.
* `policyTypes`: Define whether the policy applies to Ingress, Egress, or both.
* `ingress/egress`: Rules for controlling traffic (e.g., IP blocks, ports).
* `podSelector`: Select the pods affected by the policy (e.g., via labels).


# Example Usage

## Simple Ingress Policy
Allow traffic to pods labeled `app: example` from 192.168.1.0/24:

```yaml
netPol:
  enabled: true
  policies:
    - name: "allow-internal-ingress-traffic"
      namespace: "default"
      policyTypes:
        - "Ingress"
      ingress:
        - from:
            - ipBlock:
                cidr: "192.168.1.0/24"
      podSelector:
        matchLabels:
          app: "example"
```
## Egress Policy for Specific IPs
Allow egress to a specific IP range:

```yaml
netPol:
  enabled: true
  policies:
    - name: "allow-egress-to-specific-external-adr"
      namespace: "default"
      policyTypes:
        - "Egress"
      egress:
        - to:
            - ipBlock:
                cidr: "1.2.3.0/24"
      podSelector:
        matchLabels:
          app: "example"
```