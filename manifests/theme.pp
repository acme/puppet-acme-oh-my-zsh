define ohmyzsh::theme(
  $theme     = 'clean',
  $user      = $name,
  $home_path = $ohmyzsh::params::home,
) {
  if $user == 'root' { $home = '/root' } else { $home = "${home_path}/${user}" }
  if $user {
    file_line { "${user}-${theme}-install":
      path    => "${home}/.zshrc",
      line    => "ZSH_THEME=\"${theme}\"",
      match   => '^ZSH_THEME',
      require => Ohmyzsh::Install[$user]
    }
  }
}
