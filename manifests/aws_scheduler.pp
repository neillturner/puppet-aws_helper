# == Class: aws_helper::aws_scheduler
#
# classes to run for the aws_helper::aws_scheduler
# class parameters can be coded here or resolved via the
# hiera parameter hierachy
# this sets up the aws_scheduler cron to stop and start servers according to schedule
#
class aws_helper::aws_scheduler(
  $aws_access_key    = '',
  $aws_secret_key    = '',
  $http_proxy        = '',
  $helper_path       = '/usr/bin',
  $log               = '/var/log/aws_scheduler.log',
  $cron_description  = 'AWS Scheduler',
  $script_path       = '/usr/sbin',
  $cron_minute       = '0',
  $cron_hour         = '19',
  )
{

  file { "${script_path}/aws_scheduler.sh":
    ensure  => 'file',
    owner   => root,
    group   => root,
    mode    => '0700',
    content => template('aws_helper/aws_scheduler.sh.erb')
  }

#  cron::task{ $cron_description:
#    command => "${script_path}/aws_scheduler.sh >> ${log}",
#    minute  => $cron_minute,
#    hour    => $cron_hour,
#    require => File["${script_path}/snap_email.sh"],
#  }

}
