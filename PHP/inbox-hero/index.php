<?php

require 'vendor/autoload.php';

$settings = require __DIR__ . '/app/settings.php';

$app = new \Slim\App($settings);

// The dependency container
require __DIR__ . '/app/dependencies.php';

// Routes
require __DIR__ . '/app/routes.php';

$app->run();
