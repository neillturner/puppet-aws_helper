# puppet-aws_helper

Aws Helper for an instance

Allows functions on EBS volumes, snapshots, IP addresses and more 
* initially snapshots are supported
* cleanup ebs volumes.

## Minimal Usage

Assuming server started with an IAM role that have read access to AWS can create and delete snapshots. 
To backup the root disk on device /dev/sda daily at 2am and keep the last 7 days of snapshots and 
send an email at 3am giving a list of the last 20 snapshots. 

     class { 'aws_helper': }

     class { 'aws_helper::ebs_backup'
       cron_hour        => '2',
     }
     
     class { 'aws_helper::snap_email'
       cron_hour        => '3',
       to               => 'me@company.com',
       from             => 'ebs.backup@company.com',
       email_server     => 'smtpemailserver.com',
     }

Cleanup ebs disks - Delete old server root disks. Disks that are 8GB in size, not attached to a server,
not tagged in any way and from a snapshot will be deleted.

     class { 'aws_helper::ebs_cleanup'
       cron_hour        => '19',
     }

## Complex Usage


Snapshot EBS root disk and attached disk to device /dev/sdf volume vol-654321 access AWS through an http proxy
and send an email at 3am giving a list of the last 30 snapshots. 
If your server does not have a role then you need to code the AWS keys although this is not best practice.

     class { 'aws_helper': }

     class { 'aws_helper::ebs_backup'
       aws_access_key    => 'xxxxxxxxxxxx',
       aws_secret_key    => 'yyyyyyyyyyy',
       http_proxy        => 'http://10.20.30.40:3123',
       helper_path       => '/usr/bin/',
       root_device       => '/dev/sda',
       root_vol          => 'vol-123456',
       attached_device   => '/dev/sdf',
       attached_vol      => 'vol-654321',
       log               => '/var/log/ebs_backup.log',
       snapshots_to_keep => '20',
       description       => 'testserver',
       script_path       => '/usr/sbin',
       cron_minute       => '30',
       cron_hour         => '2',
     )
     
     class { 'aws_helper::snap_email'
       aws_access_key    => 'xxxxxxxxxxxx',
       aws_secret_key    => 'yyyyyyyyyyy',
       owner             => 999888777777,
       http_proxy        => 'http://10.20.30.40:3123',     
       cron_hour        => '3',
       to               => 'me@company.com',
       from             => 'ebs.backup@company.com',
       email_server     => 'smtpemailserver.com',
       subject          => 'My EBS Backups',
       rows             => '30',
     }     
 
Other functions to follow     
