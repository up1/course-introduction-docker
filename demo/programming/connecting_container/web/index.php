<?php
// phpinfo();
try {
    $user = "root";
    $password = "123456";
    $dbh = new PDO('mysql:host=mydb;dbname=demo', $user, $password);
    print "Create database connection successfully.";
    $dbh = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
}
?>
