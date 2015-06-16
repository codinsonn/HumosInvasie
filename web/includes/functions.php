<?php

	function trace($var){
		echo "<pre>";
		print_r($var);
		echo "</pre>";
	}

	function addError($error){
		if(!isset($_SESSION["errors"])) {
			$_SESSION["errors"] = array();
		}
		$_SESSION["errors"][] = $error;
	}

	function get_base_root(){
		$local_root = "http://localhost:1124/thorr.stevens/20142015/BADGET/";
		$live_root = "http://student.howest.be/thorr.stevens/20142015/MA4/BADGET/";

		if(in_array($_SERVER["SERVER_ADDR"], array("127.0.0.1", "::1", "192.168.75.121", "fe80::21c:42ff:fe00:8"))){
		    $root = $local_root;
		}else{
			$root = $live_root;
		}

		return $root;
	}

	function checkIsAdmin(){
		$isAdmin = false;
		if(!empty($_SESSION['user']) && $_SESSION['user']['role_id'] == 2) {
			$isAdmin = true;
		}
		return $isAdmin;
	}

	function redirect($url) {
		header("Location: {$url}");
		exit();
	}

	function uploadImage($image, $uploaddir){

		$uploadfile = $uploaddir . basename($image['name']);

		if (move_uploaded_file($image['tmp_name'], $uploadfile)) {
			return $image;  
		}else{
			return array();
		}

	}

	function renderUitlaatCarouselItems($uitlaatMsgs){

		$i = 0;
		foreach ($uitlaatMsgs as $uitlaat) {

			if($i == 0){ $active = " active"; }else{ $active = ""; }

			echo "	        <div class=\"item{$active} uitlaat-wrapper\" id=\"{$i}\">";
			echo "	            <div class=\"uitlaat-container media\">";
			echo "	            	<div class=\"media-left\">";
			echo "	            		<img src=\"img/uploads/characters/".$uitlaat['character']['filename']."\">";
			echo "	            	</div>";
			echo "	            	<div class=\"media-body\">";
			echo "	            		<div class=\"message-container\">";
			echo "		            		<span class=\"triangle\"></span>";
			echo "		            		<h4>".$uitlaat['title']."</h4>";
			echo "		            		<p>".$uitlaat['message']."</p>";
			echo "		            		<footer><em>".$uitlaat['character']['nickname']."</em></footer>";
			echo "		            	</div>";
			echo "	            	</div>";
			echo "	            </div>";
			echo "	        </div>";

			$i++;

		}

	}

	function renderUitlaatCarouselIndicators($uitlaatMsgs){

		$i = 0;
		foreach ($uitlaatMsgs as $uitlaat) {

			if($i == 0){ $active = " class=\"active\""; }else{ $active = ""; }

			echo "	        <li data-target=\"#uitlaatGallery\" data-slide-to=\"{$i}\"{$active}></li>";

			$i++;

		}

	}

?>