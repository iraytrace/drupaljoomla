#!/bin/bash

# MySQL credentials
DB_USER="drupal"
DB_PASSWORD="drupal"
DB_NAME="drupal"

# Directory to store table dumps (optional)
OUTPUT_DIR="."

# Get a list of tables in the database, and remove carriage returns
TABLES=$(mysql -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e 'SHOW TABLES;' | tr -d '\15' | grep -v cache | tail -n +2 )

# Iterate over each table and dump its contents
for TABLE in $TABLES; do
    echo "Dumping table: $TABLE"
    if [[ $TABLE == cache* ]]; then
        echo "Truncating cache table: $TABLE"
        mysql -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e "TRUNCATE TABLE $TABLE;"
    fi

    mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME $TABLE | grep -v 'Dump completed on' >  "$OUTPUT_DIR/$TABLE.sql"
    
    # Check if the dump was successful
    if [ $? -eq 0 ]; then
        echo "Table $TABLE dumped successfully to $OUTPUT_DIR/$TABLE.sql"
    else
        echo "Failed to dump table $TABLE"
    fi
done

echo "All table dumps completed."

