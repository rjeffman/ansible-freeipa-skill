#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(realpath $(dirname "$0"))"
ASSETS_DIR="$(realpath "${SCRIPT_DIR}/../assets")"

RED="\033[31;1m"
NC="\033[0m"

die() {
    echo -e "${RED}ERROR: $*${NC}" >&2
    exit 1
}

[[ -z "$1" ]] && die "Missing ansible-freeipa collection directory."
COLLECTION_DIR="$(realpath "$1")"

MAGIC="$(sed -e "s/FreeIPA Ansible collection//" <(head -1 "${COLLECTION_DIR}/README.md"))"
[[ -z "$MAGIC" ]] || die "Directory '${COLLECTION_DIR}' does not contain ansible-freeipa collection"

TMPDIR="$(mktemp -d)"
cp -v "${COLLECTION_DIR}"/README*.md "${TMPDIR}"
readarray -t ROLES_README < <(find "${COLLECTION_DIR}/roles" -name "README.md")
declare -a ROLES_README

for role_md in "${ROLES_README[@]}"
do
    cp -v "${role_md}" "${TMPDIR}/$(sed -e "s#.*roles/\([^/]*\)/.*#README-\1-role#" <<<"${role_md}")"
done

rm -rv "${ASSETS_DIR}"
mv -v "${TMPDIR}" "${ASSETS_DIR}"
