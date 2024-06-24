FROM alpine:3

RUN apk update \
 && apk add --no-cache bash curl unzip \
 && curl https://rclone.org/install.sh | bash

COPY sync-s3-to-b2.sh /data/
WORKDIR /data

CMD ["./sync-s3-to-b2.sh"]
