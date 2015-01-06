# == Class: aws_helper
#
# classes to run for the aws_helper 
# class parameters can be coded here or resolved
# via the hiera parameter hierachy
#
class aws_helper(
    $version = 'latest',
)
{

  package { 'aws_helper':
    ensure   => $version,
    provider => 'gem',
  }

}
