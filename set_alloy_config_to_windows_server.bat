@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

:: ========================================================
:: CONFIGURATION
:: ========================================================
:: (No default URLs provided)
:: ========================================================

:: Color Setup for Console Output
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)
set "C_RESET=%ESC%[0m"
set "C_RED=%ESC%[91m"
set "C_GREEN=%ESC%[92m"
set "C_YELLOW=%ESC%[93m"
set "C_CYAN=%ESC%[96m"
set "C_WHITE=%ESC%[97m"

:: ========================================================
:: LANGUAGE SELECTION
:: ========================================================
echo Select Language / 選擇語言:
echo 1. English
echo 2. Traditional Chinese (繁體中文)
set /p "LANG_CHOICE=Enter choice (1 or 2): "

if "%LANG_CHOICE%"=="2" goto :LANG_ZH
:LANG_EN
set "MSG_HEADER_1=Grafana Alloy Environment Verification Script"
set "MSG_CHECK_ADMIN=[CHECK] Checking for Administrator privileges..."
set "MSG_ADMIN_OK=[OK] Running as Administrator"
set "MSG_ADMIN_FAIL=[ERROR] This script must be run as Administrator"
set "MSG_INPUT_CRED=[INPUT] Please enter credentials:"
set "MSG_LOKI_URL_PROMPT=Enter Loki Base URL: "
set "MSG_LOKI_URL_EMPTY=[ERROR] Loki Base URL cannot be empty."
set "MSG_LOKI_USER_PROMPT=Enter Loki Username: "
set "MSG_USER_EMPTY=[ERROR] Username cannot be empty."
set "MSG_LOKI_PASS_PROMPT=Enter Loki Password:"
set "MSG_HIDDEN_INPUT=(Hidden Input: Right-click once to paste, then press Enter)"
set "MSG_PROM_URL_PROMPT=Enter Prometheus Base URL: "
set "MSG_PROM_URL_EMPTY=[ERROR] Prometheus Base URL cannot be empty."
set "MSG_PROM_USER_PROMPT=Enter Prometheus Username: "
set "MSG_PROM_PASS_PROMPT=Enter Prometheus Password:"
set "MSG_CHECK_DIR=[CHECK] Verifying directories..."
set "MSG_ALLOY_DIR_OK=[OK] Alloy Dir:"
set "MSG_ALLOY_DIR_FAIL=[FAIL] Create Dir Failed"
set "MSG_AGENT_DIR_OK=[OK] Agent Dir:"
set "MSG_AGENT_DIR_WARN=[WARN] Agent Dir not found"
set "MSG_IIS_DIR_OK=[OK] IIS Log Dir:"
set "MSG_IIS_DIR_WARN=[WARN] IIS Logs not found"
set "MSG_CHECK_NET=[CHECK] Verifying API Connectivity..."
set "MSG_TEST_PROM=Testing Prometheus"
set "MSG_PROM_READY=[OK] Prometheus READY"
set "MSG_PROM_FAIL=[ERROR] Prometheus Failed"
set "MSG_TEST_LOKI=Testing Loki"
set "MSG_LOKI_READY=[OK] Loki READY"
set "MSG_LOKI_FAIL=[ERROR] Loki Failed"
set "MSG_DEPLOY_START=[DEPLOY] Generating and deploying configuration..."
set "MSG_TPL_NOT_FOUND=[ERROR] Template file not found:"
set "MSG_READ_TPL=Reading template from:"
set "MSG_GEN_OK=[OK] Config generated:"
set "MSG_GEN_FAIL=[ERROR] Failed to generate config."
set "MSG_TARGET_DIR_WARN=[WARN] Target directory not found. Creating:"
set "MSG_COPY_START=Copying to:"
set "MSG_DEPLOY_OK=[OK] Config deployed successfully."
set "MSG_DEPLOY_FAIL=[ERROR] Failed to deploy config."
set "MSG_FIX_GATE=[FIX] Enabling local-system feature gate..."
set "MSG_GATE_OK=[OK] Feature gate enabled in Registry."
set "MSG_GATE_SKIP=[INFO] Feature gate already active."
set "MSG_RESTART_SERVICE=[SERVICE] Restarting Alloy service..."
set "MSG_SERVICE_RESTARTED=[OK] Service restarted."
set "MSG_SERVICE_FAIL=[ERROR] Failed to restart service."
set "MSG_CHECK_STATUS=[SERVICE] Checking Alloy service status..."
set "MSG_COMPLETE=[INFO] Verification and Deployment complete"
set "MSG_CHECKS_FAILED=[ERROR] One or more checks failed. Aborting deployment."
goto :START_SCRIPT

:LANG_ZH
set "MSG_HEADER_1=Grafana Alloy 環境驗證腳本"
set "MSG_CHECK_ADMIN=[檢查] 正在檢查管理員權限..."
set "MSG_ADMIN_OK=[OK] 以管理員身分執行"
set "MSG_ADMIN_FAIL=[錯誤] 此腳本必須以管理員身分執行"
set "MSG_INPUT_CRED=[輸入] 請輸入憑證資訊："
set "MSG_LOKI_URL_PROMPT=請輸入 Loki Base URL: "
set "MSG_LOKI_URL_EMPTY=[錯誤] Loki Base URL 不能為空。"
set "MSG_LOKI_USER_PROMPT=請輸入 Loki 使用者名稱: "
set "MSG_USER_EMPTY=[錯誤] 使用者名稱不能為空。"
set "MSG_LOKI_PASS_PROMPT=請輸入 Loki 密碼:"
set "MSG_HIDDEN_INPUT=(隱藏輸入：右鍵點擊一次以貼上，然後按 Enter)"
set "MSG_PROM_URL_PROMPT=請輸入 Prometheus Base URL: "
set "MSG_PROM_URL_EMPTY=[錯誤] Prometheus Base URL 不能為空。"
set "MSG_PROM_USER_PROMPT=請輸入 Prometheus 使用者名稱: "
set "MSG_PROM_PASS_PROMPT=請輸入 Prometheus 密碼:"
set "MSG_CHECK_DIR=[檢查] 正在驗證目錄..."
set "MSG_ALLOY_DIR_OK=[OK] Alloy 目錄:"
set "MSG_ALLOY_DIR_FAIL=[失敗] 建立目錄失敗"
set "MSG_AGENT_DIR_OK=[OK] Agent 目錄:"
set "MSG_AGENT_DIR_WARN=[警告] 找不到 Agent 目錄"
set "MSG_IIS_DIR_OK=[OK] IIS Log 目錄:"
set "MSG_IIS_DIR_WARN=[警告] 找不到 IIS Logs"
set "MSG_CHECK_NET=[檢查] 正在驗證 API 連線..."
set "MSG_TEST_PROM=測試 Prometheus"
set "MSG_PROM_READY=[OK] Prometheus 就緒"
set "MSG_PROM_FAIL=[錯誤] Prometheus 失敗"
set "MSG_TEST_LOKI=測試 Loki"
set "MSG_LOKI_READY=[OK] Loki 就緒"
set "MSG_LOKI_FAIL=[錯誤] Loki 失敗"
set "MSG_DEPLOY_START=[部署] 正在產生並部署設定..."
set "MSG_TPL_NOT_FOUND=[錯誤] 找不到範本檔案："
set "MSG_READ_TPL=正在讀取範本："
set "MSG_GEN_OK=[OK] 設定已產生："
set "MSG_GEN_FAIL=[錯誤] 產生設定失敗。"
set "MSG_TARGET_DIR_WARN=[警告] 找不到目標目錄。正在建立："
set "MSG_COPY_START=正在複製到："
set "MSG_DEPLOY_OK=[OK] 設定部署成功。"
set "MSG_DEPLOY_FAIL=[錯誤] 部署設定失敗。"
set "MSG_FIX_GATE=[修正] 正在啟用 local-system 特徵門控..."
set "MSG_GATE_OK=[OK] 已在 Registry 啟用特徵門控。"
set "MSG_GATE_SKIP=[資訊] 特徵門控已在運行中。"
set "MSG_RESTART_SERVICE=[服務] 正在重新啟動 Alloy 服務..."
set "MSG_SERVICE_RESTARTED=[OK] 服務已重新啟動。"
set "MSG_SERVICE_FAIL=[錯誤] 重新啟動服務失敗。"
set "MSG_CHECK_STATUS=[服務] 正在檢查 Alloy 服務狀態..."
set "MSG_COMPLETE=[資訊] 驗證與部署完成"
set "MSG_CHECKS_FAILED=[錯誤] 一項或多項檢查失敗。中止部署。"
goto :START_SCRIPT

:START_SCRIPT
echo %C_CYAN%========================================================%C_RESET%
echo %C_CYAN%%MSG_HEADER_1%%C_RESET%
echo %C_CYAN%========================================================%C_RESET%
echo.

:: 1. Check Administrator privileges
echo %C_CYAN%%MSG_CHECK_ADMIN%%C_RESET%
net session >nul 2>&1
if %errorLevel% == 0 (
    echo %C_GREEN%%MSG_ADMIN_OK%%C_RESET%
) else (
    echo %C_RED%%MSG_ADMIN_FAIL%%C_RESET%
    pause
    exit /b 1
)
echo.

:: ========================================================
:: INTERACTIVE CREDENTIAL INPUT
:: ========================================================
echo %C_CYAN%%MSG_INPUT_CRED%%C_RESET%
echo.

:: --- Loki Configuration Input ---
echo --------------------------------------------------------
set /p "LOKI_BASE_URL=%MSG_LOKI_URL_PROMPT%"
if "%LOKI_BASE_URL%"=="" (
    echo %C_RED%%MSG_LOKI_URL_EMPTY%%C_RESET%
    pause
    exit /b
)

set "LOKI_READY_URL=%LOKI_BASE_URL%/ready"
set "LOKI_PUSH_URL=%LOKI_BASE_URL%/loki/api/v1/push"

set /p "LOKI_USER=%MSG_LOKI_USER_PROMPT%"
if "%LOKI_USER%"=="" (
    echo %C_RED%%MSG_USER_EMPTY%%C_RESET%
    pause
    exit /b
)

:: Note: No visual feedback is shown when typing or pasting the password
echo %MSG_LOKI_PASS_PROMPT%
echo %C_YELLOW%%MSG_HIDDEN_INPUT%%C_RESET%
set "LOKI_PASS="
for /f "usebackq delims=" %%p in (`powershell -NoProfile -Command "$p='';while($true){$k=[System.Console]::ReadKey($true);if($k.KeyChar -eq 13){break}if($k.KeyChar -eq 8){if($p.Length -gt 0){$p=$p.Substring(0,$p.Length-1)}}else{$p+=$k.KeyChar}};Write-Output $p"`) do set "LOKI_PASS=%%p"
echo.

:: --- Prometheus Configuration Input ---
echo --------------------------------------------------------
set /p "PROM_BASE_URL=%MSG_PROM_URL_PROMPT%"
if "%PROM_BASE_URL%"=="" (
    echo %C_RED%%MSG_PROM_URL_EMPTY%%C_RESET%
    pause
    exit /b
)

set "PROM_READY_URL=%PROM_BASE_URL%/-/ready"
set "PROM_PUSH_URL=%PROM_BASE_URL%/api/v1/write"

set /p "PROM_USER=%MSG_PROM_USER_PROMPT%"
if "%PROM_USER%"=="" (
    echo %C_RED%%MSG_USER_EMPTY%%C_RESET%
    pause
    exit /b
)

echo %MSG_PROM_PASS_PROMPT%
echo %C_YELLOW%%MSG_HIDDEN_INPUT%%C_RESET%
set "PROM_PASS="
for /f "usebackq delims=" %%p in (`powershell -NoProfile -Command "$p='';while($true){$k=[System.Console]::ReadKey($true);if($k.KeyChar -eq 13){break}if($k.KeyChar -eq 8){if($p.Length -gt 0){$p=$p.Substring(0,$p.Length-1)}}else{$p+=$k.KeyChar}};Write-Output $p"`) do set "PROM_PASS=%%p"
echo.

:: 2. Verify Local Directories
set "CHECKS_FAILED=0"
echo %C_CYAN%%MSG_CHECK_DIR%%C_RESET%
set "DIR_ALLOY=C:\ProgramData\GrafanaAlloy"
if not exist "%DIR_ALLOY%" mkdir "%DIR_ALLOY%"
if exist "%DIR_ALLOY%" (
    echo %C_GREEN%%MSG_ALLOY_DIR_OK%%C_RESET% %DIR_ALLOY%
) else (
    echo %C_RED%%MSG_ALLOY_DIR_FAIL%%C_RESET%
    set "CHECKS_FAILED=1"
)

set "DIR_AGENT=C:\Program Files\GrafanaLabs\Alloy"
if exist "%DIR_AGENT%" ( echo %C_GREEN%%MSG_AGENT_DIR_OK%%C_RESET% %DIR_AGENT% ) else ( echo %C_RED%%MSG_AGENT_DIR_WARN%%C_RESET% )

set "DIR_IIS_LOGS=C:\inetpub\logs\LogFiles"
if exist "%DIR_IIS_LOGS%" ( echo %C_GREEN%%MSG_IIS_DIR_OK%%C_RESET% %DIR_IIS_LOGS% ) else ( echo %C_YELLOW%%MSG_IIS_DIR_WARN%%C_RESET% )
echo.

:: 3. Verify API Connectivity via Network
echo %C_CYAN%%MSG_CHECK_NET%%C_RESET%

echo %MSG_TEST_PROM% (%PROM_READY_URL%)...
curl -s -u "%PROM_USER%:%PROM_PASS%" -o nul -w "%%{http_code}" --connect-timeout 5 %PROM_READY_URL% | find "200" >nul 2>&1
if %errorLevel% == 0 (
    echo %C_GREEN%%MSG_PROM_READY%%C_RESET%
) else (
    echo %C_RED%%MSG_PROM_FAIL%%C_RESET%
    set "CHECKS_FAILED=1"
)

echo %MSG_TEST_LOKI% (%LOKI_READY_URL%)...
curl -s -u "%LOKI_USER%:%LOKI_PASS%" %LOKI_READY_URL% | findstr /i "ready" >nul 2>&1
if %errorLevel% == 0 (
    echo %C_GREEN%%MSG_LOKI_READY%%C_RESET%
) else (
    echo %C_RED%%MSG_LOKI_FAIL%%C_RESET%
    set "CHECKS_FAILED=1"
)


:: 4. Generate and Deploy Alloy Configuration
if "!CHECKS_FAILED!"=="1" (
    echo.
    echo %C_RED%%MSG_CHECKS_FAILED%%C_RESET%
    pause
    exit /b 1
)

echo %C_CYAN%%MSG_DEPLOY_START%%C_RESET%
set "TEMPLATE_FILE=%~dp0alloy_config_templates\config.windows_server.alloy"
set "OUTPUT_FILE=%~dp0config.alloy"
set "TARGET_DIR=C:\Program Files\GrafanaLabs\Alloy"
set "TARGET_FILE=%TARGET_DIR%\config.alloy"

if not exist "%TEMPLATE_FILE%" (
    echo %C_RED%%MSG_TPL_NOT_FOUND%%C_RESET% %TEMPLATE_FILE%
    pause
    exit /b 1
)

echo %MSG_READ_TPL% %TEMPLATE_FILE%
powershell -NoProfile -Command "(Get-Content '%TEMPLATE_FILE%' -Encoding UTF8) -replace '\[your_prometheus_username\]', '%PROM_USER%' -replace '\[your_prometheus_password\]', '%PROM_PASS%' -replace '\[your_loki_username\]', '%LOKI_USER%' -replace '\[your_loki_password\]', '%LOKI_PASS%' -replace '\[your_prometheus_url\]', '%PROM_PUSH_URL%' -replace '\[your_loki_url\]', '%LOKI_PUSH_URL%' | Set-Content -Encoding UTF8 '%OUTPUT_FILE%'"

if exist "%OUTPUT_FILE%" (
    echo %C_GREEN%%MSG_GEN_OK%%C_RESET% %OUTPUT_FILE%
) else (
    echo %C_RED%%MSG_GEN_FAIL%%C_RESET%
    pause
    exit /b 1
)

if not exist "%TARGET_DIR%" (
    echo %C_YELLOW%%MSG_TARGET_DIR_WARN%%C_RESET% %TARGET_DIR%
    mkdir "%TARGET_DIR%"
)

echo %MSG_COPY_START% %TARGET_FILE%
copy /Y "%OUTPUT_FILE%" "%TARGET_FILE%" >nul
if %errorLevel% == 0 (
    echo %C_GREEN%%MSG_DEPLOY_OK%%C_RESET%
) else (
    echo %C_RED%%MSG_DEPLOY_FAIL%%C_RESET%
)
echo.

:: ========================================================
:: 4.5 FIXED: Enable Feature Gate (Fixes local.command errors)
:: ========================================================
echo %C_CYAN%%MSG_FIX_GATE%%C_RESET%

:: We use a simplified PowerShell execution to avoid Batch escaping issues
powershell -NoProfile -Command ^
    "$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Alloy';" ^
    "if (!(Test-Path $regPath)) { $regPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Grafana Alloy' };" ^
    "if (Test-Path $regPath) {" ^
    "    $imagePath = (Get-ItemProperty -Path $regPath).ImagePath;" ^
    "    if ($imagePath -notlike '*--feature-gates=local-system*') {" ^
    "        $newPath = $imagePath + ' --feature-gates=local-system';" ^
    "        Set-ItemProperty -Path $regPath -Name ImagePath -Value $newPath;" ^
    "        Write-Host '%MSG_GATE_OK%' -ForegroundColor Green" ^
    "    } else {" ^
    "        Write-Host '%MSG_GATE_SKIP%' -ForegroundColor Yellow" ^
    "    }" ^
    "} else {" ^
    "    Write-Host 'Service Registry path not found.' -ForegroundColor Red" ^
    "}"
echo.

:: 5. Restart and Verify the Alloy Service
echo %C_CYAN%%MSG_RESTART_SERVICE%%C_RESET%

:: Use a more forceful restart logic
powershell -NoProfile -Command ^
    "$svcs = Get-Service -Name Alloy, 'Grafana Alloy' -ErrorAction SilentlyContinue | Where-Object { $_.Status -ne 'Stopped' };" ^
    "if ($svcs) { Restart-Service -InputObject $svcs -Force -ErrorAction SilentlyContinue } else { Start-Service -Name Alloy, 'Grafana Alloy' -ErrorAction SilentlyContinue };" ^
    "Start-Sleep -Seconds 2;" ^
    "if ((Get-Service -Name Alloy, 'Grafana Alloy' -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Running' })) {" ^
    "    Write-Host '%MSG_SERVICE_RESTARTED%' -ForegroundColor Green" ^
    "} else {" ^
    "    Write-Host '%MSG_SERVICE_FAIL%' -ForegroundColor Red" ^
    "}"

echo %C_CYAN%%MSG_CHECK_STATUS%%C_RESET%
powershell -NoProfile -Command "Get-Service Alloy, 'Grafana Alloy' -ErrorAction SilentlyContinue | Select-Object Status, Name, DisplayName"
echo.
echo %C_CYAN%%MSG_COMPLETE%%C_RESET%
pause
exit /b