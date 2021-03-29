FROM debian:bullseye-slim
ENV KICKSOCCER_DATA=/home/zcore/.zcore

RUN useradd -r zcore \
    && apt-get update -y \
    && apt-get install -y curl gnupg gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /zcore
ADD bin /zcore
COPY bin/zcored /usr/bin/zcored

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod 777  entrypoint.sh


VOLUME ["/home/zcore/.zcore"]

EXPOSE 8332 8333 18332 18333 18443 18444 38333 38332

ENTRYPOINT ["/entrypoint.sh"]

CMD ["zcored"]