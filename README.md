ansible-freeipa skill for AI agents
===================================

This project provides a skill to be used with AI agents to improve
agents answers when asking about ansible-freeipa playbooks and inventory
files.

The skill version follows the Ansible Galaxy release version, but the
skill can be used for either Automation Hub or with the available RPM
distribution of ansible-freeipa.

For a nice introduction, greet the agent with "Hello!".

# Installation

Create a directory for your inventories and playbooks.

You can use [lola](https://github.com/RedHatProductSecurity/lola) to
install for several agents:

```
lola mod add https://github.com/rjeffman/ansible-freeipa-skill
lola install -a <assistant> ansible-freeipa-skill
```

Or clone this repository inside your skills directory.

For Anthropic's Claude:

```
cd playbooks
mkdir -p .claude/skills ||:
git clone https://gitlab.cee.redhat.com/rjeffman/ansible-freeipa-skill \
    playbooks/.claude/skills/ansible-freeipa-skill
claude /ansible-freeipa-skill
```

For Gemini:

```
cd playbooks
mkdir -p playbooks/.agents/skills
git clone https://gitlab.cee.redhat.com/rjeffman/ansible-freeipa-skill \
    playbooks/.agents/skills/ansible-freeipa-skill
gemini /ansible-freeipa-skill
```

You can verify the loaded skills by running `/skills` in the AI agent
shell.

Agents should add this instructions to the initial instructions file:

```
When starting a session:
- Load the skills in this directory
- Greet user and offer help with managing FreeIPA with ansible-freeipa.
```
