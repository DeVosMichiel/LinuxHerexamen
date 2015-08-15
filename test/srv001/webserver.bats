# srv001 test file

@test "Check installation Apache" {
    run yum install httpd php php-xml php-mysql
    run dpkg -s httpd
    run dpkg -s php
    run dpkg -s php-xml
    run dpkg -s php-mysql
}

@test "Check Apache service active" {
    run systemctl status httpd
    [[ ${lines[2]} =~ "active" ]]
}

@test "Check installation mariaDB" {
    run yum install mariadb mariadb-server MySQL-python
    run dpkg -s mariadb
    run dpkg -s mariadb-server
    run dpkg -s MySQL-python
}

@test "Check mariadb service active" {
    run systemctl status mariadb
    [[ ${lines[2]} =~ "active" ]]
}

@test "Check installation PHP" {
    run php --version
}

@test "Check installation Wordpress" {
    run yum install wordpress
}

@test "Check existance necessary files for SSL" {
    run stat /etc/pki/tls/certs/ca.crt
    run stat /etc/pki/tls/private/ca.key
    run stat /etc/pki/tls/private/ca.csr
}

@test "Check if port 443 firewall and service http are allowed" {
    run sudo firewall-cmd --list-all
    [[ ${lines[0]} =~ "active" ]]
    [[ ${lines[3]} =~ "http" ]]
    [[ ${lines[4]} =~ "443/tcp" ]]
}