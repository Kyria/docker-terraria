FROM debian:8.5

COPY start.sh /start
COPY start_terraria.sh /start_terraria
COPY serverconfig.txt /tmp/serverconfig.txt

RUN apt-get -qq update && apt-get install -qqy \
        zip \
        wget \
        libc6 \
        mono-runtime mono-4.0-gac mono-devel \
    && groupadd -g 1000 terraria \
    && useradd -M -s /bin/false -u 1000 -g terraria -d /opt/terraria  terraria \
    && mkdir -p \
        /opt/terraria/ \
        /world/ \
        /var/log/terraria \
        /data/worlds \
        /data/config \
    && chmod 700 /start /start_terraria\
    && chown -R terraria:terraria \
        /opt/terraria/ \
        /world/ \
        /var/log/terraria \
        /data/ \
        /start_terraria \
    && chmod -R 755 \
        /opt/terraria/ \
        /world/ \
        /var/log/terraria \
        /data/

EXPOSE 7777

VOLUME ["/opt/terraria/", "/var/log/terraria", "/data/worlds", "/data/config"]

WORKDIR /opt/terraria

ENTRYPOINT ["/start"]

ENV UID=1000 GID=1000 \
    TERRARIA_BIN_VERSION=1321 \
    TERRARIA_BIN_URL=http://terraria.org/server/ \
    TERRARIA_BIN_NAME=terraria-server- \
    BIN_ARCHITECTURE=x86_64 \
    LANGUAGE=1 \
    WORLD_NAME=terraria \
    DIFFICULTY=1 \
    MAXPLAYER=8 \
    SERVER_PASSWORD= \
    MOTD="Please don<92>t cut the purple trees!" \
    WORLD_SIZE=1

