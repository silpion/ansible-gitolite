# ansible-gitolite

This role installs gitolite from upstream Git repository.

# ansible-gitolite variables

- gitolite_user_group       [git]
- gitolite_user_name        [git]
- gitolite_user_home        [/srv/git]


# ansible-gitolite example playbook

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
