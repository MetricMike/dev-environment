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

# WinGET Sync

winget import .\packages.json --accept-package-agreements --accept-source-agreements

# Non-WinGET Packages (no silent install usually)

# Battle.Net

- enable docker and minikube
