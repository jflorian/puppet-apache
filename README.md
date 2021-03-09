<!--
This file is part of the doubledog-apache Puppet module.
Copyright 2018-2019 John Florian <jflorian@doubledog.org>
SPDX-License-Identifier: GPL-3.0-or-later
-->

# apache

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with apache](#setup)
    * [What apache affects](#what-apache-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with apache](#beginning-with-apache)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
    * [Data types](#data-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage the Apache httpd web server.

## Setup

### What apache Affects

### Setup Requirements

### Beginning with apache

## Usage

## Reference

**Classes:**

* [apache](#apache-class)
* [apache::mod\_auth\_gssapi](#apachemod_auth_gssapi-class)
* [apache::mod\_info](#apachemod_info-class)
* [apache::mod\_ldap](#apachemod_ldap-class)
* [apache::mod\_passenger](#apachemod_passenger-class)
* [apache::mod\_ssl](#apachemod_ssl-class)
* [apache::mod\_status](#apachemod_status-class)
* [apache::mod\_wsgi](#apachemod_wsgi-class)
* [apache::package](#apachepackage-class)
* [apache::service](#apacheservice-class)

**Defined types:**

* [apache::misc\_file](#apachemisc_file-defined-type)
* [apache::module\_config](#apachemodule_config-defined-type)
* [apache::site\_config](#apachesite_config-defined-type)

**Data types:**

* [Apache::Log\_level](#apachelog_level-data-type)


### Classes

#### apache class

This class manages the primary configuration, SELinux settings and firewall.  This also implies management of the [minimal packaging](#apachepackage-class) and the [service](#apacheservice-class).

##### `anon_write`
Should SELinux allow httpd to modify public files used for public file transfer services?  Either `true` or `false` (default).

##### `execmem`
Should SELinux allow httpd scripts and modules execmem/execstack?  Either `true` or `false` (default).

##### `log_level`
Limits the level of messages logged to the `error_log` file.  Valid values are regulated by the [Apache::Log\_level](#apachelog_level-data-type).  The default is `'warn'`.

##### `manage_firewall`
If `true`, open the HTTP port on the firewall.  Otherwise the firewall is left unaffected.  Defaults to `true`.

##### `network_connect`
Should SELinux allow httpd scripts and modules to connect to the network using TCP?  Either `true` or `false` (default).

##### `network_connect_db`
Should SELinux allow httpd scripts and modules to connect to databases over the network?  Either `true` or `false` (default).

##### `send_mail`
Should SELinux allow httpd to send mail?  Either `true` or `false` (default).

##### `use_nfs`
Should SELinux allow serving content reached via NFS?  Either `true` or `false` (default).


#### apache::mod\_auth\_gssapi class

This class manages the Apache web server to provide authorization via Kerberos using
only GSSAPI calls.

##### `keytab_content`
Literal content for the Kerberos keytab file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `keytab_source`
URI of the Kerberos keytab file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `packages`
An array of package names needed for httpd authorization via Kerberos using only GSSAPI calls.  The default should be correct for supported platforms.


#### apache::mod\_info class

This class manages the [Apache info module](https://httpd.apache.org/docs/2.4/mod/mod_info.html) which provides a comprehensive overview of the server configuration.  Access will only be allowed for any successful match of `allow_from_host` or `allow_from_ip` -- the client need not match both.

##### `location`
This parameter controls the location used to access the server info page.  Defaults to `'/server-info'`.

##### `allow_from_host`
An array of hostnames which to be allowed access to the server info page.  Defaults to `[]`.

##### `allow_from_ip`
An array of IPs or IP ranges in CIDR format to be allowed access to the server info page.  Defaults to `['127.0.0.1', '::1']`.


#### apache::mod\_ldap class

This class configures the Apache web server to support user authentication via LDAP.  See https://httpd.apache.org/docs/2.4/mod/mod_ldap.html
for more details.

##### `packages`
An array of package names which provide support for LDAP authentication.  The default value is `mod_ldap` which is available on RedHat based platforms.


#### apache::mod\_passenger class

This class manages the Apache web server to provide Phusion Passenger support.

##### `packages`
An array of package names needed for httpd Phusion Passenger support.  The default should be correct for supported platforms.


#### apache::mod\_ssl class

This class manages the Apache web server to provide HTTPS support.

##### `manage_firewall`
If `true`, open the HTTPS port on the firewall.  Otherwise the firewall is left unaffected.  Defaults to `true`.


#### apache::mod\_status class

This class manages the [Apache status module](https://httpd.apache.org/docs/2.4/mod/mod_status.html) which provides information on server activity and performance.  Access will only be allowed for any successful match of `allow_from_host` or `allow_from_ip` -- the client need not match both.

##### `location`
This parameter controls the location used to access the server status page.  Defaults to `'/server-status'`.

##### `allow_from_host`
An array of hostnames which to be allowed access to the server status page.  Defaults to `[]`.

##### `allow_from_ip`
An array of IPs or IP ranges in CIDR format to be allowed access to the server status page.  Defaults to `['127.0.0.1', '::1']`.


#### apache::mod\_wsgi class

This class manages the Apache web server to provide Web Server Gateway Interface support.

##### `packages`
An array of package names needed for WSGI support.  The default should be correct for supported platforms.


#### apache::package class

This class manages packages needed for a minimal installation.

##### `names`
An array of package names needed for a minimal installation.  The default should be correct for supported platforms.


#### apache::service class

This class manages the service itself.

##### `daemon`
The service name of the httpd daemon.  The default should be correct for supported platforms.

##### `enable`
Instance is to be started at boot.  Either `true` (default) or `false`.

##### `ensure`
Instance is to be `'running'` (default) or `'stopped'`.  Alternatively, a Boolean value may also be used with `true` equivalent to `'running'` and `false` equivalent to `'stopped'`.


### Defined types

#### apache::misc\_file defined type

This defined type manages a miscellaneous file for the web server.  These will land in `/etc/httpd/${filename}`.

##### `namevar` (required)
An arbitrary identifier for the file instance unless the *filename* parameter is not set in which case this must provide the value normally set with the *filename* parameter.

##### `content`
Literal content for the file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `ensure`
Instance is to be `'present'` (default) or `'absent'`.  Alternatively, a Boolean value may also be used with `true` equivalent to `'present'` and `false` equivalent to `'absent'`.

##### `filename`
Name to be given to the file, without any path details.  This may be used in place of *namevar* if it's beneficial to give *namevar* an arbitrary value.

##### `group`
File group account.  Defaults to `'apache'` which is appropriate for most files.

##### `mode`
File access mode.  Defaults to `'0640'` which is appropriate for most files.

##### `owner`
File owner account.  Defaults to `'root'` which is appropriate for most files.

##### `source`
URI of the file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.


#### apache::module\_config defined type

This defined type manages a module configuration file for the web server.  These will land in `/etc/httpd/conf.modules.d/${filename}.conf`.

##### `namevar` (required)
An arbitrary identifier for the file instance unless the *filename* parameter is not set in which case this must provide the value normally set with the *filename* parameter.

##### `content`
Literal content for the file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `ensure`
Instance is to be `'present'` (default) or `'absent'`.  Alternatively, a Boolean value may also be used with `true` equivalent to `'present'` and `false` equivalent to `'absent'`.

##### `filename`
Name to be given to the file, without any path details nor a `.conf` suffix.  This may be used in place of *namevar* if it's beneficial to give *namevar* an arbitrary value.

##### `group`
File group account.  Defaults to `'apache'` which is appropriate for most files.

##### `mode`
File access mode.  Defaults to `'0640'` which is appropriate for most files.

##### `owner`
File owner account.  Defaults to `'root'` which is appropriate for most files.

##### `source`
URI of the file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.


#### apache::site\_config defined type

This defined type manages a site-specific configuration file for the web server.  These will land in `/etc/httpd/conf.d/${filename}.conf`.

##### `namevar` (required)
An arbitrary identifier for the file instance unless the *filename* parameter is not set in which case this must provide the value normally set with the *filename* parameter.

##### `content`
Literal content for the file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `ensure`
Instance is to be `'present'` (default) or `'absent'`.  Alternatively, a Boolean value may also be used with `true` equivalent to `'present'` and `false` equivalent to `'absent'`.

##### `filename`
Name to be given to the file, without any path details nor a `.conf` suffix.  This may be used in place of *namevar* if it's beneficial to give *namevar* an arbitrary value.

##### `group`
File group account.  Defaults to `'apache'` which is appropriate for most files.

##### `mode`
File access mode.  Defaults to `'0640'` which is appropriate for most files.

##### `owner`
File owner account.  Defaults to `'root'` which is appropriate for most files.

##### `source`
URI of the file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.


### Data types

#### `Apache::Log_level` data type

Matches acceptable values for Apache's various log levels.  Valid values are: `'debug'`, `'info'`, `'notice'`, `'warn'`, `'error'`, `'crit'`, `'alert'`, `'emerg'`.


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
