define ohmyzsh::path(
  $path = '/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  $user = $name
) {
  if $user == 'root' { $home = '/root' } else { $home = "${ohmyzsh::params::home}/${user}" }
  if $user {
    file_line { "${user}-${path}-install":
      path    => "${home}/.zshrc",
      line    => "export PATH=\"${path}\"",
      match   => '^export PATH',
      require => Ohmyzsh::Install[$user]
    }
  }
}
