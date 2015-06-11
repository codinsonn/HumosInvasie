<?php
require_once WWW_ROOT . 'controller' . DS . 'AppController.php';

class PagesController extends AppController {

	public function __construct()
	{		
		$this->checkIsAdmin();
	}

	public function adminpanel() {

		if($this->checkIsAdmin() == true){

			if(!empty($_POST) && $_POST['submit'] == "Add Image Preset"){

				if(empty($_POST['lstType']) || $_POST['lstType'] == "none"){
					$this -> addError('lstType', "Please choose a preset type");
				}

				if(empty($_FILES['images']['name'][0])){
					$this -> addError('image', "Please choose a picture for this preset.");
				}else{

					$j = 0;
					$images = [];
					for($i = 0; $i < count($_FILES['images']['name']); $i++){
						$imgName = $_FILES['images']['name'][$i];
						$size = [];

						if($_FILES['images']['error'][$i] != 0){
							$this -> addError("image{$i}", "Image \"{$imgName}\" has errors. Upload aborted.");
						}

						switch($_FILES['images']['type'][$i]) {
				     		case 'image/png':
				     			$size = getimagesize($_FILES['images']['tmp_name'][$i]);
				     			if($size[0] != 568 || $size[1] != 568){
				     				$this -> addError("image{$i}", "Image \"{$imgName}\" was not 568x568px. Upload aborted.");
				     			}
				     			break;
				     		default:
				     			$this -> addError("image{$i}", "File \"{$imgName}\" was not a png image. Upload aborted.");
				     			break;
				     	}

				     	if($this -> checkError("image{$i}") == false){
				     		$images[$j]['name'] = $imgName;
				     		$images[$j]['type'] = $_FILES['images']['type'][$i];
				     		$images[$j]['width'] = $size[0];
				     		$images[$j]['height'] = $size[1];
				     		$images[$j]['tmp_name'] = $_FILES['images']['tmp_name'][$i];
				     		$j++;
				     	}
					}

				}

				if($this -> checkErrors() == false){

					require_once WWW_ROOT . 'dao' . DS . 'PresetsDAO.php';
					$this -> presetsDAO = new PresetsDAO();

					$uploaddir = UPPER_ROOT."img/presets/";
					$image = uploadImage($images[0], $uploaddir);

					$this -> presetsDAO -> addPreset($image['name'], $_POST['lstType']);

					$this -> addNotification('image', "{$_POST['lstType']} preset added.");
					//redirect(WWW_ROOT);

				}

			}			
			
		}else{
			$this->redirect('index.php?p=login');
		}

	}

}