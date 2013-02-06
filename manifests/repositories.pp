# Maestro repositories
class maestro_nodes::repositories( 
  $host = 'localhost', 
  $port = '8082',
  $user = 'admin',
  $password = 'admin1',
  $default_repo_config = {},
  $maven_mirrors = undef,
  $maven_servers = undef ) {

  $deploy_repo_url = "http://${host}:${port}/archiva/repository/snapshots"
  
  # download from here
  $repo = {
    id       => 'maestro-mirror',
    username => $user,
    password => $password,
    url      => "http://${host}:${port}/archiva/repository/all",
    mirrorof => 'external:*',
  }

  # deploy here
  $maestro_repo = {
    id       => 'maestro-deploy',
    username => $user,
    password => $password,
    url      => $deploy_repo_url,
  }

  $mirrors = $maven_mirrors ? {
    undef   => [$repo],
    default => $maven_mirrors,
  }

  $servers = $maven_servers ? {
    undef   => [$repo, $maestro_repo],
    default => $maven_servers,
  }

}
