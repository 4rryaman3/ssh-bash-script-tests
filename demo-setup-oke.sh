#!/usr/bin/env bash
set -euo pipefail

# =========================================================
# ENSURE EXPORTS PERSIST (must be sourced)
# =========================================================
SCRIPT_NAME="${BASH_SOURCE[0]}"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "[ERROR] This script must be sourced:"
  echo "  source \"$SCRIPT_NAME\""
  exit 1
fi

# =========================================================
# REQUIRED ENV VARIABLES
# =========================================================
: "${OCI_USER_OCID:?Missing OCI_USER_OCID}"
: "${OCI_TENANCY_OCID:?Missing OCI_TENANCY_OCID}"
: "${OCI_FINGERPRINT:?Missing OCI_FINGERPRINT}"
: "${OCI_REGION:?Missing OCI_REGION}"
: "${OCI_PRIVATE_KEY_PATH:?Missing OCI_PRIVATE_KEY_PATH}"
: "${OKE_CLUSTER_OCID:?Missing OKE_CLUSTER_OCID}"

# =========================================================
# CLEAN VARIABLES (remove CRLF / spaces)
# =========================================================
clean_var() { echo "$1" | tr -d '\r' | xargs; }

OCI_USER_OCID="$(clean_var "$OCI_USER_OCID")"
OCI_TENANCY_OCID="$(clean_var "$OCI_TENANCY_OCID")"
OCI_FINGERPRINT="$(clean_var "$OCI_FINGERPRINT")"
OCI_REGION="$(clean_var "$OCI_REGION")"
OCI_PRIVATE_KEY_PATH="$(clean_var "$OCI_PRIVATE_KEY_PATH")"
OKE_CLUSTER_OCID="$(clean_var "$OKE_CLUSTER_OCID")"

OCI_PROFILE="${OCI_PROFILE:-DEFAULT}"
OCI_PASSPHRASE="${OCI_PASSPHRASE:-}"
KUBE_ENDPOINT="${KUBE_ENDPOINT:-PUBLIC_ENDPOINT}"
TOKEN_VERSION="${TOKEN_VERSION:-2.0.0}"

# =========================================================
# PERMANENT USER PATHS
# =========================================================
OCI_DIR="$HOME/.oci"
KUBE_DIR="$HOME/.kube"
OCI_CONFIG_PATH="$OCI_DIR/config"
KUBECONFIG_PATH="$KUBE_DIR/config"

echo "[INFO] Preparing user directories"

mkdir -p "$OCI_DIR"
mkdir -p "$KUBE_DIR"

chmod 700 "$OCI_DIR"
chmod 700 "$KUBE_DIR"

# =========================================================
# WRITE OCI CONFIG
# =========================================================
echo "[INFO] Writing OCI config -> $OCI_CONFIG_PATH"

cat > "$OCI_CONFIG_PATH" <<EOF
[$OCI_PROFILE]
user=$OCI_USER_OCID
tenancy=$OCI_TENANCY_OCID
fingerprint=$OCI_FINGERPRINT
region=$OCI_REGION
key_file=$OCI_PRIVATE_KEY_PATH
EOF

if [[ -n "$OCI_PASSPHRASE" ]]; then
  echo "pass_phrase=$OCI_PASSPHRASE" >> "$OCI_CONFIG_PATH"
fi

chmod 600 "$OCI_CONFIG_PATH"

# Fix private key permissions (important!)
if [[ -f "$OCI_PRIVATE_KEY_PATH" ]]; then
  chmod 600 "$OCI_PRIVATE_KEY_PATH" || true
fi

# =========================================================
# GENERATE KUBECONFIG DIRECTLY INTO ~/.kube/config
# =========================================================
echo "[INFO] Generating kubeconfig -> $KUBECONFIG_PATH"

OCI_CLI_CONFIG_FILE="$OCI_CONFIG_PATH" \
OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True \
oci ce cluster create-kubeconfig \
  --cluster-id "$OKE_CLUSTER_OCID" \
  --file "$KUBECONFIG_PATH" \
  --region "$OCI_REGION" \
  --token-version "$TOKEN_VERSION" \
  --kube-endpoint "$KUBE_ENDPOINT"

chmod 600 "$KUBECONFIG_PATH"

# =========================================================
# EXPORTS (persist because sourced)
# =========================================================
export KUBECONFIG="$KUBECONFIG_PATH"
export OCI_CLI_CONFIG_FILE="$OCI_CONFIG_PATH"
export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

echo
echo "[SUCCESS] OKE cluster configured permanently."
echo
echo "KUBECONFIG=$KUBECONFIG"
echo "OCI_CLI_CONFIG_FILE=$OCI_CLI_CONFIG_FILE"
echo
echo "Try:"
echo "  kubectl get nodes"
