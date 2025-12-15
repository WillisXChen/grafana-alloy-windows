# Grafana Alloy Windows Server Installation and Configuration Guide

This document explains how to install Grafana Alloy on Windows Server and apply the `config.windows.server.alloy` configuration file to collect Windows Metrics, Windows Event Logs, and IIS Logs.

## 1. Download & Install

1.  **Download Installer**:
    Please download the latest version of `alloy-installer-windows-amd64.exe`:
    [Download Link](https://github.com/grafana/alloy/releases/download/v1.12.0/alloy-installer-windows-amd64.exe)

2.  **Run Installation**:
    - Double-click the installer.
    - It is recommended to keep the default installation path (`C:\Program Files\GrafanaLabs\Alloy`).
    - After installation, the Alloy service will be automatically registered but not yet fully configured.

## 2. Run Configuration Script

We provide an automated script `set_alloy_config_to_windows_server.bat` to help generate the configuration file and verify the environment.

### Execution Steps

1.  **Run as Administrator**:
    - **Method A (GUI)**: Right-click `set_alloy_config_to_windows_server.bat` and select "Run as administrator".
    - **Method B (PowerShell)**: Open PowerShell (as Administrator), switch to the script directory, and run:
      ```powershell
      .\set_alloy_config_to_windows_server.bat
      ```

2.  **Select Language**:
    - Enter `1` for English.
    - Enter `2` for Traditional Chinese.

3.  **Enter Credentials**:
    The script will ask for the following information in order, please have it ready (Please obtain from Loki & Prometheus administrators):

    - **Loki Information (Logs)**:
        - `Loki Base URL`: e.g., `http://loki.example.com` (Do not include `/loki/api/...`)
        - `Loki Username`: Your Loki username
        - `Loki Password`: Your Loki password (Input will be hidden, right-click to paste then press Enter)

    - **Prometheus Information (Metrics)**:
        - `Prometheus Base URL`: e.g., `http://prometheus.example.com`
        - `Prometheus Username`: Your Prometheus username
        - `Prometheus Password`: Your Prometheus password (Input will be hidden, right-click to paste then press Enter)

---
**Note**: If the IIS Log directory is different, please manually modify the configuration file or verify the path.
