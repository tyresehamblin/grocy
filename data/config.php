<?php
Setting('MODE', 'production');
Setting('DEFAULT_LOCALE', 'en');
Setting('CURRENCY', 'USD');
Setting('ENERGY_UNIT', 'kcal');

// Render runs Grocy at the domain root with rewrites enabled
Setting('DISABLE_URL_REWRITING', false);
Setting('BASE_URL', '/');
Setting('BASE_PATH', '');

// Database (SQLite)
return [
    'dbConnection' => [
        'driver' => 'sqlite',
        'database' => '/var/data/grocy.db',
    ],
];
