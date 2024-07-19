# sync-s3-to-b2
Service to synchronize an AWS S3 bucket path to a Backblaze B2 bucket path

This process uses `rclone sync` to copy changes from a specified directory in an AWS S3 bucket to a specified directory in a Backblaze B2 bucket. After configuring `rclone`, the script executes `rclone sync --checksum --create-empty-src-dirs --metadata --transfers 32 ${RCLONE_ARGUMENTS} s3bucket:${S3_BUCKET}/${S3_PATH} b2bucket:${B2_BUCKET}/${B2_PATH}`.

## How to use it
1. Create an AWS access key that allows read access to the source S3 bucket.
2. Create a Backblaze Application Key that allows read, write, and delete access to the destination B2 bucket.
3. Supply all appropriate environment variables.
4. Run the sync.
5. Verify the destination bucket is identical to the source bucket.

**Note:** Empty directories in the AWS S3 bucket may not be created on the Backblaze B2 bucket. See the `rclone` documentation for details.

### Environment variables
`AWS_ACCESS_KEY` - used to access the AWS S3 bucket

`AWS_SECRET_KEY` - used to access the AWS S3 bucket

`AWS_REGION` - AWS region the S3 bucket was created in

`B2_APPLICATION_KEY_ID` - used to access the Backblaze B2 bucket

`B2_APPLICATION_KEY` - used to access the Backblaze B2 bucket

`S3_BUCKET` - AWS S3 bucket name, e.g., _my-s3-storage-bucket_

`S3_PATH` - path within the AWS S3 bucket

`B2_BUCKET` - Backblaze B2 bucket name, e.g., _my-b2-copy-bucket_

`B2_PATH` - path within the Backblaze B2 bucket

`RCLONE_ARGUMENTS` - (optional) Extra rclone arguments. For example, adding `--combined -` to `RCLONE_ARGUMENTS` will "list all file paths with a symbol and then a space and then the path to tell you what happened to it".

## Docker Hub
This image is built automatically on Docker Hub as [silintl/sync-s3-to-b2](https://hub.docker.com/r/silintl/sync-s3-to-b2/).
