# poseidon
A docker container for testing resilience in a Kubernetes environment.
Poseidon is responsible for putting additional cpu stress on your Kubernetes Environment.

Version 1.0.0

## Starting poseidon
To start poseidon, use a YAML file like the one below to deploy it to your kubernetes cluster.

```
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: poseidon
  labels:
    app: poseidon
spec:
  replicas: 1
  template:
    metadata:
      name: poseidon
      labels:
        app: poseidon
        name: poseidon-pod
    spec:
      containers:
      - name: poseidon
        image: xenokube/poseidon:1.0.0
        ports:
          - containerPort: 8000
```

Using the file above, run the following command.

```
kubectl apply -f deploy_poseidon.yaml
```

Poseidon needs a kubeconfig YAML and relevant authentication files.
This is so that Poseidon can interact with your cluster.

By default, Poseidon will put your Kubernetes cluster under stress every hour,
using 10 poseidon clones, running stress for 4 cpus, for 3 minutes.
