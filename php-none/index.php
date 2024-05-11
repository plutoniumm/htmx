<?php
// Define routes and their corresponding content
$routes = [
    '/' => '<h1>Hello World</h1>',
    '/details' => '<h2>Foo Bar</h2>'
];

// Function to render content into template
function renderTemplate($content) {
    $template = file_get_contents('template.html');
    $output = str_replace('<body>... here</body>', '<body>' . $content . '</body>', $template);
    echo $output;
}

// Determine the requested route
$route = $_SERVER['REQUEST_URI'];

// Get content for the requested route
$content = isset($routes[$route]) ? $routes[$route] : '';

// Render content into template
renderTemplate($content);
?>
