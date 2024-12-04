<?php

// Database connection details
$host = 'db';  // Database host
$port = 3306;         // Database port
$dbname = 'drupal'; // Database name (optional, can be used for testing the connection further)
$username = 'drupal'; // Database username
$password = 'drupal'; // Database password
$retryInterval = 5;  // Time (in seconds) to wait between retries
$maxRetries = 10;    // Maximum number of retries (set to 0 for unlimited retries)

$attempt = 0;

echo "Attempting to connect to the database...\n";

while (true) {
    try {
        $attempt++;
        // Create a new PDO instance
        $dsn = "mysql:host=$host;port=$port;dbname=$dbname";
        $pdo = new PDO($dsn, $username, $password);

        // Set PDO error mode to exception for better error handling
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        echo "Connection successful on attempt $attempt!\n";
        break;
    } catch (PDOException $e) {
        echo "Attempt $attempt failed: " . $e->getMessage() . "\n";

        // Check if maximum retries have been reached
        if ($maxRetries > 0 && $attempt >= $maxRetries) {
            echo "Maximum retry attempts ($maxRetries) reached. Exiting...\n";
            exit(1); // Exit with an error code
        }

        echo "Retrying in $retryInterval seconds...\n";
        sleep($retryInterval);
    }
}

