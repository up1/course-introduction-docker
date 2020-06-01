<?php
$env = getenv();

$dbhost = $env['MYSQL_HOST'];
$dbuser = $env['MYSQL_USER'];
$dbpass = $env['MYSQL_PASSWORD'];
$dbname = $env['MYSQL_DATABASE'];
$dsn = "mysql:host=$dbhost;dbname=$dbname";

$pdo = new PDO($dsn,$dbuser,$dbpass);
$result = $pdo->prepare("SELECT * FROM users");
$result->execute();

header('Content-Type: application/json');
echo json_encode($result->fetchAll(),true);
?>
