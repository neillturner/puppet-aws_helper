# == Class: aws_helper::ebs_backup
#
# classes to run for the aws_helper::ebs_backup
# class parameters can be coded here or resolved via the
# hiera parameter hierachy
# this sets up the ebs_backup cron to backup root ebs disk
# and an attached disk if specified
#
class aws_helper::ebs_backup(
  $aws_access_key    = '',
  $aws_secret_key    = '',
  $http_proxy        = '',
  $helper_path       = '/usr/bin',
  $root_device       = '/dev/sda',
  $root_vol          = '',
  $attached_device   = '/dev/sdf',
  $attached_vol      = '',
  $log               = '/var/log/ebs_backup.log',
  $snapshots_to_keep = '7',
  $description       = '',
  $script_path       = '/usr/sbin',
  $cron_minute       = '0',
  $cron_hour         = '18',
  )
{

  file { "${script_path}/ebs_backup.sh":
    ensure  => 'file',
    owner   => root,
    group   => root,
    mode    => '0700',
    content => template('aws_helper/ebs_backup.sh.erb'),
    require => Package['aws_helper'],
  }

  cron::task{ 'ebs backup':
    command => "${script_path}/ebs_backup.sh >> ${log}",
    minute  => $cron_minute,
    hour    => $cron_hour,
    require => File["${script_path}/ebs_backup.sh"],
  }

}
