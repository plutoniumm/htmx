<?php
  $route = $_SERVER['REQUEST_URI'];

  if ($route === '/') {
      $content = file_get_contents('index.html');
      echo $content;
  } else if ($route === '/details') {
      $data = [
        ['PHP', 'https://bun.sh/docs', 'https://www.php.net/images/logos/php-logo.svg'],
        ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png']
      ];

      $content = '<ul>';
      foreach ($data as $item) {
        $content .= '<li>';
          $content .= '<img src="' . $item[2] . '" />';
          $content .= '<a href="' . $item[1] . '">' . $item[0] . '</a>';
        $content .= '</li>';
      }
      $content .= '</ul>';

      echo $content;
  } else {
      http_response_code(404);
      echo '404 Not Found';
  }
?>
