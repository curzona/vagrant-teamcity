apt-get -y update
apt-get -y install vim curl nmap tree zip htop upstart 
apt-get -y install openjdk-7-jre-headless

wget http://download-cf.jetbrains.com/teamcity/TeamCity-9.0.2.tar.gz
tar -zxf TeamCity-9.0.2.tar.gz
mv TeamCity /opt/teamcity-server
chown -R www-data /opt/teamcity-server
mkdir /var/teamcity-server
chown -R www-data /var/teamcity-server

cp /vagrant/teamcity-server /etc/init.d/teamcity-server
chmod +x /etc/init.d/teamcity-server
update-rc.d teamcity-server defaults
/etc/init.d/teamcity-server start

#wget http://localhost:8111/update/buildAgent.zip
#unzip buildAgent.zip -d buildAgent
#mv buildAgent /opt/teamcity-agent
cp -R /opt/teamcity-server/buildAgent /opt/teamcity-agent
chmod +x /opt/teamcity-agent/agent.sh
chown -R www-data /opt/teamcity-agent
mkdir /var/teamcity-agent
chown -R www-data /var/teamcity-agent

sed -e "s/..\/work/\/var\/teamcity-agent\/work/g" \
    -e "s/..\/temp/\/var\/teamcity-agent\/temp/g" \
    -e "s/..\/system/\/var\/teamcity-agent\/system/g" \
    /opt/teamcity-agent/conf/buildAgent.dist.properties \
    > /opt/teamcity-agent/conf/buildAgent.properties

cp /vagrant/teamcity-agent /etc/init.d/teamcity-agent
chmod +x /etc/init.d/teamcity-agent
update-rc.d teamcity-agent defaults
/etc/init.d/teamcity-agent start
