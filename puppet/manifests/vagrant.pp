import "classes/*.pp"

$PROJ_DIR = "/vagrant"

Exec {
    path => "/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin",
}

class dev {

    class {
        init: before => Class[oracle_java8];
	oracle_java8: before => Class[neo4j::ubuntu];
        neo4j::ubuntu: before => Class[ols];
        ols:;
    }
}

include dev
