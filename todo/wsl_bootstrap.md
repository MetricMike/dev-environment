###

### Add RockyLinux/CentOS distro?

- I like ubuntu, but AWS and work like RHEL-flavors


### Updates

- enable systemd https://medium.com/geekculture/run-docker-in-windows-10-11-wsl-without-docker-desktop-a2a7eb90556d
- https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/

- try out the exit trap pattern
  - http://redsymbol.net/articles/bash-exit-traps/?ck_subscriber_id=512835461

- cody (appimage so need to `sudo apt install libfuse2`)
  - https://sourcegraph.com/.api/app/latest?arch=x86_64&target=linux (this redirects to a github release)
  - might need gWSL? Not sure how to utilize this remotely then... :(
  - oh i didn't have `libgl1-mesa-dev libharfbuzz-dev libthai-dev` installed

- .bin/.linuxbrew are getting on the path multiple times

add `loginctl enable-linger $(whoami)`

###

- Add wslu https://wslutiliti.es

```bash
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install wslu
```

###

Need to install system packages before ASDF packages in order to get build dependencies 