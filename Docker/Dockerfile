FROM centos7-base:latest
MAINTAINER ziyun wlcloudy@163.com

RUN yum -y update
RUN yum -y install openssh-server
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key
RUN mkdir -p /root/.ssh
RUN mkdir  /var/run/sshd/

ADD ssh.sh /usr/local/sbin/ssh.sh
RUN chmod 755 /usr/local/sbin/ssh.sh
RUN echo "root:123456"|chpasswd

RUN yum install wget git -y
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz"
RUN wget http://apache.fayea.com/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN cd /opt
RUN tar -xvf jdk-8u201-linux-x64.tar.gz -C /opt/
RUN tar -xvf apache-maven-3.3.9-bin.tar.gz  -C /opt/
ENV JAVA_HOME /opt/jdk1.8.0_201
ENV MAVEN_HOME /opt/apache-maven-3.3.9
ENV CLASSPATH .:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

EXPOSE 22

CMD ["/usr/local/sbin/ssh.sh"]