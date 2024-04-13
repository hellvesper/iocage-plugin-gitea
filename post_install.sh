#!/bin/tcsh


echo "install Gitea"

# echo "Install go1.22"
go install golang.org/dl/go1.22.0@latest
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

/root/go/bin/go1.22.0 download
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

ln -s /root/sdk/go1.22.0/bin/go /usr/local/bin/go122
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

ln -s /root/sdk/go1.22.0/bin/gofmt /usr/local/bin/gofmt122
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
# echo "Fetch and install HomeBox"
cd /root && git clone https://github.com/go-gitea/gitea.git
set status = $status
if ($status != 0) then
    echo "Homebox download failed"
    # Optionally, exit or handle the error
    exit 1
else
    echo ""
    echo "Homebox download succeeded"
    echo ""
endif


# mkdir -p /root/homebox/app
# cd /root/homebox && cp backend/go/bin/api ./app/
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

# cd /root/homebox && chmod +x ./app/api/

# cd /root/homebox && mkdir -p /root/homebox/data
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
sysrc -f /etc/rc.conf homebox_enable=YES
sysrc -f /etc/rc.conf homebox_env="HBOX_MODE=production HBOX_STORAGE_DATA=/root/homebox/data/ HBOX_STORAGE_SQLITE_URL='/root/homebox/data/homebox.db?_pragma=busy_timeout=2000&_pragma=journal_mode=WAL&_fk=1'"
service homebox start


echo "There is no default username and password, register new user with your credentials." >> /root/PLUGIN_INFO
