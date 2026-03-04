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

Create a directory for your inventories and playbooks and clone this
repository inside that directory.

For Anthropic's Claude:

```
mkdir -p playbooks/.claude/skills
git clone https://gitlab.cee.redhat.com/rjeffman/ansible-freeipa-skill \
    playbooks/.claude/skills/ansible-freeipa-skill
cd playbooks
claude Hello
```

For Gemini:

```
mkdir -p playbooks/.agents/skills
git clone https://gitlab.cee.redhat.com/rjeffman/ansible-freeipa-skill \
    playbooks/.agents/skills/ansible-freeipa-skill
cd playbooks
gemini-cli Hello
```

You can verify the loaded skills by running `/skills` in the AI agent
shell.

For any agent you can either run `/init` or create a simple AGENT.md
file with:

```
# Instructions for AGENT

When starting a session:
- Load the skills in this directory
- Greet user and offer help with managing FreeIPA with ansible-freeipa.
```
