<?php

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
