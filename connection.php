<?php
    $server = 'developeros.com.mx';
    $user = 'develop7_ulsa_a';
    $pass = 'r00tUls@';
    $database = 'develop7_ulsa';
    $db = mysqli_connect($server,$user,$pass,$database);

    if($db === false){
        die("ERROR: Could not connect. " . mysqli_connect_error());
    }
?>