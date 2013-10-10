# == Class: ohmyzsh::install
#
# This is the ohmyzsh module. It installs oh-my-zsh for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# This module is called ohmyzsh as Puppet does not support hyphens in module
# names.
#
# oh-my-zsh is a community-driven framework for managing your zsh configuration.
#
# === Parameters
#
# None.
#
# === Examples
#
# class { 'ohmyzsh': }
# ohmyzsh::install { 'acme': }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
#
define ohmyzsh::install() {
  exec { 'ohmyzsh::git clone':
    creates => "/home/${name}/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git /home/${name}/.oh-my-zsh",
    user    => $name,
    require => [Package['git'], Package['zsh']]
  }

  exec { 'ohmyzsh::cp .zshrc':
    creates => "/home/${name}/.zshrc",
    command => "/bin/cp /home/${name}/.oh-my-zsh/templates/zshrc.zsh-template /home/${name}/.zshrc",
    user    => $name,
    require => Exec['ohmyzsh::git clone'],
  }

  user { "ohmyzsh::user ${name}":
    ensure  => present,
    name    => $name,
    shell   => '/usr/bin/zsh',
    require => Package['zsh'],
  }
}
