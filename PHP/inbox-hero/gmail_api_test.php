<?php

require 'vendor/autoload.php';

define('APPLICATION_NAME', 'Inbox Hero');
define('CREDENTIALS_PATH', '~/.credentials/gmail-php-quickstart.json');
define('CLIENT_SECRET_PATH', 'client_secret.json');
define('SCOPES', implode(' ', array(Google_Service_Gmail::GMAIL_READONLY)));

/**
 * Returns an authorized API client.
 *
 * @return Google_Client the authorized API client
 */
function getClient() {
    $client = new Google_Client();

    $client->setApplicationName(APPLICATION_NAME);
    $client->setScopes(SCOPES);
    $client->setAuthConfigFile(CLIENT_SECRET_PATH);
    $client->setAccessType('offline');

    // If they exist, load the previously authorized credentials from the file in
    // which they were saved
    $credentialsPath = expandHomeDirectory(CREDENTIALS_PATH);

    if (file_exists($credentialsPath)) {
        $accessToken = file_get_contents($credentialsPath);
    } else {
        // Prompt the user to authorize
        $authUrl = $client->createAuthUrl();

        printf("Visit this link in your browser...\n%s\n", $authUrl);

        print '...Then enter your verification code: ';

        $authCode = trim(fgets(STDIN));

        // Exchange the authorization code for an access token
        $accessToken = $client->authenticate($authCode);

        // Store the user's credentials
        if(!file_exists(dirname($credentialsPath))) {
            mkdir(dirname($credentialsPath), 0700, true);
        }

        file_put_contents($credentialsPath, $accessToken);

        printf("Your credentials were saved in %s\n", $credentialsPath);
    }

    $client->setAccessToken($accessToken);

    // Refresh the token if it has expired
    if ($client->isAccessTokenExpired()) {
        $client->refreshToken($client->getRefreshToken());

        file_put_contents($credentialsPath, $client->getAccessToken());
    }

    return $client;
}

/**
 * Expands the home directory alias (i.e. '~') to its full path.
 *
 * @param string $path the path to expand
 * @return string the expanded path
 */
function expandHomeDirectory($path) {
    $homeDirectory = getenv('HOME');

    if (empty($homeDirectory)) {
        $homeDirectory = getenv("HOMEDRIVE") . getenv("HOMEPATH");
    }

    return str_replace('~', realpath($homeDirectory), $path);
}

// Get the API client and create the service object
$client = getClient();
$service = new Google_Service_Gmail($client);

// Print all the labels in the user's mailbox
$user = 'me';
$results = $service->users_labels->listUsersLabels($user);

if (count($results->getLabels()) == 0) {
    print "No labels found.\n";
} else {
    print "Labels:\n";

    foreach ($results->getLabels() as $label) {
        printf("- %s\n", $label->getName());
    }
}
