# == Define: ohmyzsh::plugins
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
# plugins: (string) space separated list of tmux plugins
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
define ohmyzsh::plugins(
  $plugins = 'git',
) {

  include ohmyzsh::params

  if $name == 'root' {
    $home = '/root'
  } else {
    $home = "${ohmyzsh::params::home}/${name}"
  }

  if is_array($plugins) {
    $plugins_real = join($plugins, ' ')
  } else {
    validate_string($plugins)
    $plugins_real = $plugins
  }

  file_line { "${name}-${plugins_real}-install":
    path    => "${home}/.zshrc",
    line    => "plugins=(${plugins_real})",
    match   => '^plugins=',
    require => Ohmyzsh::Install[$name]
  }

}
