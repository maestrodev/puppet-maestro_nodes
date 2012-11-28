class maestro_nodes::androidsdk($user, $group, $home){
  
  #Android SDK
  class { 'android':
    user => $user,
    group => $group,
  }

  android::platform{ [ 'android-16', 'android-15' ]: }
  
  $sdk_home = $android::paths::sdk_home
  
  file { "${home}/androidsdk.properties":
    ensure  => present,
    content => template('maestro_nodes/androidsdk.properties.erb'),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}