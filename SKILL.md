---
name: ansible-freeipa-skill
description: Used to optimize the creation of Ansible playbooks that use the ansible-freeipa collection to manage FreeIPA deployments.
licensce: GPL-v3.0-or-later
metadata:
  author: "Rafael Guterres Jeffman <rjeffman@redhat.com>"
  version: 1.16.0
---

## Installing ansible-freeipa collection

To install ansible-freeipa collection, use Ansible Galaxy:
```
ansible-galaxy collection install freeipa.ansible_freeipa
```

If running against a testing lab built on Podman containers, install the Podman collection:
```
ansible-galaxy collection intsall containers.podman
```

## Using a dynamic inventory

To use a dynamic inventory for the Ansible playbooks, follow the instructions on `assets/README-inventory-plugin-freeipa.md`.

## Creating an IPA deployment

To create an IPA deployment, one must start with an inital server, then install any number of replicas and clients.

To install the initial server follow the instructions found in `assets/README-ipaserver-deployment.md`
To install a replica follow the instructions found in `assets/README-ipareplica-deployment.md`
To install a client follow the instructions found in `assets/README-ipaclient-deployment.md`

These are **very important** rules to follow, to succed in the deployment:
- **Always** set ipaadmin_password and ipadm_password in the inventory file for the ipaserver deployment.
- **Always** set ipaadmin_password in the inventory file for the ipareplica and ipaclient deployments.
- Ensure that `getent ahosts $HOSTNAME` return a single IPv4 and, at most, one IPv6 address.

## Managing IPA objects

To manage IPA objects iwth ansbile-freeipa follow the instructions on the file `assets/README-${OBJECT}.md`, where `${OBJECT}` is the type of object to be managed.

## Updating documentation

When user wants to update ansible-freeipa documentation:
- Wait for user input for the path to the collection:
    1. Use the default path (`~/.ansible/collections/ansible_collections/freeipa/ansible_freeipa`)
    2. Provide path to ansible-freeipa collection
- Run script '[skill_path]/scripts/update_docs.sh /path/to/collection` with the choosen path.

