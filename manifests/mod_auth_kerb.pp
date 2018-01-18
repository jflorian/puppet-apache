# == Class: apache::mod_auth_kerb
#
# Manages the Apache web server to provide authorization via Kerberos.
#
# Warning:
#   This uses the deprecated mod_auth_kerb module for Apache.  If possible,
#   you shoud use apache::mod_auth_gssapi instead.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*keytab_source*]
#   URI of the Kerberos keytab file content.
#
# [*packages*]
#   An array of package names needed for the Apache web server with Kerberos
#   installation.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2016-2018 John Florian


class apache::mod_auth_kerb (
        String[1]               $keytab_source,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
        notify => Class['::apache::service'],
    }

    ::apache::misc_file { 'conf/http.keytab':
        source => $keytab_source,
    }

}
