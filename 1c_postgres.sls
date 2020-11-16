---
{% if grains['os'] == "Ubuntu" %}
us_locale:
  locale.present:
    - name: en_US.UTF-8

ru_locale:
  locale.present:
    - name: ru_RU.UTF-8

default_locale:
  locale.system:
    - name: ru_RU.UTF-8
    - require:
      - locale: us_locale
      - locale: ru_locale
pgrepo:
  pkgrepo.managed:
    - name: deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main
    - file: /etc/apt/sources.list.d/postgres.list
    - gpgcheck: 1
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
    - require_in:
      - pkg: postgresql-common

postgresql-common:
  pkg.installed

libicu55:
  pkg.installed:
    - sources:
      - libicu55: {{ salt['pillar.get']('1c_pg:lookup:libicu55') }}

postgresql:
  pkg.installed:
    - sources:
      - libpq5 {{ salt['pillar.get']('1c_pg:lookup:libpq5') }}
      - postgresql-client-11: {{ salt['pillar.get']('1c_pg:lookup:postgresql-client-11') }}
      - postgresql-11: {{ salt['pillar.get']('1c_pg:lookup:postgresql-11') }}
    - hold: True
{% endif %}
