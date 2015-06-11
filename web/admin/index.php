<?php

session_start();

define('DS', DIRECTORY_SEPARATOR);
define('WWW_ROOT', dirname(__FILE__) . DS);
define('UPPER_ROOT', str_replace("admin/", "", WWW_ROOT));

require_once WWW_ROOT . 'includes'. DS .'functions.php';
require_once WWW_ROOT . 'classes'. DS .'Config.php';
require_once WWW_ROOT . 'classes'. DS .'DatabasePDO.php';
require_once WWW_ROOT . 'includes'. DS .'routes.php';

if(empty($_GET['p'])) {
    $_GET['p'] = 'adminpanel';
}
if(empty($routes[$_GET['p']])) {
    header("Location: index.php");
    exit();
}

$route = $routes[$_GET['p']];
$controllerName = $route['controller'] . 'Controller';

require_once WWW_ROOT . 'controller'. DS . $controllerName . ".php";

$controllerObj = new $controllerName();
$controllerObj->route = $route;
$controllerObj->filter();
$controllerObj->render();