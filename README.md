# SNMP Exporter for APC UPS

This project provides a repackaged version of the [Prometheus SNMP Exporter](https://github.com/prometheus/snmp_exporter) specifically patched to address issues with reading data from APC UPS devices via SNMP, as referenced in [GitHub issue 632](https://github.com/prometheus/snmp_exporter/issues/632).

## Overview

This container builds upon the official `quay.io/prometheus/snmp-exporter` image but replaces the default SNMP configuration with a custom `snmp.yml` file optimized for APC UPS monitoring. The configuration includes comprehensive metrics for APC UPS devices, ensuring proper data collection where the standard configuration might fail.

## Features

- Based on the official Prometheus SNMP Exporter
- Custom configuration for APC UPS devices
- Fixes issues with reading data from APC UPS via SNMP
- Comprehensive metrics collection for UPS monitoring

### Prometheus Configuration

Add the following to your Prometheus configuration to scrape metrics from your APC UPS devices:

```yaml
scrape_configs:
  - job_name: 'apc_ups'
    static_configs:
      - targets:
        - ups1.example.com  # UPS device hostname or IP
        - ups2.example.com  # UPS device hostname or IP
    metrics_path: /snmp
    params:
      module: [ap[README.md](README.md)cups]
      target: [${__address__}]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: localhost:9116  # SNMP exporter address
```

## Configuration

The container uses a custom `snmp.yml` configuration file that includes:

- Authentication settings for SNMP v1 and v2
- Detailed module configuration for APC UPS devices
- Comprehensive metrics collection for various UPS parameters

### Available Metrics

The exporter collects a wide range of metrics from APC UPS devices, including:

- Power status
- Battery status and capacity
- Input/output voltage and current
- Temperature
- Load percentage
- Outlet group status
- And many more

## Differences from Original SNMP Exporter

This container differs from the original SNMP Exporter in the following ways:

1. Custom `snmp.yml` configuration specifically optimized for APC UPS devices. Note that this was originally made in Sept 2024, so the basis for snmp.yml might be somewhat out of date. I'll consider later to make this a continuously updated repo.
2. Addresses issues with reading data from APC UPS via SNMP (GitHub issue 632)
3. No code changes to the exporter itself, only configuration changes

## License

This project follows the same license as the original [Prometheus SNMP Exporter](https://github.com/prometheus/snmp_exporter).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.