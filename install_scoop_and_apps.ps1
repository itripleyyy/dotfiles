# scoopをインストール
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# extraバケットを追加してアップデート
scoop bucket add extras
scoop update

# scoopアプリをインストール
scoop install git
scoop install 7zip
scoop install brave
scoop install espanso
scoop install obsidian
scoop install thunderbird