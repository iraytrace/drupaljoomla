The startup.sh will stand up the containers

	website on port 8800
	phpmyadmin on port 8801

the data directory is mounted as /data in the mariadb and drupal containers

If data/config exists and has DB.sql.gz, files.tbz and sync/
then the contents of the previously running site will be re-installed
By convention, the contents of data/sync should be a git repository

It would be possible to add the DB.sql file (uncompressed perhaps?) to the git repo

Backup of the site can be achieved by running backup.sh to put conent in data/config
