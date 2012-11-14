class maestro_nodes::sonarserver() {
  class { sonar:
    port => 8083,
    jdbc => $database::sonar_jdbc,
    require => Postgres::Createdb['sonar'],
  }
}
