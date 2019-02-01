

FROM "homeassistant/aarch64-homeassistant:latest"
LABEL maintainer="shbatm"

# set version for s6 overlay
ARG OVERLAY_VERSION="v1.21.7.0"
ARG OVERLAY_ARCH="aarch64"

RUN \
 apk add --no-cache --virtual=build-dependencies \
    curl \
    tar && \

 # add s6 overlay
 curl -o \
 /tmp/s6-overlay.tar.gz -L \
    "https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
 tar xfz \
    /tmp/s6-overlay.tar.gz -C / && \ 

 # install socat
 apk add --no-cache \
  socat && \


 # clean up
 apk del --purge \
    build-dependencies && \
 rm -rf \
    /tmp/*


# add local files
COPY root/ /

ENTRYPOINT [ "/init" ]
