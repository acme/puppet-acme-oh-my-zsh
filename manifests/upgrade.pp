# == Class: ohmyzsh::upgrade
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
define ohmyzsh::upgrade() {
  if $name == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${name}" }
  exec { "ohmyzsh::git upgrade ${name}":
    command => 'git pull --rebase --stat origin master',
    unless => "git fetch origin && test $(git rev-parse @{u}) = $(git rev-parse HEAD)",
    cwd     => "${home}/.oh-my-zsh",
    path    => ['/usr/bin/', '/bin'],
    user    => $name,
    require => [Package['git'], Package['zsh']]
  }
}
