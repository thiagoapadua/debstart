#!/bin/bash

echo "
deb http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware contrib non-free
deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware contrib non-free
deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware contrib non-free" > /etc/apt/sources.list

apt update
apt -y install vim wget net-tools tcpdump ccze ssh ntpdate sudo lsb-release gnupg systemd-timesyncd

gpasswd -a operador sudo

timedatectl set-timezone America/Sao_Paulo
systemctl start systemd-timesyncd

echo "alias ls='ls --color=auto'
alias l='ls -lhF'
alias ll='ls -lhaF'
alias la='ls -a'
alias c='clear'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
alias su='su -'
alias susu='sudo su -'
alias ts='journalctl -f |ccze -CA'" >>/etc/bash.bashrc

echo "PS1=\"\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ \"" >> /etc/profile

sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /home/operador/.bashrc

sed -i 's/mouse=a/mouse-=a/' /usr/share/vim/vim90/defaults.vim

sed -i 's/"set background=dark/set background=dark/' /etc/vim/vimrc

echo "Port 1414
PermitRootLogin no
AllowUsers operador" >>/etc/ssh/sshd_config

systemctl restart ssh

