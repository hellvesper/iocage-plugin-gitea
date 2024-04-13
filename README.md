# iocage-plugin-gitea

Artifact files for Gitea iocage plugin

site: https://about.gitea.com
github: https://github.com/go-gitea/gitea

The plugin script will install latest version from master branch of app repository

To install:

- ssh to your TrueNAS or open **Shell** in Web UI
- download plugin `fetch https://raw.githubusercontent.com/hellvesper/iocage-plugin-gitea/master/gitea.json`
- launch installation `iocage fetch -P gitea.json -n gitea` where `gitea` - your plugin jail name.

After installation you can open nginx-ui using ip address or mdns domain adress which will equal jail name. For example above mdns adress will be `http:/gitea.local`

Note:

Plugin configured to use `DHCP`, so it will acquire new `IP` adress from you router which will differ from your **NAS** IP
