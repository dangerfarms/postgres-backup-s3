#! /bin/sh

set -e
set -o pipefail

S3_BUCKET=${S3_BUCKET?"You must set an S3_BUCKET environment variable"}
S3_PREFIX=${S3_PREFIX?"You must set an S3_PREFIX environment variable"}

echo "Creating dump of ${PGDATABASE} database from ${PGHOST}..."

pg_dump | gzip > dump.sql.gz

echo "Uploading dump to $S3_BUCKET"

cat dump.sql.gz | aws s3 cp - s3://$S3_BUCKET/$S3_PREFIX/${PGDATABASE}_$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2

echo "SQL backup uploaded successfully"