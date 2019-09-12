FROM amd64/centos:latest

# Enabled systemd
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#VOLUME [ "/sys/fs/cgroup" ]

VOLUME [ "/config" ]

# copy root
COPY rootfs/ /

# Base Apps
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y net-tools initscripts wget

# Sonarr v3
RUN mkdir -p /opt/sonarr
RUN mkdir -p /opt/sonarr/bin
WORKDIR /opt/sonarr
RUN wget "https://services.sonarr.tv/v1/download/phantom-develop/latest?version=3&os=linux"
RUN mv "latest?version=3&os=linux" "Sonarr.phantom-develop.current.linux.tar.gz"
RUN tar xzfv "Sonarr.phantom-develop.current.linux.tar.gz"
RUN rm -rf "Sonarr.phantom-develop.current.linux.tar.gz"
RUN mv Sonarr/* bin/
RUN useradd sonarr -s /sbin/nologin
RUN rm -rf Sonarr/
RUN chown -R sonarr:sonarr /opt/sonarr
RUN rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
RUN yum install -y mediainfo libzen libmediainfo curl gettext mono-core mono-devel sqlite.x86_64
RUN yum install -y git par2cmdline p7zip unrar unzip tar gcc python-feedparser python-configobj python-cheetah python-dbus python-devel libxslt-devel

# crontab
RUN yum install -y cronie
RUN (crontab -l 2>/dev/null; echo "* * * * * /usr/bin/verify-services.sh") | crontab -


# configure services (systemd)
RUN systemctl enable sonarr.service

WORKDIR /root/

# End
CMD ["/usr/sbin/init"]