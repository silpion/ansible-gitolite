# ansible-gitolite

This role installs and configures gitolite from upstream Git repository.


## Requirements

None.


## Dependencies

None.


## Role variables

### System related configuration

* ``gitolite_user_group``: Configure the name of the group for the gitolite service user (default: ``git``)
* ``gitolite_user_name``: Configure the name of the gitolite service user (default: ``git``)
* ``gitolite_user_home``: Configure the home (and service) directory for the gitolite service (default: ``/srv/git``)
* ``gitolite_install_dir``: Configure the installation directory of gitolite (default: ``/usr/local/gitolite``)
* ``gitolite_hostname``: Configure the gitolite server hostname (default: ``localhost``)
* ``gitolite_domainname``: Configure the gitolite server domainname (default: ``localdomain``)
* ``gitolite_mirroring_peers``: Configure ssh aliases for mirroring (default: ``[]``)

### ~/.gitconfig related configuration

* ``gitolite_gitconfig_user_name``: Gitolite service user .gitconfig: Configure a user name for git config user.name (default: ``Git Service``)
* ``gitolite_gitconfig_user_email``: Gitolite service user .gitconfig: Configure a user email for git config user.email (default: ``{{ gitolite_user_name }}@{{ gitolite_hostname }}.{{ gitolite_domainname }}``)
* ``gitolite_gitconfig_push_default`` Gitolite service user .gitconfig: Configure default for git push (default: ``current``) **Should** get updated to *simple* (requires Git 1.9).

### gitolite.rc configuration

* ``gitolite_gitoliterc_umask``: Configure gitolite.rc, UMASK option (default: ``0027``)
* ``gitolite_gitoliterc_git_config_keys``: Configure gitolite.rc, GIT_CONFIG_KEYS option (default: "")
* ``gitolite_gitoliterc_log_extra``: Configure gitolite.rc, LOG_EXTRA option (default: ``true``)
* ``gitolite_gitoliterc_display_cpu_time``: Configure gitolite.rc, DISPLAY_CPU_TIME option (default: ``true``)
* ``gitolite_gitoliterc_cpu_time_warn_limit``: Configure gitolite.rc, CPU_TIME_WARN_LIMIT option (default: ``0.2``)
* ``gitolite_gitoliterc_site_info``: Configure gitolite.rc, SITE_INFO option (default: "")
* ``gitolite_gitoliterc_writer_can_update_desc``: Configure gitolite.rc, WRITER_CAN_UPDATE_DESC option (default: ``false``)
* ``gitolite_gitoliterc_hostname``: Configure gitolite.rc, HOSTNAME option. This setting is mandatory for the gitolite *mirror* feature (default: ``{{ gitolite_hostname }}.{{ gitolite_domainname }}``)
* ``gitolite_gitoliterc_shell_user_list``: Configure gitolite.rc, SHELL_USER_LIST option (default: ``[]``)
* ``gitolite_gitoliterc_roles``: Configure gitolite.rc, ROLES option (default: ``["READERS", "WRITERS"]``)
* ``gitolite_gitoliterc_enable_features``: Configure gitolite.rc, ENABLE option (default: ``["help", "desc", "info", "perms", "writable", "ssh-authkeys", "git-config", "daemon", "gitweb"]``)
* ``gitolite_gitoliterc_local_code``: Configure gitolite.rc, LOCAL_CODE option (default: "")
* ``gitolite_gitoliterc_triggers``: Configure gitolite.rc triggers (default: {}). Must be a dictionary of lists, with key name as trigger (eg. ``{post_compile: ['my-custom-post-compile']}``)

### gitolite.conf configuration

* ``gitolite_repositories``: Configure default repositories from gitolite (gitolite-admin/conf/gitolite.conf).

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
least allow admin access to an SSH user in ``gitolite_accounts_ssh`` array.

* ``gitolite_repositories_custom``: Allows to create custom repositories. gitolite will NOT get configured if not BOTH ``gitolite_repositories`` and ``gitolite_repositories_custom`` are configured. Data structure is identical to ``gitolite_repositories``.
* ``gitolite_accounts_ssh``: List of SSH public keys to be added to gitolite-admin/keydir/. SSH keys are read from files/gitolite/users/ssh/*.pub relative to the playbooks top level directory (default: ``[]``)

### https related configuration

https support is very basic and not feature complete. It's not possible
to configure usable authentication providers with Apache right now, so
it's completely commented out. The following variables are **not implemented yet**.

* ``gitolite_https_enable``: Enable configuraton of smart https with Apache (default: ``false``)
* ``gitolite_https_auth_type``: Configures Auth Type for Apache httpd (default: ``basic``)
* ``gitolite_httpd_document_root``: Configures the Apache httpd DocumentRoot directive (default: ``/var/empty/www``)
* ``gitolite_httpd_https_port``: Configure the HTTPS port used from Apache httpd (default: ``443``)
* ``gitolite_httpd_sitename``: Configure the ServerName directive for Apache httpd (default: ``{{ gitolite_hostname }}.{{ gitolite_domainname }}``)
* ``gitolite_ssl_certificate``: Configure a sites SSL certificate for Apache httpd. A certificate will get created if generated string (default: "")
* ``gitolite_ssl_certificate_key``: Configure a sites SSL certificates private key for Apache httpd. A certificate and key will get generated if empty string (default: "")
* ``gitolite_ssl_certificate_subject``: If a SSL certificate gets generated this is the string for the OpenSSL '-subj' switch (default: ``/C=DE/ST=Hamburg/L=Hamburg/O=IT/CN={{ gitolite_httpd_sitename }}``)


## Example playbook

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
