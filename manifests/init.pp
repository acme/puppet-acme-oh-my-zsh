# == Class: oh-my-zsh
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
class oh-my-zsh {
  if(!defined(Package['git'])) {
    package { 'git':
      ensure => present,
    }
  }

  if(!defined(Package['zsh'])) {
    package { 'zsh':
      ensure => present,
    }
  }

}
