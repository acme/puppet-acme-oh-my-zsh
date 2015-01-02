# puppet-ohmyzsh
[![Build Status](https://travis-ci.org/zanloy/puppet-ohmyzsh.svg?branch=master)](https://travis-ci.org/zanloy/puppet-ohmyzsh)

This is a [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) module. It
installs oh-my-zsh for a user and can change their shell to zsh. It can install
and configure themes and plugins for users.

oh-my-zsh is a community-driven framework for managing your zsh configuration.
See [https://github.com/robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
for more details.

## Usage

```
# for a single user
ohmyzsh::install { 'user1': }

# for multiple users in one shot but set their shell to zsh
ohmyzsh::install { ['root', 'user1']: set_sh => true }

# install a theme for a user
ohmyzsh::fetch::theme { 'root': url => 'http://zanloy.com/files/dotfiles/oh-my-zsh/squared.zsh-theme' }

# set a theme for a user
ohmyzsh::theme { ['root', 'user1']: } # would install 'clean' theme as default

ohmyzsh::theme { ['root', 'user1']: theme => 'robbyrussell' } # specific theme

# activate plugins for a user
ohmyzsh::plugins { 'user1': plugins => 'git github' }

# upgrade oh-my-zsh for a single user
ohmyzsh::upgrade { 'user1': }
```

Support
-------

Please log tickets and issues on [GitHub](https://github.com/zanloy/puppet-ohmyzsh)


Acknowlegments
--------------

This module was originally a fork of [acme/ohmyzsh](https://github.com/acme/puppet-acme-oh-my-zsh) at version 0.1.3
