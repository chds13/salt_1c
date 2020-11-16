---
{% if grains['os'] == "Ubuntu" %}
install_requirements:
  pkg.installed:
    - pkgs: [ libwebkitgtk-3.0-0, fontconfig, libgsf-1-114, libglib2.0-bin, libkrb5-3, libgssapi-krb5-2]

install_1c:
  pkg.installed:
    - sources:
      - 1c-enterprise83-common: {{ salt['pillar.get']('1c_amd64:lookup:1c-enterprise83-common') }}
      - 1c-enterprise83-server: {{ salt['pillar.get']('1c_amd64:lookup:1c-enterprise83-server') }}

srv1cv83.service:
  service.running:
    - enable: True

{% endif %}
