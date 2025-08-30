# Kubernetes Multi-Cluster Ansible Playbook

Ansible playbook for deploying Kubernetes clusters across multiple environments.

## Features

- Multi-cluster support (production, staging, etc.)
- Kubernetes version management
- CNI networking (Calico)
- High availability support
- Automated binary downloads
- System configuration optimization

## Requirements

- Ansible 2.12+
- Python 3.8+
- Ubuntu 20.04/22.04 nodes

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/your-username/kubernetes-multi-cluster-ansible.git
cd kubernetes-multi-cluster-ansible
```

2. Install roles:
```bash
ansible-galaxy install -r requirements.yml
```

3. Configure inventory:
```bash
cp inventories/production/hosts.example inventories/production/hosts
# Edit hosts file with your server IPs
```

4. Deploy cluster:
```bash
ansible-playbook -i inventories/production/hosts site.yml
```

## Inventory Structure

```
inventories/
├── production/
│   ├── group_vars/
│   │   ├── all.yml      # Common variables
│   │   ├── master.yml   # Master-specific variables
│   │   └── worker.yml   # Worker-specific variables
│   └── hosts           # Inventory hosts
└── staging/
    └── ...             # Same structure for staging
```

## Usage Examples

```bash
# Deploy production cluster
ansible-playbook -i inventories/production/hosts site.yml

# Deploy staging cluster
ansible-playbook -i inventories/staging/hosts site.yml

# Initialize specific cluster
ansible-playbook -i inventories/production/hosts cluster-init.yml

# Join workers to cluster
ansible-playbook -i inventories/production/hosts cluster-join.yml
```

## Variables

Key variables can be set in group_vars files:

- `k8s_version`: Kubernetes version (default: 1.28.0)
- `pod_network_cidr`: Pod network CIDR (default: 10.244.0.0/16)
- `service_cidr`: Service CIDR (default: 10.96.0.0/12)
- `control_plane_endpoint`: Load balancer endpoint

## License

MIT License

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
# kubernetes-multi-cluster-ansible
# kubernetes-multi-cluster-ansible
