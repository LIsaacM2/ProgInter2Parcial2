<?php

session_start();

if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
    header("location: index.php");
    exit;
}

require_once "connection.php";

$user = $password = "";
$user_err = $password_err = $login_err = "";
$key = "parcial2";

if($_SERVER["REQUEST_METHOD"] == "POST"){

    if(empty(trim($_POST["user"]))){
        $user_err = "Ingresa tu usuario.";
    } else{
        $user = trim($_POST["user"]);
    }
    
    if(empty(trim($_POST["password"]))){
        $password_err = "Ingresa tu contraseña.";
    } else{
        $password = trim($_POST["password"]);
    }
    
    if(empty($user_err) && empty($password_err)){

        $query = "CALL LIMMcheckCount(?,?)";
        
        if($stmt = mysqli_prepare($db, $query)){
            mysqli_stmt_bind_param($stmt, "ss", $param_user, $param_key);
            

            $param_user = $user;
            $param_key = $key;
            
            
            if(mysqli_stmt_execute($stmt)){
                
                mysqli_stmt_store_result($stmt);
                
                
                if(mysqli_stmt_num_rows($stmt) == 1){                    
                    // Bind result variables
                    

                    mysqli_stmt_bind_result($stmt, $id, $user, $storedPassword, $description);
                    if(mysqli_stmt_fetch($stmt)){
                        echo $storedPassword;
                        if($password == $storedPassword){
                            // Password is correct, so start a new session
                            session_start();
                            
                            // Store data in session variables
                            $_SESSION["loggedin"] = true;
                            $_SESSION["id"] = $id;
                            $_SESSION["user"] = $user;
                            $_SESSION["key"] = $key;
                            $_SESSION["description"] =$description;            
                            
                            // Redirect user to welcome page
                            header("location: index.php");
                        } else{
                            // Password is not valid, display a generic error message
                            $login_err = "Usuario o contraseña incorrectos.";
                        }
                    }
                } else{
                    // user doesn't exist, display a generic error message
                    $login_err = "Usuario o contraseña incorrectos.";
                }
            } else{
                echo "Pruebe otra vez.";
            }

            // Close statement
            mysqli_stmt_close($stmt);
        }
    }
    
    // Close connection
    mysqli_close($db);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Acceso</title>
    <style>
        body{ font: 16px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Acceso</h2>
        <?php 
        if(!empty($login_err)){
            echo '<div class="alert alert-danger">' . $login_err . '</div>';
        }        
        ?>


        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group">
                <label>User</label>
                <input type="text" name="user" class="form-control <?php echo (!empty($user_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $user; ?>">
                <span class="invalid-feedback"><?php echo $user_err; ?></span>
            </div>    
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>">
                <span class="invalid-feedback"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Acceder">
            </div>
            <p>Regístrate con nostros: <a href="signUp.php">Registrar</a>.</p>
        </form>
    </div>
</body>
</html>