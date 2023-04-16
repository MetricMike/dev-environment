###

Updating posh blows away the current console and forces you to exit and re-enter. Not life changing, but annoying.

Consider customizing prompt?
https://ohmyposh.dev/docs/installation/customize
definitely get rid of whatever the first symbol in the git block is 


### Install Mono (Valheim/Bepinex plugins)

``` sh
# https://www.mono-project.com/download/stable/#download-lin
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

sudo apt install mono-devel mono-dbg
```