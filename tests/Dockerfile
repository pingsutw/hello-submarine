FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*

ADD echo.sh /tmp/echo.sh
RUN chmod 777 /tmp/echo.sh

WORKDIR /tmp

ENTRYPOINT ["/tmp/echo.sh"]
# ENTRYPOINT [ "echo hello" ]
