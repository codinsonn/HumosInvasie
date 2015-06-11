<?php

require_once WWW_ROOT . 'classes' . DIRECTORY_SEPARATOR . 'DatabasePDO.php';

class CharactersDAO
{
    public $pdo;

    public function __construct()
    {
        $this->pdo = DatabasePDO::getInstance();
    }

    public function getCharacterById($id){
        $sql = "SELECT `bdgt_characters`.*, `bdgt_images`.`filename` 
                FROM `bdgt_characters` LEFT JOIN `bdgt_images` ON `bdgt_characters`.`char_img_id` = `bdgt_images`.`id` 
                WHERE `bdgt_characters`.`id` = :id";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':id', $id);

        if($qry->execute()){
            $character = $qry->fetch(PDO::FETCH_ASSOC);
            if(!empty($character)){
                return $character;
            }
        }
        return array();
    }

    public function getCharactersAfterId($latest_id){
        $sql = "SELECT `bdgt_characters`.*, `bdgt_images`.`filename` 
                FROM `bdgt_characters` LEFT JOIN `bdgt_images` ON `bdgt_characters`.`char_img_id` = `bdgt_images`.`id` 
                WHERE `bdgt_characters`.`id` > :latest_id 
                ORDER BY `bdgt_characters`.`id` DESC LIMIT 0, 5";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':latest_id', $latest_id);

        if($qry->execute()){
            $characters = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($characters)){
                return $characters;
            }
        }
        return array();
    }

    public function getCharactersByTimespan($time_ago, $time_unit){
        $sql = "SELECT `bdgt_characters`.*, `bdgt_images`.`filename` 
                FROM `bdgt_characters` LEFT JOIN `bdgt_images` ON `bdgt_characters`.`char_img_id` = `bdgt_images`.`id` 
                WHERE time_created > DATE_ADD(NOW(), INTERVAL -:time_ago MINUTE) 
                ORDER BY score DESC LIMIT 0, 5";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':time_ago', $time_ago);
        //$qry->bindValue(':time_unit', $time_unit);

        if($qry->execute()){
            $characters = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($characters)){
                return $characters;
            }
        }
        return array();
    }

    public function getPresets(){
        $sql = "SELECT * 
                FROM `bdgt_presets`";
        $qry = $this->pdo->prepare($sql);

        if($qry->execute()){
            $presets = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($presets)){
                return $presets;
            }
        }
        return array();
    }

    public function getPresetsByType($type){
        $sql = "SELECT * 
                FROM `bdgt_presets` 
                WHERE `type` = :type";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':type', $type);

        if($qry->execute()){
            $typePresets = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($typePresets)){
                return $typePresets;
            }
        }
        return array();
    }

    public function getPresetById($id){
        $sql = "SELECT * 
                FROM `bdgt_presets` 
                WHERE `id` = :id";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':id', $id);

        if($qry->execute()){
            $preset = $qry->fetch(PDO::FETCH_ASSOC);
            if(!empty($preset)){
                return $preset;
            }
        }
        return array();
    }

    public function insertCharacter($char_img_id, $nickname, $head_preset_id, $torso_preset_id, $legs_preset_id){
        $sql = "INSERT INTO bdgt_characters(char_img_id, nickname, head_preset_id, torso_preset_id, legs_preset_id)
                VALUES(:char_img_id, :nickname, :head_preset_id, :torso_preset_id, :legs_preset_id)";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':char_img_id', $char_img_id);
        $qry -> bindValue(':nickname', htmlentities(strip_tags($nickname)));
        $qry -> bindValue(':head_preset_id', $head_preset_id);
        $qry -> bindValue(':torso_preset_id', $torso_preset_id);
        $qry -> bindValue(':legs_preset_id', $legs_preset_id);

        if($qry->execute()){
            return $this -> getCharacterById($this->pdo->lastInsertId());
        }
        return array();
    }

    public function updateCharacter($id, $char_img_id, $nickname, $head_preset_id, $torso_preset_id, $legs_preset_id){
        if(empty($errors)){
            $sql = "UPDATE `bdgt_characters` 
                    SET `nickname` = ':nickname', `char_img_id` = ':char_img_id', `head_preset_id` = ':head_preset_id', `torso_preset_id` = ':torso_preset_id', `legs_preset_id` = ':legs_preset_id' 
                    WHERE `bdgt_characters`.`id` = :id";
            $qry = $this->pdo->prepare($sql);
            $qry -> bindValue(':id', $id);
            $qry -> bindValue(':char_img_id', $char_img_id);
            $qry -> bindValue(':nickname', htmlentities(strip_tags($nickname)));
            $qry -> bindValue(':head_preset_id', $head_preset_id);
            $qry -> bindValue(':torso_preset_id', $torso_preset_id);
            $qry -> bindValue(':legs_preset_id', $legs_preset_id);

            if($qry->execute()){
                return $this -> getCharacterById($id);
            }
        }
        return array();
    }

}