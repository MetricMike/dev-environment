1. podman cni config issue
    ```bash
    WARN[0000] Error validating CNI config file /home/metricmike/.config/cni/net.d/trasharr_default.conflist: [plugin bridge does not support config version "1.0.0" plugin portmap does not support config version "1.0.0" plugin firewall does not support config version "1.0.0" plugin tuning does not support config version "1.0.0"]
    ```
    - https://bugs.launchpad.net/ubuntu/+source/libpod/+bug/2024394
1. podman / shared mount issue
    - https://github.com/microsoft/WSL/issues/8922

### during ~/.bootstrap-ansible.sh

2. legacy repokey?
    W: https://download.mono-project.com/repo/ubuntu/dists/stable-focal/InRelease: Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.

3. add github token as part of startup.d  - I run into the rate limit too much