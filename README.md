# ansible-gitolite

This role installs and configures gitolite from upstream Git repository.


# Requirements

None.


# Role variables

## System related configuration

### gitolite_user_group

Configure the name of the group for the gitolite service user.
* Default: git

### gitolite_user_name

Configure the name of the gitolite service user.
* Default: git

### gitolite_user_home

Configure the home (and service) directory for the gitolite service.
* Default: /srv/git

### gitolite_install_dir

Configure the installation directory of gitolite.
* Default: /usr/local/gitolite

### gitolite_hostname

Configure the gitolite server hostname.
* Default: localhost

### gitolite_domainname

Configure the gitolite server domainname.
* Default: localdomain

## ~/.gitconfig related configuration

### gitolite_gitconfig_user_name

Gitolite service user .gitconfig: Configure a user name for git config user.name.
* Default: Git Service

### gitolite_gitconfig_user_email

Gitolite service user .gitconfig: Configure a user email for git config user.email.
* Default: {{ gitolite\_user\_name }}@{{ gitolite\_hostname }}.{{ gitolite\_domainname }}

### gitolite_gitconfig_push_default

Gitolite service user .gitconfig: Configure default for git push.
* Default: current

This should get updated to *simple* which requires git 1.9 to be installed.

## gitolite.rc configuration

### gitolite_gitoliterc_umask

Configure gitolite.rc, UMASK option.
* Default: '0027'

### gitolite_gitoliterc_git_config_keys

Configure gitolite.rc, GIT_CONFIG_KEYS option.
* Default: ""

### gitolite_gitoliterc_log_extra

Configure gitolite.rc, LOG_EXTRA option.
* Default: true

### gitolite_gitoliterc_display_cpu_time

Configure gitolite.rc, DISPLAY_CPU_TIME option.
* Default: true

### gitolite_gitoliterc_cpu_time_warn_limit

Configure gitolite.rc, CPU_TIME_WARN_LIMIT option.
* Default: '0.2'

### gitolite_gitoliterc_site_info

Configure gitolite.rc, SITE_INFO option.
* Default: ""

### gitolite_gitoliterc_writer_can_update_desc

Configure gitolite.rc, WRITER_CAN_UPDATE_DESC option.
* Default: false

### gitolite_gitoliterc_hostname

Configure gitolite.rc, HOSTNAME option. This setting is mandatory for the gitolite
*mirror* feature.
* Default: {{ gitolite\_hostname }}.{{ gitolite\_domainname }}

### gitolite_gitoliterc_shell_user_list

Configure gitolite.rc, SHELL_USER_LIST option.
* Default: []

### gitolite_gitoliterc_roles

Configure gitolite.rc, ROLES option.
* Default: ["READERS", "WRITERS"]

### gitolite_gitoliterc_enable_features

Configure gitolite.rc, ENABLE option.
* Default: ["help", "desc", "info", "perms", "writable", "ssh-authkeys", "git-config", "daemon", "gitweb"]

## gitolite.conf configuration

### gitolite_repositories

Configure default repositories from gitolite (gitolite-admin/conf/gitolite.conf).
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
least allow admin access to an SSH user in *gitolite_accounts_ssh* array.

### gitolite_repositories_custom

Allows to create custom repositories. gitolite will NOT get configured
if not BOTH
* gitolite_repositories
* gitolite_repositories_custom
are configured. Data structure is identical to *gitolite_repositories*.

### gitolite_accounts_ssh

List of SSH public keys to be added to gitolite-admin/keydir/. SSH keys
are read from
* files/gitolite/users/ssh/*.pub
relative to the playbooks top level directory.
* Default: []

## https related configuration

https support is very basic and not feature complete. It's not possible
to configure usable authentication providers with Apache right now, so
it's completely commented out.

### gitolite_https_enable

* **Not implemented yet.**

Enable configuration of https through Apache.
* Default: false

### gitolite_https_auth_type

* **Not implemented yet**.

Configures the Auth Type for Apache httpd
configuration.
* Default: basic

### gitolite_httpd_document_root

* **Not implemented yet**.

Configures the Apache httpd DocumentRoot directive.
* Default: /var/empty/www

### gitolite_httpd_https_port

* **Not implemented yet**.

Configure the HTTPS port used from Apache httpd.
* Default: 443

### gitolite_httpd_sitename

* **Not implemented yet**.

Configure the ServerName directive for Apache httpd.
* Default: {{ gitolite\_hostname }}.{{ gitolite\_domainname }}

### gitolite_ssl_certificate

* **Not implemented yet**.

Configure a sites SSL certificate for Apache httpd. A certificate will
get created if generated string.
* Default: ""

### gitolite_ssl_certificate_key

* **Not implemented yet**.

Configure a sites SSL certificates private key for Apache httpd. A
certificate and key will get generated if empty string.
* Default: ""

### gitolite_ssl_certificate_subject

* **Not implemented yet**.

If a SSL certificate gets generated this is the string for the
OpenSSL '-subj' switch.
* Default: "/C=DE/ST=Hamburg/L=Hamburg/O=IT/CN={{ gitolite_httpd_sitename }}"


# Example playbook

    # using the defaults
    ---
    - hosts: gitserver
      roles:
        - { role: gitolite }

    # with custom configuration
    #   it is advised to configure variables in the inventory rather
    #   than in the playbook!
    ---
    - hosts: gitserver
      roles:
        - { role: gitolite, gitolite_user_home: '/home/git', gitolite_user_name: 'gitolite' }


<!-- vim: set ts=4 sw=4 et nofen: -->
