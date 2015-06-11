<?php
if(!empty($_SESSION['notifications'])){
	echo "<div id=\"notifications\" class=\"wideContent borderBlue clear\"><h3>Wow ! Notificaties ! :D :D</h3><ul class=\"notifications\">";
	foreach ($_SESSION['notifications'] as $notification) {
		echo "<li>{$notification}</li>";
	}
	echo "</ul></div>";
}