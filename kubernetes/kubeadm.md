##  Setup Kubernetes [Kubeadm] Cluster (Version: 1.28)

### On both master & worker nodes
- <i>  Become root user </i>
```bash
sudo su
```

- <i>  Updating System Packages </i>
```bash
sudo apt-get update
```

- <i> Installing Docker </i>
```bash
sudo apt install docker.io -y
sudo chmod 777 /var/run/docker.sock
```

- <i> Installing Required Dependencies for Kubernetes kubeadm </i>
```bash
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo mkdir -p -m 755 /etc/apt/keyrings
```

- <i> Adding Kubernetes Repository and GPG Key </i>

```bash
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

- <i> Updating Package List </i>
```bash
sudo apt update
```

- <i> Install Kubernetes Components </i>

```bash
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1
```

### On Master node
- <i> Initializing Kubernetes Master Node </i>

```bash
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```

- <i> Run below command and copy kubeadm join command to connect worker node in the cluster </i>

```bash
kubeadm token create --print-join-command
```

- <i> Configure Kubernetes kubeadm cluster </i>
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

- <i> Deploying calico Network </i>
```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

- <i> Deploy Ingress Controller (NGINX) </i>
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml
```

### On Worker node
- <i> Paste the join command you got from the master node and append --v=5 at the end </i>

```bash
<join-command> --v=5
```


