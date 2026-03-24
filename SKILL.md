---
name: ansible-freeipa-skill
description: Create and test Ansible playbooks and inventories that use the ansible-freeipa collection to manage or deploy FreeIPA realms. Use also to create a testing ansible-freeipa environment based on containers.
licensce: GPL-v3.0-or-later
metadata:
  author: "Rafael Guterres Jeffman <rjeffman@redhat.com>"
  version: 1.16.0
  release: 2
allowed-tools: Read
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

To use a dynamic inventory for the Ansible playbooks, follow the instructions on `references/README-inventory-plugin-freeipa.md`.

## Creating an IPA deployment

To create an IPA deployment, one must start with an inital server, then install any number of replicas and clients.

To install the initial server follow the instructions found in `references/README-ipaserver-role.md`
To install a replica follow the instructions found in `references/README-ipareplica-role.md`
To install a client follow the instructions found in `references/README-ipaclient-role.md`

These are **very important** rules to follow, to succed in the deployment:
- **Always** set ipaadmin_password and ipadm_password in the inventory file for the ipaserver deployment.
- **Always** set ipaadmin_password in the inventory file for the ipareplica and ipaclient deployments.
- Ensure that `getent ahosts $HOSTNAME` return a single IPv4 and, at most, one IPv6 address.

## IPA Backup

All information about using ansible-freeipa for backup/restore data is in `references/README-ipabackup-role.md`

## Smartcard setup

To install the smartcard server side, follow the instructions found in `references/README-ipasmartcard_server-role.md`.

To install the smartcard client, follow the instructions found in `references/README-ipasmartcard_client-role.md`

## Managing IPA objects

To manage IPA objects with ansible-freeipa follow the instructions on the file `references/README-${OBJECT}.md`, where `${OBJECT}` is the type of object to be managed.

## Updating documentation

When user wants to update ansible-freeipa documentation:
- Wait for user input for the path to the collection:
    1. Use the default path (`~/.ansible/collections/ansible_collections/freeipa/ansible_freeipa`)
    2. Provide path to ansible-freeipa collection
- Run script '[skill_path]/scripts/update_docs.sh /path/to/collection` with the choosen path.

## Testing the playbooks locally

Although running FreeIPA in a container is not supported, you can test most of the ansible-freeipa modules using a container, running:
```
podman run \
    --rm \
    --security-opt label=disable \
    --network bridge:interface_name=eth0 \
    --systemd true \
    --memory-swap -1 \
    --replace \
    --cap-add DAC_READ_SEARCH \
    --cap-add SYS_PTRACE \
    --cap-add AUDIT_WRITE \
    --cap-add SETUID \
    --cap-add SETGID \
    --hostname ipaserver.test.local \
    --name ipaserver \
    quay.io/ansible-freeipa/upstream-tests:fedora-latest-server
```

The hostname for the container is `ipaserver.test.local`

The administrator credentials is usernam `admin`, password `SomeADMINpassword`.

The Directory Manager password is `SomeDMpassword`.

Use the following Ansible directory in this setup:
```
[ipaserver]
ansible-freeipa-tests ansible_connection=podman

[ipaserver:vars]
ipaadmin_password=SomeADMINpassword
ipadm_password=SomeDMpassword
```

You will need Ansible collection `containers.podman`.

### Verifying data in the container

It is **CRITICAL** that before running any of the `ipa` commands below a Kerberos ticket is obtained, **once per session**, with

```
podman exec ipaserver bash -c "echo 'SomeADMINpassword' | kinit admin
```

**NEVER** execute `kinit` for all the command line `ipa` calls.

ansible-freeipa does not support data retrieval, so to check if an object exist in the container it is required to execute commands directly on the container.

To find a list of objects, use `[object]-find` command, for example:
```
podman exec ipaserver ipa group-find some-group-name
```

To display data for a single object use `[object]-show --all`, for example:
```
podman exec ipaserver ipa service-find http/somehost.somedomain.what@SOMEDOMAIN.WHAT
```

