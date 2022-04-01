<?php
// Initialize the session
session_start();
require_once 'connection.php';
// Check if the user is logged in, if not then redirect him to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
$search = '';
if(isset($_POST['search'])){
    $search = $_POST['search'];
}
function deleteUser($user, $conn){
        $query = 'CALL LIMMdeleteUser(?)';
        if($stmt = mysqli_prepare($conn, $query)){
            mysqli_stmt_bind_param($stmt, "s", $param_user);
            
            $param_user = $user;
            if(mysqli_stmt_execute($stmt)){
                echo 'exito';
                echo "La cuenta del usuario ".$user." fue eliminada.";
                exit();
                //header("location: login.php");
            } else{
                echo "Pruebe otra vez.";
            }
            mysqli_stmt_close($stmt);
        }
        mysqli_close($conn);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Principal</title>
    <style>
        body{ font: 14px sans-serif; text-align: center; }
    </style>
</head>
<body>
    <h1 class="my-5">Bienvenido <b><?php echo htmlspecialchars($_SESSION["user"]); ?></b>.</h1>
    <h3 class="mb-5">Descripción</h3>
    <p><?php echo $_SESSION['description'] ?></p>
    <p class="d-flex justify-content-center">
        <a href="updateDescr.php" class="btn btn-primary ml-3">Cambiar descripción.</a>
        <a href="logout.php" class="btn btn-danger ml-3">Salir</a>
    </p>
    <br><br>
    <div class="container">
        <div class="card">
            <div class="header">
                <form action="index.php" method="post">
                    <div class="row mt-3">
                        <div class="col-md-4 ml-4">
                            <input class="form-control" type="text" name="search" id="search" value="<?php echo  $search; ?>" placeholder="Search by user...">
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-secondary" name="btnSearch" onclick="<?php isset($_POST['search']) ? $search=$_POST['search'] : $search = ''; ?>">Buscar</button>
                        </div>
                        <?php
                        if ($_SESSION['user']=='Luis_Isaac' && isset($_POST['search']) && $_POST['search']!='') {                        
                            echo '<div class="col-md-1">
                                <button class="btn btn-danger" name="btnDelete">Borrar</button>
                            </div>';
                            if(isset($_POST['btnDelete'])){
                                deleteUser($search, $db);
                            }
                        }
                        ?>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div id="content">
        <?php
            $query = "CALL LIMMshowUsers();";
            $dataSet = mysqli_query($db, $query);
        ?>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">User</th>
                        <th scope="col">Description</th>
                    </tr>
                </thead>
            <tbody>    
        <?php
            while($row = mysqli_fetch_assoc($dataSet)){
                echo "<tr>";
                    echo "<td>".$row['USER']."</td>";
                    echo "<td>".$row['Description']."</td>";
                echo "</tr>";
            }
        ?>
            </tbody>
            </table>
    </div>    
</body>
</html>