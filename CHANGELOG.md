# 2.1.0

Dick Visser (2):

* Bumped version so that SSH pubkey fingerprints work again
* Quote bare variables, this fixes deprecation warnings.

Mark Kusch (17):

* Add yaml block start to requirements
* ansible-generator
* Update metadata for util dependency and min\_ansible\_version
* jinja everything (with single quotes)
* Remove unfinished https support (this should be done with HAproxy/Nginx roles)
* Minor documentation revamp (+ add license to docs)
* Make gitolite version and source repository configurable
* Provide variable types in documentation and add version/url vars
* ISAR-128+github#5: Add support for initial --check mode operations
* Add requirements for role testing with Vagrant
* Remove further leftovers of unfinished/maintained httpd support
* Add gitolite\_clone\_url variable to docs
* Allow to configure templates for cows vs ansible\_managed
* Provide default value for initial check mode
* Remove more httpd-support leftovers
* Add some basic configuration options as local facts
* Add spec tests

# 2.0.0

Anja Siek (2):

* update privilege escalation
* update SELinux management
* add dependency to silpion.util

Mark Kusch (4):

* Add gitolite\_role\_version var
* Silpion Style Guide

# 0.9.0

Anja Siek (1):

* add host-key-check

Calin Don (2):

* docs for gitolite_mirroring_peers
* Support for gitolite.rc LOCAL_CODE and triggers

# 0.8.0

Calin Don (1):

* Support for gitolite mirroring in ssh config

Mark Kusch (3):

* Update variables documentation


<!-- vim: set nofen ts=4 sw=4 et: -->
