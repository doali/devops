#!/bin/bash

# ajouter un switch case : init/prepare, start, stop, clean
# selection possible de l'architecture : arm, amd
# selection de profiles : test, ...
# mise à disposition de : 
# docker
# apt
# supprimer mot de passe en dur dans user#data (ajouter le hash)
# supprimer le root:root

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

BASE_AMD64_QCOW2_FILENAME=debian-10.2.0-openstack-amd64.qcow2
#BASE_AMD64_QCOW2_FILENAME=debian-9.8.2-20190303-openstack-amd64.qcow2
BASE_AARCH64_QCOW2_FILENAME=debian-10.2.0-openstack-arm64.qcow2

DATE_SEC=$(date +%s)
DOM_NAME=pel-${DATE_SEC}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#echo $CURRENT_DIR
#echo ${0%/*}
USER_DATA=${CURRENT_DIR}/cloud-init/user-data
META_DATA=${CURRENT_DIR}/cloud-init/meta-data

TMP=~/tmp

_gen_cloud_init_iso()
{
    # Creation de l'iso
    genisoimage -o ${OUTPUT_ISO} -V cidata -r -J ${USER_DATA} ${META_DATA}
}

_gen_new_qcow2()
{
    pushd ${OUTPUT_QCOW2_DIR}
    # Creation d'un layer
    qemu-img create -b ${BASE_QCOW2} -f qcow2 ${OUTPUT_QCOW2_FILENAME}
    popd
}

_create_dom()
{
    virt-install \
        --noreboot \
        --import \
        --name ${DOM_NAME} \
        --ram 2048 \
        --vcpus 1 \
        --disk ${OUTPUT_QCOW2_DIR}/${OUTPUT_QCOW2_FILENAME},format=qcow2,bus=virtio \
        --disk ${OUTPUT_ISO},device=cdrom \
        --network bridge=virbr0,model=virtio \
        --os-type=generic \
        --os-variant=generic \
        --noautoconsole
		#--arch aarch64
}

#######################################################
OUTPUT_ISO=${TMP}/cloud-init-${DATE_SEC}.iso
OUTPUT_QCOW2_DIR=${TMP}
OUTPUT_QCOW2_FILENAME=${DOM_NAME}.qcow2
BASE_QCOW2=${TMP}/${BASE_AMD64_QCOW2_FILENAME}

main()
{
	_gen_cloud_init_iso
	_gen_new_qcow2
	_create_dom
}

# Lancement
main

#trap 'echo Error at about $LINEO' ERR

