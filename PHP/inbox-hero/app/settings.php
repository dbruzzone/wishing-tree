<?php

return [
    'settings' => [
        // Monolog
        'logger' => [
            'name' => 'inbox-hero',
            'path' => __DIR__ . '/../logs/app.log',
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
