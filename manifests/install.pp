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
  if $name == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${name}" }  
  vcsrepo { "${home}/.oh-my-zsh":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/robbyrussell/oh-my-zsh.git',
    user    => $name,
    require => [Package['git'], Package['zsh']]
  }


  exec { "ohmyzsh::cp .zshrc ${name}":
    creates => "${home}/.zshrc",
    command => "/bin/cp ${home}/.oh-my-zsh/templates/zshrc.zsh-template ${home}/.zshrc",
    user    => $name,
    require => Vcsrepo["${home}/.oh-my-zsh"],
  }

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
