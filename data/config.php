<?php
Setting('MODE', 'production');
Setting('DEFAULT_LOCALE', 'en');
Setting('CURRENCY', 'USD');
Setting('ENERGY_UNIT', 'kcal');

// Render runs Grocy at the domain root with rewrites enabled
Setting('DISABLE_URL_REWRITING', false);
Setting('BASE_URL', '/public');
Setting('BASE_PATH', '/public');

// Database (SQLite)
return [
    'dbConnection' => [
        'driver' => 'sqlite',
        'database' => '/var/data/grocy.db',
    ],
];
