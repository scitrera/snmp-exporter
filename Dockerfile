FROM quay.io/prometheus/snmp-exporter:latest

# just override the snmp.yml and otherwise make no changes
COPY snmp.yml /etc/snmp_exporter/snmp.yml
