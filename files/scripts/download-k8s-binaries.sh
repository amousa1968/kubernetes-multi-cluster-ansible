#!/bin/bash

set -e

K8S_VERSION=${1:-"1.28.0"}
BIN_DIR="/usr/local/bin"
TMP_DIR="/tmp/k8s-binaries"

# Create directories
mkdir -p "${BIN_DIR}"
mkdir -p "${TMP_DIR}"

# Download and install Kubernetes binaries
download_binary() {
    local component=$1
    local url="https://dl.k8s.io/release/v${K8S_VERSION}/bin/linux/amd64/${component}"
    local checksum_url="https://dl.k8s.io/v${K8S_VERSION}/bin/linux/amd64/${component}.sha256"
    
    echo "Downloading ${component} v${K8S_VERSION}..."
    
    # Download binary
    curl -L --progress-bar -o "${TMP_DIR}/${component}" "${url}"
    
    # Download checksum
    curl -L --progress-bar -o "${TMP_DIR}/${component}.sha256" "${checksum_url}"
    
    # Verify checksum
    echo "$(cat ${TMP_DIR}/${component}.sha256)  ${TMP_DIR}/${component}" | sha256sum --check
    
    if [ $? -eq 0 ]; then
        install -o root -g root -m 0755 "${TMP_DIR}/${component}" "${BIN_DIR}/${component}"
        echo "✓ Installed ${component} to ${BIN_DIR}"
    else
        echo "✗ Checksum verification failed for ${component}"
        exit 1
    fi
}

# Download components
components=("kubelet" "kubeadm" "kubectl")
for component in "${components[@]}"; do
    download_binary "${component}"
done

# Cleanup
rm -rf "${TMP_DIR}"

echo "✅ Kubernetes binaries v${K8S_VERSION} installed successfully"
