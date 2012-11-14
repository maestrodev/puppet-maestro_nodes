# Maestro repositories
class maestro_nodes::repositories( 
  $host = 'localhost', 
  $port = '8082',
  $user = 'admin',
  $password = 'admin1',
  $default_repo_config = {} ) {

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

  $mirrors = [$repo]
  $servers = [$repo, $maestro_repo]

}
