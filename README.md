# ansible-gitolite

This role installs and configures gitolite from upstream Git repository.

## Synopsis

```yaml
- name: Install gitolite
  hosts: git-server
  vars:
    gitolite_repositories_custom:
      - repo: toast
        admin: ["id_rsa", "{{ gitolite_user_name }}"]
  roles:
    - ansible-gitolite
```

## Requirements

* privilege escalation

## Dependencies

```yaml
- src: https://github.com/silpion/ansible-util
  name: silpion.util
```

## Role variables

### System related configuration

* `gitolite_version`: Gitolite version to clone from gith (string, default: `v3.6.3`)
* `gitolite_clone_url`: Git URL where to clone gitolite sources from (string, default: `git://github.com/sitaramc/gitolite`)
* `gitolite_user_group`: Configure the name of the group for the gitolite service user (string, default: `git`)
* `gitolite_user_name`: Configure the name of the gitolite service user (string, default: `git`)
* `gitolite_user_home`: Configure the home (and service) directory for the gitolite service (string, default: `/srv/git`)
* `gitolite_install_dir`: Configure the installation directory of gitolite (string, default: `/usr/local/gitolite`)
* `gitolite_hostname`: Configure the gitolite server hostname (string, default: `localhost`)
* `gitolite_domainname`: Configure the gitolite server domainname (string, default: `localdomain`)
* `gitolite_mirroring_peers`: Configure ssh aliases for mirroring (list, default: `[]`)
* `gitolite_template_use_cow`: Whether to use a cow in templates rather than `ansible_managed` (boolean, default: `{{ util_template_use_cow|default(true) }}` -> `true`)

### ~/.gitconfig related configuration

* `gitolite_gitconfig_user_name`: Gitolite service user .gitconfig: Configure a user name for git config user.name (string, default: `Git Service`)
* `gitolite_gitconfig_user_email`: Gitolite service user .gitconfig: Configure a user email for git config user.email (string, default: `{{ gitolite_user_name }}@{{ gitolite_hostname }}.{{ gitolite_domainname }}`)
* `gitolite_gitconfig_push_default` Gitolite service user .gitconfig: Configure default for git push (default: `current`) **Should** get updated to *simple* (requires Git 1.9).

### gitolite.rc configuration

* `gitolite_gitoliterc_umask`: Configure gitolite.rc, UMASK option (string, default: `0027`)
* `gitolite_gitoliterc_git_config_keys`: Configure gitolite.rc, GIT_CONFIG_KEYS option (string, default: "")
* `gitolite_gitoliterc_log_extra`: Configure gitolite.rc, LOG_EXTRA option (boolean, default: `true`)
* `gitolite_gitoliterc_display_cpu_time`: Configure gitolite.rc, DISPLAY_CPU_TIME option (boolean, default: `true`)
* `gitolite_gitoliterc_cpu_time_warn_limit`: Configure gitolite.rc, CPU_TIME_WARN_LIMIT option (string, default: `0.2`)
* `gitolite_gitoliterc_site_info`: Configure gitolite.rc, SITE_INFO option (string, default: "")
* `gitolite_gitoliterc_writer_can_update_desc`: Configure gitolite.rc, WRITER_CAN_UPDATE_DESC option (boolean, default: `false`)
* `gitolite_gitoliterc_hostname`: Configure gitolite.rc, HOSTNAME option. This setting is mandatory for the gitolite *mirror* feature (string, default: `{{ gitolite_hostname }}.{{ gitolite_domainname }}`)
* `gitolite_gitoliterc_shell_user_list`: Configure gitolite.rc, SHELL_USER_LIST option (list, default: `[]`)
* `gitolite_gitoliterc_roles`: Configure gitolite.rc, ROLES option (list, default: `["READERS", "WRITERS"]`)
* `gitolite_gitoliterc_enable_features`: Configure gitolite.rc, ENABLE option (list, default: `["help", "desc", "info", "perms", "writable", "ssh-authkeys", "git-config", "daemon", "gitweb"]`)
* `gitolite_gitoliterc_local_code`: Configure gitolite.rc, LOCAL_CODE option (string, default: "")
* `gitolite_gitoliterc_triggers`: Configure gitolite.rc triggers (dict, default: `{}`). Must be a dictionary of lists, with key name as trigger (eg. `{post_compile: ['my-custom-post-compile']}`)

### gitolite.conf configuration

* `gitolite_repositories`: Configure default repositories from gitolite (gitolite-admin/conf/gitolite.conf).

This is a data structure which allows to define repositories with access
controls for

* admin
* write
* read

access, including option strings for Git repository internal structure
or operations, e.g. configure write access to a list of users for the
refs/heads/tags tree only.
A complete example is in defaults/main.yml. The defaults configure
gitolite like a bare/fresh install and it might be advisable to at
least allow admin access to an SSH user in `gitolite_accounts_ssh` array.

* `gitolite_repositories_custom`: Allows to create custom repositories. gitolite will NOT get configured if not BOTH `gitolite_repositories` and `gitolite_repositories_custom` are configured. Data structure is identical to `gitolite_repositories`.
* `gitolite_accounts_ssh`: List of SSH public keys to be added to gitolite-admin/keydir/. SSH keys are read from files/gitolite/users/ssh/*.pub relative to the playbooks top level directory (list, default: `[]`)

# License

Apache Version 2.0

# Author

* Mark Kusch @mark.kusch silpion.de

## Contributors

* [dnmvisser](https://github.com/dnmvisser)


<!-- vim: set ts=4 sw=4 et nofen: -->
