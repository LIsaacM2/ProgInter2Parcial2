<?php
require_once "connection.php";

$user = $password = $confirm_password = "";
$user_err = $password_err = $confirm_password_err = "";
$encryption_key = "parcial2";

if($_SERVER["REQUEST_METHOD"] == "POST"){

    if(empty(trim($_POST["user"]))){
        $user_err = "Introduce un usuario.";
    } elseif(!preg_match('/^[a-zA-Z0-9_]+$/', trim($_POST["user"]))){
        $user_err = "El usuario puede contener letras, números y/o guiones bajos.";
    } else{

        $sql = "CALL LIMMuserExist(?)";
        
        if($stmt = mysqli_prepare($db, $sql)){

            mysqli_stmt_bind_param($stmt, "s", $param_user);
            

            $param_user = trim($_POST["user"]);
            

            if(mysqli_stmt_execute($stmt)){

                mysqli_stmt_store_result($stmt);
                
                if(mysqli_stmt_num_rows($stmt) == 1){
                    $user_err = "Este usuario ya existe.";
                } else{
                    $user = trim($_POST["user"]);
                }
            } else{
                echo "Prueba otra vez.";
            }
            mysqli_stmt_close($stmt);
        }
    }
    
    // Validate password
    if(empty(trim($_POST["password"]))){
        $password_err = "Introduce una contraseña.";     
    } elseif(strlen(trim($_POST["password"])) < 8){
        $password_err = "La contraseña deberá tener +8 caracteres.";
    } else{
        $password = trim($_POST["password"]);
    }
    
    // Validate confirm password
    if(empty(trim($_POST["confirm_password"]))){
        $confirm_password_err = "Confirma la contraseña.";     
    } else{
        $confirm_password = trim($_POST["confirm_password"]);
        if(empty($password_err) && ($password != $confirm_password)){
            $confirm_password_err = "Las contraseñas no coinciden.";
        }
    }
    
    // Check input errors before inserting in database
    if(empty($user_err) && empty($password_err) && empty($confirm_password_err)){
        
        // Prepare an insert statement
        $sql = "CALL LIMMsignUp(?, ?, ?)";

        if($stmt = mysqli_prepare($db, $sql)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "sss", $param_user, $param_password, $param_encryption_key);
            
            // Set parameters
            $param_user = $user;
            $param_password = $password;
            $param_encryption_key = $encryption_key;
            
            if(mysqli_stmt_execute($stmt)){

                header("location: login.php");
            } else{
                echo "Prueba otra vez.";
            }


            mysqli_stmt_close($stmt);
        }
    }
    mysqli_close($db);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Registro</h2>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group">
                <label>User</label>
                <input placeholder="Letras, números y/o guiones bajos." type="text" name="user" class="form-control <?php echo (!empty($user_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $user; ?>">
                <span class="invalid-feedback"><?php echo $user_err; ?></span>
            </div>    
            <div class="form-group">
                <label>Password</label>
                <input placeholder="Contener al menos 8 caracteres." type="password" name="password" class="form-control <?php echo (!empty($password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $password; ?>">
                <span class="invalid-feedback"><?php echo $password_err; ?></span>
            </div>
            <div class="form-group">
                <label>Confirma Password</label>
                <input placeholder="Asegúrate de introducir exacto." type="password" name="confirm_password" class="form-control <?php echo (!empty($confirm_password_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $confirm_password; ?>">
                <span class="invalid-feedback"><?php echo $confirm_password_err; ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Registrar">
            </div>
        </form>
    </div>    
</body>
</html>