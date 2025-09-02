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

## Recent Updates

### Ansible-Lint Fixes and Compliance Improvements

The project has been updated to resolve all ansible-lint errors and improve code quality:

- **Boolean Values**: Replaced truthy values (`yes`/`no`) with boolean `true`/`false` for better compliance
- **Indentation**: Corrected indentation issues and removed trailing spaces
- **Module Names**: Updated to fully qualified collection names (e.g., `ansible.builtin.command`, `ansible.posix.synchronize`)
- **Idempotent Commands**: Added `changed_when: false` to commands that should not report changes
- **Variable Naming**: Improved variable naming consistency across roles
- **Task Structure**: Improved task ordering and added proper `name` fields

### GitHub Actions CI/CD Pipeline Updates

The CI/CD pipeline has been enhanced with the following improvements:

- **Ansible Version**: Updated from `2.16` (non-existent) to `11.1.0` (stable version)
- **CodeQL Action**: Updated to version `v3` to fix deprecation warnings
- **Error Handling**: Added `continue-on-error: true` to SARIF upload step to prevent pipeline failures due to permission issues
- **Pipeline Stages**:
  - Ansible linting with auto-fix capability
  - Syntax checks for main playbooks (site.yml, cluster-init.yml, cluster-join.yml)
  - Inventory validation for staging and production environments
  - Security scanning with Trivy vulnerability scanner
  - Deployment stages for staging and production environments

### Files Updated

The following files have been modified to resolve linting issues and improve functionality:

- `site.yml` - Main orchestration playbook with boolean fixes and improved task structure
- `cluster-init.yml` - Cluster initialization playbook with compliance updates
- `cluster-join.yml` - Node joining playbook with module name updates
- `roles/common/tasks/main.yml` - Common system configuration tasks
- `roles/common/handlers/main.yml` - System service handlers
- `roles/ha/tasks/main.yml` - HAProxy configuration tasks
- `roles/kubernetes/tasks/main.yml` - Kubernetes component installation tasks
- `.github/workflows/ansible-lint.yml` - CI/CD pipeline configuration

### Requirements Updates

- **Ansible**: Updated minimum version requirement to 2.15+ for better collection support
- **Python**: Maintained 3.8+ requirement
- **Collections**: Added explicit requirements for `ansible.posix` and `community.general`

### Testing and Validation

- All playbooks now pass ansible-lint checks
- GitHub Actions pipeline runs successfully without errors
- Syntax validation passes for all main playbooks
- Inventory validation works for both staging and production environments

## Additional Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Lint Documentation](https://ansible-lint.readthedocs.io/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
