# == Define: ohmyzsh::upgrade
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
# === Authors
#
# Leon Brocard <acme@astray.com>
# Zan Loy <zan.loy@gmail.com>
#
# === Copyright
#
# Copyright 2014
#
define ohmyzsh::upgrade {

  include ohmyzsh::params

  if ! defined(Package['git']) {
    package { 'git':
      ensure => present,
    }
  }

  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${name}"
  }

  exec { "ohmyzsh::git upgrade ${name}":
    command => 'git pull --rebase --stat origin master',
    path    => ['/bin', '/usr/bin'],
    cwd     => "${home}/.oh-my-zsh",
    user    => $name,
    require => Package['git'],
  }

}
