class foo::defualts {
  case $osfamily {
    'Centos' : {
      $package_name = 'bleh'
      $service_name = 'bleh'
      $config_path  = '/etc/blah/bleh.conf'
      $log_fil      = '/etc/bleh/blah/bleet.log'
      $storgage+
