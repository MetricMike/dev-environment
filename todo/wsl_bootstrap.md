###

Consider customizing prompt?
https://ohmyposh.dev/docs/installation/customize
definitely get rid of whatever the first symbol in the git block is

### Install Mono (Valheim/Bepinex plugins)

```sh
# https://www.mono-project.com/download/stable/#download-lin
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update

sudo apt install mono-devel mono-dbg
```

### Install Tailscale

# https://pkgs.tailscale.com/stable/#ubuntu-jammy

# Add Tailscale's GPG key

sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

# Add the tailscale repository

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

# Install Tailscale

sudo apt-get update && sudo apt-get install tailscale

# Start Tailscale!

sudo tailscale up

### Add RockyLinux/CentOS distro?

- I like ubuntu, but AWS and work like RHEL-flavors


### Updates

- enable systemd https://medium.com/geekculture/run-docker-in-windows-10-11-wsl-without-docker-desktop-a2a7eb90556d
- https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/

- defer dns to systemd-resolved
  - https://tailscale.com/kb/1188/linux-dns/

- try out the exit trap pattern
  - http://redsymbol.net/articles/bash-exit-traps/?ck_subscriber_id=512835461


- cody (appimage so need to `sudo apt install libfuse2`)
  - https://sourcegraph.com/.api/app/latest?arch=x86_64&target=linux (this redirects to a github release)
  - might need gWSL? Not sure how to utilize this remotely then... :(
  - oh i didn't have `libgl1-mesa-dev libharfbuzz-dev libthai-dev` installed

- .bin/.linuxbrew are getting on the path multiple times


###

- Add wslu https://wslutiliti.es

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```
