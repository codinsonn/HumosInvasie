<?php

require_once WWW_ROOT . 'classes' . DIRECTORY_SEPARATOR . 'DatabasePDO.php';

class PresetsDAO
{
    public $pdo;

    public function __construct()
    {
        $this->pdo = DatabasePDO::getInstance();
    }

    public function addPreset($filename, $type){
    	$sql = "INSERT INTO bdgt_presets(filename, type)
                VALUES(:filename, :type)";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':filename', $filename);
        $qry -> bindValue(':type', $type);

        if($qry -> execute()){
            return $this->pdo->lastInsertId();
        }
        return array();
    }

    public function removeImage($preset_id){
        $sql = "DELETE FROM bdgt_presets
                WHERE id = :preset_id";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(":preset_id", $preset_id);

        if($qry -> execute()){
            return true;
        }
        return false;
    }

}