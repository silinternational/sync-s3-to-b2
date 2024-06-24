#!/usr/bin/env sh

MYNAME="sync-s3-to-b2"
STATUS=0

echo "${MYNAME}: Started"

echo "${MYNAME}: Configuring rclone"

mkdir -p ~/.config/rclone
cat > ~/.config/rclone/rclone.conf << EOF
# Created by sync-s3-to-b2.sh

[b2bucket]
type = b2
hard_delete = true
account = ${B2_APPLICATION_KEY_ID}
key = ${B2_APPLICATION_KEY}

[s3bucket]
type = s3
provider = AWS
access_key_id = ${AWS_ACCESS_KEY}
secret_access_key = ${AWS_SECRET_KEY}
region = ${AWS_REGION}
location_constraint = ${AWS_REGION}

EOF

# Adding "--combined - " to RCLONE_ARGUMENTS will list all file paths with a
# symbol and then a space and then the path to tell you what happened to it.

echo "${MYNAME}: Starting rclone sync"

start=$(date +%s)
rclone sync --checksum --create-empty-src-dirs --metadata --transfers 32 ${RCLONE_ARGUMENTS} s3bucket:${S3_BUCKET}/${S3_PATH} b2bucket:${B2_BUCKET}/${B2_PATH} || STATUS=$?
end=$(date +%s)

if [ $STATUS -ne 0 ]; then
    echo "${MYNAME}: FATAL: Sync of ${S3_BUCKET}/${S3_PATH} to ${B2_BUCKET}/${B2_PATH} returned non-zero status ($STATUS) in $(expr ${end} - ${start}) seconds."
    exit $STATUS
else
    echo "${MYNAME}: Sync of ${S3_BUCKET}/${S3_PATH} to ${B2_BUCKET}/${B2_PATH}  completed in $(expr ${end} - ${start}) seconds."
fi

echo "${MYNAME}: Completed"
