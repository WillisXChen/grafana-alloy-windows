# Grafana Alloy Windows Server 安裝與設定指南

本文件說明如何在 Windows Server 上安裝 Grafana Alloy 並套用 `config.windows.server.alloy` 設定檔，以收集 Windows Metrics、Windows Event Logs 及 IIS Logs。

## 1. 下載與安裝 (Download & Install)

1.  **下載安裝檔**:
    請下載最新版本的 `alloy-installer-windows-amd64.exe`：
    [Download Link](https://github.com/grafana/alloy/releases/download/v1.12.0/alloy-installer-windows-amd64.exe)

2.  **執行安裝**:
    - 雙擊執行安裝檔。
    - 建議保持預設安裝路徑 (`C:\Program Files\GrafanaLabs\Alloy`)。
    - 安裝完成後，Alloy 服務會自動註冊，但尚未設定完成。

## 2. 執行設定腳本 (Run Configuration Script)

我們提供了一個自動化腳本 `set_alloy_config_to_windows_server.bat` 來協助產生設定檔並驗證環境。

### 執行步驟

1.  **以管理員身分執行 (Run as Administrator)**:
    - **方法 A (GUI)**: 右鍵點擊 `set_alloy_config_to_windows_server.bat`，選擇「以系統管理員身分執行」。
    - **方法 B (PowerShell)**: 開啟 PowerShell (以管理員身分)，切換到腳本目錄並執行：
      ```powershell
      .\set_alloy_config_to_windows_server.bat
      ```

2.  **選擇語言 (Select Language)**:
    - 輸入 `1` 選擇英文 (English)。
    - 輸入 `2` 選擇繁體中文 (Traditional Chinese)。

3.  **輸入憑證資訊 (Enter Credentials)**:
    腳本會依序詢問以下資訊，請事先準備好 (請跟Loki & prometheus的管理者取得)：

    - **Loki 資訊 (Logs)**:
        - `Loki Base URL`: 例如 `http://loki.example.com` (勿包含 `/loki/api/...`)
        - `Loki Username`: 您的 Loki 使用者名稱
        - `Loki Password`: 您的 Loki 密碼 (輸入時會隱藏，右鍵貼上後按 Enter)

    - **Prometheus 資訊 (Metrics)**:
        - `Prometheus Base URL`: 例如 `http://prometheus.example.com`
        - `Prometheus Username`: 您的 Prometheus 使用者名稱
        - `Prometheus Password`: 您的 Prometheus 密碼 (輸入時會隱藏，右鍵貼上後按 Enter)

---
**注意**: 若 IIS Log 目錄不同，請手動修改設定檔或確認路徑。