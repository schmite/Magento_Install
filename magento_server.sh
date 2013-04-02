# Install last updates
yum update -y

# Install Kernel packages
yum install -y kernel*

# Store IP address assigned to eth0
server_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

# Store server hostname
server_hostname=$(/bin/hostname)

# Set the hosts file and disable ip6
echo "$server_ip $server_hostname" >> /etc/hosts
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

#TODO: put the script file in /etc/rc.local before reboot
reboot


# Disable un-needed services (look them up if you are interested) / Probably, this procedure should display some errors about
# 'reading information on service' or 'unrecognized service'. Don't worry. :)
chkconfig NetworkManager off
chkconfig NetworkManagerDispatcher off
chkconfig anacron off
chkconfig atd off
chkconfig bluetooth off
chkconfig cpuspeed off
chkconfig cups off
chkconfig gpm off
chkconfig hidd off
chkconfig ip6tables off
chkconfig iptables off
chkconfig irda off
chkconfig mdmonitor off
chkconfig mdmpd off
chkconfig pcscd off
chkconfig portmap off
chkconfig yum-updatesd off
chkconfig smartd off
service smartd stop
service NetworkManager stop
service NetworkManagerDispatcher stop
service anacron stop
service atd stop
service bluetooth stop
service cpuspeed stop
service cups stop
service gpm stop
service hidd stop
service ip6tables stop
service iptables stop
service irda stop
service mdmonitor stop
service mdmpd stop
service pcscd stop
service portmap stop
service yum-updatesd stop

# Install Apache
yum install -y httpd
chkconfig httpd on
service httpd start

# Install php and required php extensions for Magento
yum install -y php-common php
yum install -y gd gd-devel
yum install -y php-mcrypt php-xml php-devel php-imap php-soap php-mbstring
yum install -y php-mhash php-simplexml php-dom php-gd php-pear php-pecl-imagick php-magickwand #(php-mhash extension no longer required as of php5.3(which is what you’ll get following these commands)-replaced by HASH Message Digest Framework in php core)
yum install -y php-mysql php-pdo
