# Stable
FROM mysql:8.0.20
COPY ./initial/initial_data.sql /docker-entrypoint-initdb.d/
# Frequent Changes
RUN ["/usr/local/bin/docker-entrypoint.sh"]