# ダウンロード先のURLを設定
$driverUrl = "https://jp.download.nvidia.com/Windows/580.88/580.88-desktop-win10-win11-64bit-international-dch-whql.exe"
$downloadPath = "$env:TEMP\NvidiaDriver.exe"

# ドライバをダウンロード
Write-Host "Nvidiaドライバをダウンロード中..."
try {
    Invoke-WebRequest -Uri $driverUrl -OutFile $downloadPath -ErrorAction Stop
} catch {
    Write-Host "ドライバのダウンロードに失敗しました。エラー: $_"
    exit 1
}

# ダウンロードしたドライバをインストール（サイレントインストール）
Write-Host "インストール中..."
try {
    Start-Process -FilePath $downloadPath -ArgumentList "/s" -Wait -ErrorAction Stop
} catch {
    Write-Host "インストールに失敗しました。エラー: $_"
    exit 1
}
Write-Host "インストール完了！"