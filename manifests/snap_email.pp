# == Class: aws_helper::snap_email
#
# classes to run for the aws_helper::snap_email
# class parameters can be coded here or resolved via the
# hiera parameter hierachy
# this sets up the snap_email cron to report on the Snapshots
#
class aws_helper::snap_email(
  $aws_access_key    = '',
  $aws_secret_key    = '',
  $http_proxy        = '',
  $helper_path       = '/usr/bin',
  $to                = '',
  $from              = '',
  $email_server      = '',
  $subject           = 'EBS Backups',
  $rows              = '20',
  $log               = '/var/log/snap_email.log',
  $cron_description  = 'Snap Email',
  $script_path       = '/usr/sbin',
  $cron_minute       = '0',
  $cron_hour         = '19',
  )
{

  file { "${script_path}/snap_email.sh":
    ensure  => 'file',
    owner   => root,
    group   => root,
    mode    => '0700',
    content => template('aws_helper/snap_email.sh.erb'),
    require => Package['aws_helper'],
  }

  cron::task{ $cron_description:
    command => "${script_path}/snap_email.sh >> ${log}",
    minute  => $cron_minute,
    hour    => $cron_hour,
    require => File["${script_path}/snap_email.sh"],
  }

}
