# MTower

$DROPBOX="I:\Users\Michael\Dropbox"

# MSurface

$DROPBOX=C":\mStore\Dropbox"

cascadia code nf
https://ohmyposh.dev

# Point minikube, kube, and docker to I:\
New-Item -ItemType Directory -Force -Path I:\Users\Michael\.minikube
New-Item -ItemType Directory -Force -Path I:\Users\Michael\.kube
New-Item -ItemType Directory -Force -Path I:\Users\Michael\.docker

New-Item -ItemType Junction -Force -Path $env:USERPROFILE\.minikube -Value I:\Users\Michael\.minikube
New-Item -ItemType Junction -Force -Path $env:USERPROFILE\.kube -Value I:\Users\Michael\.kube
New-Item -ItemType Junction -Force -Path $env:USERPROFILE\.docker -Value I:\Users\Michael\.docker

# move r2modman (slow)
New-Item -ItemType Directory -Force -Path I:\Users\Michael\AppData\Roaming\r2modmanPlus-local
New-Item -ItemType Junction -Force -Path $env:APPDATA\r2modmanPlus-local -Value I:\Users\Michael\AppData\Roaming\r2modmanPlus-local

# move vrising saves (slow)
New-Item -ItemType Directory -Force -Path "I:\Users\Michael\AppData\LocalLow\Stunlock Studios"
New-Item -ItemType Junction -Force -Path "$env:USERPROFILE\AppData\LocalLow\Stunlock Studios" -Value "I:\Users\Michael\AppData\LocalLow\Stunlock Studios"

# move vscode (faster)
New-Item -ItemType Directory -Force -Path M:\Users\Michael\.vscode
New-Item -ItemType Directory -Force -Path M:\Users\Michael\.vscode-server

New-Item -ItemType Junction -Force -Path $env:USERPROFILE\.vscode -Value M:\Users\Michael\.vscode
New-Item -ItemType Junction -Force -Path $env:USERPROFILE\.vscode-server -Value M:\Users\Michael\.vscode-server

# move nvidia shadercache
New-Item -ItemType Directory -Force -Path M:\Users\Michael\AppData\LocalLow\NVIDIA
New-Item -ItemType Junction -Force -Path $env:USERPROFILE\NVIDIA -Value M:\Users\Michael\AppData\LocalLow\NVIDIA


# WinGET Sync

winget import .\packages.json --accept-package-agreements --accept-source-agreements

# Non-WinGET Packages (no silent install usually)

# Battle.Net

- enable docker and minikube
