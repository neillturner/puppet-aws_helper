# puppet-aws_helper

Aws Helper for an instance

Allows functions on EBS volumes, snapshots, IP addresses and more 
* initially snapshots are supported

## Minimal Usage

Assuming server started with an IAM role that have read access to AWS can create and delete snapshots. 
to backup the root disk on device /dev/sda daily at 2am and keep the last 7 days of snapshots. 

     class { 'aws_helper': }

     class { 'aws_helper::ebs_backup'
        cron_hour        => '2',
     } 

## Complex Usage


Snapshot EBS root disk and attached disk to device /dev/sdf volume vol-654321 access AWS through an http proxy.
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
 
Other functions to follow     