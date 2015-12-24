<?php

require 'vendor/autoload.php';

$settings = [
    'settings' => [
        // Monolog
        'logger' => [
            'name' => 'inbox-hero',
            'path' => __DIR__ . '/logs/app.log',
        ],    
        // Twig
        'view' => [
            'template_path' => __DIR__ . '/templates',
            'twig' => [
                'debug' => true,
                'auto_reload' => true,
            ],
        ],
    ],
];

$app = new \Slim\App($settings);

$container = $app->getContainer();

$container['logger'] = function ($c) {
    $settings = $c->get('settings');

    $logger = new \Monolog\Logger($settings['logger']['name']);

    $logger->pushProcessor(new \Monolog\Processor\UidProcessor());
    $logger->pushHandler(new \Monolog\Handler\StreamHandler($settings['logger']['path'], \Monolog\Logger::DEBUG));

    return $logger;
};

$container['view'] = function ($c) {
    $settings = $c->get('settings');

    $view = new \Slim\Views\Twig($settings['view']['template_path'], $settings['view']['twig']);

    $view->addExtension(new Slim\Views\TwigExtension($c->get('router'), $c->get('request')->getUri()));
    $view->addExtension(new Twig_Extension_Debug());

    return $view;
};

$app->get('/', function ($request, $response, $args) {
    return $response->write("Hello");
});

$app->get('/hello/{name}', function ($request, $response, $args) {
    $logger = $this->get('logger');

    $name = $args['name'];

    $logger->addInfo("/hello/" . $name);

    return $response->write("Hello " . $name);
});

// Render the hello.html Twig template
$app->get('/hello/twig/{name}', function ($request, $response, $args) {
    $this->view->render($response, 'hello.html', [
        'name' => $args['name']        
    ]);

    return $response;
})->setName('hello-twig'); // setName gives the route a name 

$app->run();
