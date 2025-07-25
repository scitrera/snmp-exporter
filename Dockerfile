#FROM quay.io/prometheus/snmp-exporter:latest  # switch to docker.io since quay.io is down at the wrong time now...
FROM docker.io/prom/snmp-exporter:latest

# just override the snmp.yml and otherwise make no changes
COPY snmp.yml /etc/snmp_exporter/snmp.yml
