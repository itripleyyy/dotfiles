function Install-Fonts(){
    # システムフォントフォルダとレジストリキーを変数に格納する
    $FontsDir = "$env:SystemRoot\Fonts"
    $RegKey   = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    # すべての TTF ファイルを処理
    Get-ChildItem -Filter *.ttf -File | ForEach-Object {
        # フォントファイルを Windows\Fonts にコピー
        Copy-Item $_.Name -Destination $FontsDir -Force

        # 値名は「ファイル名 (TrueType)」という慣習に従う
        $DisplayName = ($_.BaseName) + " (TrueType)"

        # Set-ItemProperty は存在しない場合も新規作成できる
        Set-ItemProperty -Path $RegKey -Name $DisplayName -Value $_.Name

        Write-Host "Installed: $($_.Name)"
    }
}

# TEMPに移動
Push-Location
Set-Location $env:TEMP

# ダウンロード
Invoke-WebRequest -Uri "https://github.com/yuru7/PlemolJP/releases/download/v3.0.0/PlemolJP_NF_v3.0.0.zip" -OutFile "PlemolJP_NF_v3.0.0.zip"
Invoke-WebRequest -Uri "https://github.com/yuru7/udev-gothic/releases/download/v2.1.0/UDEVGothic_NF_v2.1.0.zip" -OutFile "UDEVGothic_NF_v2.1.0.zip"

# 解凍
Expand-Archive -Path "PlemolJP_NF_v3.0.0.zip" -DestinationPath "PlemolJP_NF_v3.0.0" -Force
Write-Host "ダウンロード & 解凍完了: $(Join-Path (Get-Location) 'PlemolJP_NF_v3.0.0')"

Expand-Archive -Path "UDEVGothic_NF_v2.1.0.zip" -DestinationPath "UDEVGothic_NF_v2.1.0" -Force
Write-Host "ダウンロード & 解凍完了: $(Join-Path (Get-Location) 'UDEVGothic_NF_v2.1.0')"

# PlemolJP35Console NFをインストール
Set-Location "$env:TEMP\PlemolJP_NF_v3.0.0\PlemolJP_NF_v3.0.0\PlemolJP35Console_NF"
Install-Fonts

# PlemolJPConsole NFをインストール
Set-Location "$env:TEMP\PlemolJP_NF_v3.0.0\PlemolJP_NF_v3.0.0\PlemolJPConsole_NF"
Install-Fonts

# UDEVGothic NFをインストール
Set-Location "$env:TEMP\UDEVGothic_NF_v2.1.0\UDEVGothic_NF_v2.1.0"
Install-Fonts

# もともと居たディレクトリに移動して後片付け
Pop-Location

# --- フォルダ削除 ---
$TargetDirs = Get-ChildItem -Path $env:TEMP -Directory -Filter "PlemolJP*"
if ($TargetDirs) {
    Remove-Item -Path $TargetDirs.FullName -Recurse -Force
    Write-Host "TEMPフォルダのPlemolJP*フォルダを削除しました。"
}

$TargetDirs = Get-ChildItem -Path $env:TEMP -Directory -Filter "UDEVGothic*"
if ($TargetDirs) {
    Remove-Item -Path $TargetDirs.FullName -Recurse -Force
    Write-Host "TEMPフォルダのUDEVGothic*フォルダを削除しました。"
}

# --- ZIP削除 ---
$TargetZips = Get-ChildItem -Path $env:TEMP -File -Filter "PlemolJP*.zip"
if ($TargetZips) {
    Remove-Item -Path $TargetZips.FullName -Force
    Write-Host "TEMPフォルダのPlemolJP*.zip を削除しました。"
}

$TargetZips = Get-ChildItem -Path $env:TEMP -File -Filter "UDEVGothic*.zip"
if ($TargetZips) {
    Remove-Item -Path $TargetZips.FullName -Force
    Write-Host "TEMPフォルダのUDEVGothic*.zip を削除しました。"
}