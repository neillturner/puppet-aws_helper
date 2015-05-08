# == Class: aws_helper::ebs_cleanup
#
# classes to run for the aws_helper::ebs_cleanup
# class parameters can be coded here or resolved via the
# hiera parameter hierachy
# this sets up the ebs_cleanup cron to backup root ebs disk
# and an attached disk if specified
#
class aws_helper::ebs_cleanup(
  $aws_access_key    = '',
  $aws_secret_key    = '',
  $http_proxy        = '',
  $helper_path       = '/usr/bin',
  $log               = '/var/log/ebs_cleanup.log',
  $script_path       = '/usr/sbin',
  $cron_minute       = '0',
  $cron_hour         = '19',
  )
{

  file { "${script_path}/ebs_cleanup.sh":
    ensure  => 'file',
    owner   => root,
    group   => root,
    mode    => '0700',
    content => template('aws_helper/ebs_cleanup.sh.erb')
  }

  cron::task{ 'ebs cleanup':
    command => "${script_path}/ebs_cleanup.sh >> ${log}",
    minute  => $cron_minute,
    hour    => $cron_hour,
    require => File["${script_path}/ebs_cleanup.sh"],
  }

}
