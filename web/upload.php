<?php
	
	define('DS', DIRECTORY_SEPARATOR);
	define('WWW_ROOT', dirname(__FILE__) . DS);

	require_once WWW_ROOT . 'includes'. DS .'functions.php';
	require_once WWW_ROOT . 'dao'. DS .'ImagesDAO.php';

	$root = get_base_root();

	if(!empty($_FILES['picture']) && !empty($_POST) && !empty($_POST['upload_directory'])){

		$uploaddir = "img" . $_POST['upload_directory'];
		$image = uploadImage($_FILES['picture'], $uploaddir);

		if(!empty($image)){

			$imagesDAO = new ImagesDAO();

			//$image['width'] = $_POST['img_width'];
			//$image['height'] = $_POST['img_height'];

			$uplImg = $imagesDAO -> insertImage($image['name'], 568, 568);

			$responseArray = array ("code" => "1", "message" => "successfully uploaded img | filename: ".$image['name'], "img_id" => "".$uplImg['id']."");

		}else{

			$responseArray = array ("code" => "0", "message" => "Possible file upload attack! IMG: ".$_FILES['picture']['name']); 

		}

	}else{

		$responseArray = array ("code" => "0", "message" => "No picture / Possible file upload attack!");

	}

	echo json_encode ( $responseArray );

?>