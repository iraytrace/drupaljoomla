#!/bin/bash

if [ $# -ne 2 ] ; then
	echo "Usage $0 input.sql"
	exit -1
fi
# MySQL credentials
DB_USER="drupal"
DB_PASSWORD="drupal"
DB_NAME="drupal"

# Directory to store table dumps (optional)
OUTPUT_DIR="./tables"
if [ ! -d $OUTPUT_DIR ] ; then
	mkdir -p $OUTPUT_DIR
fi


# import the data
mysql --user=$DB_USER --password=$DB_PASSWORD $DB_NAME < /$1


# Get a list of tables in the database, and remove carriage returns
TABLES=$(mysql -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e 'SHOW TABLES;' | tr -d '\15' | tail -n +2 )

# Iterate over each table and dump its contents
for TABLE in $TABLES; do
    if [[ $TABLE == dp_* ]]; then
        continue
    fi

    echo "Dumping table: $TABLE"
    mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME $TABLE | grep -v 'Dump completed on' >  "$OUTPUT_DIR/$TABLE.sql"
    
    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo "Table $TABLE dumped successfully to $OUTPUT_DIR/$TABLE.sql"
    else
        echo "Failed to dump table $TABLE"
    fi
done

echo "All table dumps completed."
tar cjvf tables.tbz $OUTPUT_DIR
# rm -rf $OUTPUT_DIR

