#!/bin/tcsh


echo "install Gitea"

# echo "Install go1.22"
go install golang.org/dl/go1.22.2@latest
set status = $status
if ($status != 0) then
    echo "Go122 install failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Go122 install succeeded"
    echo ""
endif

/root/go/bin/go1.22.2 download
set status = $status
if ($status != 0) then
    echo "Go122 download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Go122 download succeeded"
    echo ""
endif

unlink /usr/local/bin/go
ln -s /root/sdk/go1.22.2/bin/go /usr/local/bin/go
set status = $status
if ($status != 0) then
    echo "Go122 linkning failed"
    # Optionally, exit or handle the error
    #exit 1
else
    echo ""
    echo "Go122 linking succeeded"
    echo ""
endif

unlink /usr/local/bin/gofmt
ln -s /root/sdk/go1.22.2/bin/gofmt /usr/local/bin/gofmt
set status = $status
if ($status != 0) then
    echo "gofmt122 linking failed"
    # Optionally, exit or handle the error
    #exit 1
else
    echo ""
    echo "gofmt122 linking succeeded"
    echo ""
endif
hash -r
rehash
# echo "Fetch and install gitea"
cd /root && git clone https://github.com/go-gitea/gitea.git
set status = $status
if ($status != 0) then
    echo "gitea download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "gitea download succeeded"
    echo ""
endif

cd /root/gitea
setenv TAGS "bindata sqlite sqlite_unlock_notify" 
make build

# mkdir -p /root/gitea/app
# cd /root/gitea && cp backend/go/bin/api ./app/
# set status = $status
# if ($status != 0) then
#     echo "Copy app binary failed"
#     # Optionally, exit or handle the error
#     exit 1
# else
#     echo ""
#     echo "Copy app binary succeeded"
#     echo ""
# endif

# cd /root/gitea && chmod +x ./app/api/

# cd /root/gitea && mkdir -p /root/gitea/data
# set status = $status
# if ($status != 0) then
#     echo "Copy app binary failed"
#     # Optionally, exit or handle the error
#     exit 1
# else
#     echo ""
#     echo "Copy app binary succeeded"
#     echo ""
# endif

# echo "Enable nginx service"
sysrc -f /etc/rc.conf nginx_enable=YES
service nginx start
sysrc -f /etc/rc.conf mdnsresponderposix_enable=YES
sysrc -f /etc/rc.conf mdnsresponderposix_flags="-f /usr/local/etc/mdnsresponder.conf"
service mdnsresponderposix start
sysrc -f /etc/rc.conf gitea_enable=YES
service gitea start


echo "There is no default username and password, register new user with your credentials." >> /root/PLUGIN_INFO
