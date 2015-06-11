<?php
if(!empty($_SESSION['errors'])){
	echo "<div id=\"errors\" class=\"wideContent borderRed clear\"><h3>The following errors occurred:</h3><ul class=\"errors\">";
	foreach ($_SESSION['errors'] as $error) {
		echo "<li>{$error}</li>";
	}
	echo "</ul></div>";
}