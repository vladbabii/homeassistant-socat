FROM "homeassistant/aarch64-homeassistant:latest"
LABEL maintainer="Vlad Babii"

RUN mkdir /runwatch
COPY runwatch/* /runwatch/
RUN chmod +x /runwatch/*

# Install socat
RUN apk add socat

ENTRYPOINT [ "/bin/entry.sh" ]
CMD [ "/bin/bash","/runwatch/run.sh" ]
