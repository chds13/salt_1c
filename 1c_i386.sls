---
{% if grains['os'] == "Ubuntu" %}

accept_i386_packages:
  cmd.run:
    - name: dpkg --add-architecture i386 && apt update

install_i386_requirements:
  pkg.installed:
    - pkgs: [ 'imagemagick:i386', 'unixodbc:i386' ]
    - require:
      - cmd: accept_i386_packages

install_libgsf-1-114_i386:
  pkg.installed:
    - sources:
      - libgsf-1-common: {{ salt['pillar.get']('1c_i386:lookup:libgsf-1-common') }}
      - 'libgsf-1-114:i386': {{ salt['pillar.get']('1c_i386:lookup:libgsf-1-114') }}

install_1c_i386:
  pkg.installed:
    - sources:
      - '1c-enterprise83-common:i386': {{ salt['pillar.get']('1c_i386:lookup:1c-enterprise83-common') }}
      - '1c-enterprise83-server:i386': {{ salt['pillar.get']('1c_i386:lookup:1c-enterprise83-server') }}
    - require:
      - pkg: install_libgsf-1-114_i386
      - pkg: install_i386_requirements

srv1cv83.service:
  service.running:
    - enable: True
    - require:
      - pkg: install_1c_i386

{% endif %}
