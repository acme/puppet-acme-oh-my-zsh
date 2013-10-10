# == Class: oh-my-zsh::install
#
# This is the oh-my-zsh module. It installs oh-my-zsh for a user and changes
# their shell to zsh. It has been tested under Ubuntu.
#
# oh-my-zsh is a community-driven framework for managing your zsh configuration.
#
# === Parameters
#
# None.
#
# === Examples
#
# class { 'oh-my-zsh': }
# oh-my-zsh::install { 'acme': }
#
# === Authors
#
# Leon Brocard <acme@astray.com>
#
# === Copyright
#
# Copyright 2013 Leon Brocard
#
define oh-my-zsh::install() {
  exec { 'oh-my-zsh::git clone':
    creates => "/home/${name}/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git /home/${name}/.oh-my-zsh",
    user    => $name,
    require => [Package['git'], Package['zsh']]
  }

  exec { 'oh-my-zsh::cp .zshrc':
    creates => "/home/${name}/.zshrc",
    command => "/bin/cp /home/${name}/.oh-my-zsh/templates/zshrc.zsh-template /home/${name}/.zshrc",
    user    => $name,
    require => Exec['oh-my-zsh::git clone'],
  }

  user { "oh-my-zsh::user ${name}":
    ensure  => present,
    name    => $name,
    shell   => '/usr/bin/zsh',
    require => Package['zsh'],
  }
}
