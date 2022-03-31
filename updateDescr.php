<?php
// Initialize the session
session_start();

// Check if the user is logged in, otherwise redirect to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}

// Include config file
require_once "connection.php";

// Define variables and initialize with empty values
$new_description = "";
$new_description_err="";
// Processing form data when form is submitted
if($_SERVER["REQUEST_METHOD"] == "POST"){

    // Validate new description
    if(empty(trim($_POST["new_description"]))){
        $new_description = "";     
    } elseif(strlen(trim($_POST["new_description"])) > 500){
        $new_description_err = "Introduce una descripción de al menos 200 caracteres.";
    } else{
        $new_description = trim($_POST["new_description"]);
    }
        
    // Check input errors before updating the database
    if(empty($new_description_err)){
        // Prepare an update statement
        $sql = "CALL LIMMupdateDesc(?, ?)";
        
        if($stmt = mysqli_prepare($db, $sql)){
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "si", $param_description, $param_id);
            // Set parameters
            $param_description = $new_description;
            $param_id = $_SESSION["id"];
            
            // Attempt to execute the prepared statement
            if(mysqli_stmt_execute($stmt)){
                // description updated successfully. Destroy the session, and redirect to login page
                header("location: index.php");
                exit();
            } else{
                echo "Prueba otra vez.";
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
    <title>Cambio de descripción</title>
    <style>
        body{ font: 14px sans-serif; }
        .wrapper{ width: 360px; padding: 20px; }
    </style>
</head>
<body>
    <div class="wrapper">
        <h2>Cambio de descripción</h2>
        <p>Cuéntanos un poco sobre ti.</p>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post"> 
            <div class="form-group">
                <textarea name="new_description" class="form-control <?php echo (!empty($new_description_err)) ? 'is-invalid' : ''; ?>" value="<?php echo $new_description; ?>"></textarea>
                <span class="invalid-feedback"><?php echo $new_description_err; ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Cambiar">
                <a class="btn btn-primary" href="index.php">Cancelar</a>
            </div>
        </form>
    </div>    
</body>
</html>