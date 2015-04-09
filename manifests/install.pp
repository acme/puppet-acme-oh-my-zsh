# == Define: ohmyzsh::install
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
# set_sh: (boolean) whether to change the user shell to zsh
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
define ohmyzsh::install(
  $set_sh = false,
) {

  include ohmyzsh::params

  if ! defined(Package['git']) {
    package { 'git':
      ensure => present,
    }
  }

  if ! defined(Package['zsh']) {
    package { 'zsh':
      ensure => present,
    }
  }

  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${name}"
  }

  exec { "ohmyzsh::git clone ${name}":
    creates => "${home}/.oh-my-zsh",
    command => "git clone https://github.com/robbyrussell/oh-my-zsh.git ${home}/.oh-my-zsh || (rmdir ${home}/.oh-my-zsh && exit 1)",
    path    => ['/bin', '/usr/bin'],
    onlyif  => "getent passwd ${name} | cut -d : -f 6 | xargs test -e",
    user    => $name,
    require => Package['git'],
  }

  exec { "ohmyzsh::cp .zshrc ${name}":
    creates => "${home}/.zshrc",
    command => "cp ${home}/.oh-my-zsh/templates/zshrc.zsh-template ${home}/.zshrc",
    path    => ['/bin', '/usr/bin'],
    onlyif  => "getent passwd ${name} | cut -d : -f 6 | xargs test -e",
    user    => $name,
    require => Exec["ohmyzsh::git clone ${name}"],
  }

  if $set_sh {
    if ! defined(User[$name]) {
      user { "ohmyzsh::user ${name}":
        ensure     => present,
        name       => $name,
        managehome => true,
        shell      => $ohmyzsh::params::zsh,
        require    => Package['zsh'],
      }
    } else {
      User <| title == $name |> {
        shell => $ohmyzsh::params::zsh
      }
    }
  }
}
