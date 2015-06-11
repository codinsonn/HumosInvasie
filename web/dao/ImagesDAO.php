<?php

require_once WWW_ROOT . 'classes' . DIRECTORY_SEPARATOR . 'DatabasePDO.php';

class ImagesDAO
{
    public $pdo;

    public function __construct()
    {
        $this->pdo = DatabasePDO::getInstance();
    }

    public function getImageById($id){
    	$sql = "SELECT * 
                FROM `bdgt_images` 
                WHERE `id` = :id";
    	$qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':id', $id);

    	if($qry -> execute()){
    		$image = $qry -> fetch(PDO::FETCH_ASSOC);
    		if(!empty($image)){
    			return $image;
    		}
    	}
    	return array();
    }

    public function insertImage($filename, $width, $height){
        $sql = "INSERT INTO bdgt_images(filename, width, height)
                VALUES(:filename, :width, :height)";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':filename', $filename);
        $qry -> bindValue(':width', $width);
        $qry -> bindValue(':height', $height);

        if($qry -> execute()){
            return $this -> getImageById($this->pdo->lastInsertId());
        }
        return array();
    }


}