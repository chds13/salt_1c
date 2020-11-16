---
{% if grains['os'] == "Ubuntu" %}

accept_i386:
  cmd.run:
    - name: dpkg --add-architecture i386 &&
            apt update

haspd_install:
  pkg.installed:
    - sources:
      - haspd: http://192.168.123.253/1c/hasp_7.90/linux_deb/haspd_7.90-eter2ubuntu_i386.deb
      - haspd-modules: http://192.168.123.253/1c/hasp_7.90/linux_deb/haspd-modules_7.90-eter2ubuntu_i386.deb

haspd.service:
  service.running:
    - enable: True

{% endif %}
