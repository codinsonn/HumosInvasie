<?php

require_once WWW_ROOT . 'classes' . DIRECTORY_SEPARATOR . 'DatabasePDO.php';
require_once WWW_ROOT . 'dao' . DIRECTORY_SEPARATOR . 'CharactersDAO.php';

class UitlaatDAO
{
    public $pdo;

    public function __construct()
    {
        $this->pdo = DatabasePDO::getInstance();
        $this->charactersDAO = new CharactersDAO();
    }

    public function getMessageById($id){
        $sql = "SELECT * FROM `bdgt_uitlaat`
                WHERE `id` = :id";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':id', $id);

        if($qry->execute()){
            $message = $qry->fetch(PDO::FETCH_ASSOC);
            if(!empty($message)){
                return $message;
            }
        }
        return array();
    }

    public function getLatestMessages($rows){
        $sql = "SELECT * FROM `bdgt_uitlaat` 
                ORDER BY id DESC
                LIMIT :rows";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':rows', $rows);

        if($qry->execute()){
            $messages = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($messages)){
                $messages = $this -> getMessageCharacters($messages);
                return $messages;
            }
        }
        return array();
    }

    public function getMessageCharacters($messages){
        $i = 0;

        foreach($messages as $message){
            $message = $this -> getMessageCharacter($message);
            $messages[$i] = $message;
            $i++;
        }

        return $messages;
    }

    public function getMessageCharacter($message){
        $message['character'] = $this -> charactersDAO -> getCharacterById($message['character_id']);

        return $message;
    }

    public function getMessagesByTimespanAndLocation($time_ago, $time_unit, $min_lat, $max_lat, $min_long, $max_long, $last_swiped_id){
        $sql = "SELECT * FROM `bdgt_uitlaat` 
                WHERE time_posted > DATE_ADD(NOW(), INTERVAL -:time_ago HOUR) 
                AND latitude > :min_lat 
                AND latitude < :max_lat 
                AND longitude > :min_long 
                AND longitude < :max_long 
                AND id > :last_swiped_id 
                ORDER BY time_posted ASC";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':time_ago', $time_ago);
        $qry->bindValue(':min_lat', $min_lat);
        $qry->bindValue(':max_lat', $max_lat);
        $qry->bindValue(':min_long', $min_long);
        $qry->bindValue(':max_long', $max_long);
        $qry->bindValue(':last_swiped_id', $last_swiped_id);

        if($qry->execute()){
            $messages = $qry->fetchAll(PDO::FETCH_ASSOC);
            if(!empty($messages)){
                $messages = $this -> getMessageCharacters($messages);
                return $messages;
            }
        }
        return array();
    }

    public function insertMessage($character_id, $title, $message, $latitude, $longitude){
        $sql = "INSERT INTO bdgt_uitlaat(character_id, title, message, latitude, longitude, time_posted)
                VALUES(:character_id, :title, :message, :latitude, :longitude, :time_posted)";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':character_id', $character_id);
        $qry -> bindValue(':title', htmlentities(strip_tags($title)));
        $qry -> bindValue(':message', htmlentities(strip_tags($message)));
        $qry -> bindValue(':latitude', $latitude);
        $qry -> bindValue(':longitude', $longitude);
        $qry -> bindValue(':time_posted', date("Y-m-d H:i:s"));

        if($qry->execute()){
            return $this -> getMessageById($this->pdo->lastInsertId());
        }
        return array();
    }

}