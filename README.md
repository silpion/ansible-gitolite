# ansible-gitolite

This role installs gitolite from upstream Git repository.

# TODO

* Basic gitolite-admin repository management (admin.yml)
  * Allow passing repositories including access control.
  * Allow dynamic installation of SSH keys/gitolite users.
  * Generate gitolite configuration based on data.


# Requirements

None.


# Role variables

## gitolite_user_group

Configure the name of the group for the gitolite service user.
* Default: git

## gitolite_user_name

Configure the name of the gitolite service user.
* Default: git

## gitolite_user_home

Configure the home (and service) directory for the gitolite service.
* Default: /srv/git


# Example playbook

    # using the defaults
    ---
    - hosts: gitserver
      roles:
        - gitolite

    # with custom configuration
    ---
    - hosts: gitserver
      roles:
        - { role: gitolite, gitolite_user_home: '/home/git', gitolite_user_name: 'gitolite' }


<!-- vim: set ts=4 sw=4 et nofen: -->
