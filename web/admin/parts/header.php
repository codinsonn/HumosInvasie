<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Admin Panel</title>
        <?php
            $root = get_base_root();
            //echo "<base href=\"{$root}\" />";
        ?>
        <link rel="stylesheet" href="css/screen.css">
        <script src="js/jquery.js"></script>
        <script src="js/modernizr.js"></script>
        <script src="js/imagesloaded.js"></script>
        <script src="js/masonry.js"></script>
        <script src="js/app.js"></script>
    </head>
    <body>
		<div id="container">
            <?php
                if(checkIsAdmin() == true){
            ?>
            <header>
                <nav>
                    <h1>Navigatie</h1>
                    <ul>
                        <li><a <?php if($_GET['p'] == "adminpanel"){ echo "class=\"selected\""; } ?> href="index.php?p=adminpanel">Admin Panel</a></li>
                        <li><a href="index.php?p=logout">Logout</a></li>
                    </ul>
                    <a id="sideLabel" href="../index.php">View Site</a>
                </nav>
            </header>
            <?php
                }
            ?>