# postgres-backup-s3

Backup postgresql database dumps in an s3 bucket

This is inspired by the dockerised automatic backups here (https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3) but favouring configuration files over environmental variables.

## Conventions

The image is opinionated with an emphasis on security as environment variables are not recommended for storing sensitive material.

### Postgres

All configuration needed for pg_dump should use environment variables (https://www.postgresql.org/docs/9.6/static/libpq-envars.html) where necessary other than a PGPASSWORD, which we recommend using a .pgpass file. You can still use PGPASSWORD but it is advised against.

### AWS CLI

All AWS environment variables can be used (http://docs.aws.amazon.com/cli/latest/userguide/cli-environment.html) though it is advised to mount the ~/.aws directory and instead store the access and secret keys in the credentials file like so:

```
[default]
aws_access_key_id = AKIALJZEXAMPLE
aws_secret_access_key = Ig/oZwo6HG1yt/zGhBF+6ahydgoEXAMPLE
```

## Example Usage

Below shows an example docker-compose file

```
version: '3'

volumes:
  pg-config: {}
  aws-config: {}

services:
  backup:
    image: dangerfarms/postgres-backup-s3
    environment:
      PGPASSFILE: /pgpass/.pgpass
      PGHOST: database
      PGDATABASE: postgres
      PGUSER: postgres
      S3_BUCKET: dangerfarms-db
      S3_PREFIX: prefix
      SCHEDULE: "@every 30s"
    volumes:
      - pg-config:/pgpass
      - aws-config:/root/.aws/
    depends_on:
      - database
  database:
    image: postgres
```

## TODO

- [ ] Use non-root user
- [ ] Think about integrating go-cron health check for backup health
