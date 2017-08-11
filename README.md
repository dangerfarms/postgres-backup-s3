# postgres-backup-s3
Backup postgresql database dumps in an s3 bucket

This is inspired by the dockerised automatic backups here (https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3) but using the scripts provided on the postgresql wiki (https://wiki.postgresql.org/wiki/Automated_Backup_on_Linux), favouring configuration files over environmental variables due to known issues (google if you are unsure).

