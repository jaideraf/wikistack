FROM mariadb:11.1.2-jammy
 
ARG MARIADB_CONTAINER_USER
ARG MARIADB_CONTAINER_GROUP
 
#RUN sed -i "s/#log-error/log-error/g" /etc/mysql/mysql.conf.d/mysqld.cnf
 
RUN usermod -u 1000 ${MARIADB_CONTAINER_USER} \
 && groupmod -g 1000 ${MARIADB_CONTAINER_GROUP}