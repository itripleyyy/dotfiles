# CapsLock を Left Ctrl にリマップするスクリプト
# 管理者権限で実行してください

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
$regName = "Scancode Map"

# Scancode Map データ
# CapsLock (0x3A) → Left Ctrl (0x1D)
$scancode = ([byte[]](
    0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,
    0x02,0x00,0x00,0x00,
    0x1D,0x00,0x3A,0x00,
    0x00,0x00,0x00,0x00
))

# レジストリに書き込み
Set-ItemProperty -Path $regPath -Name $regName -Value $scancode

Write-Host "✅ CapsLock を Ctrl に置き換えました。再起動すると有効になります。"