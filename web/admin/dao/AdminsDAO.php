<?php

require_once WWW_ROOT . 'classes' . DIRECTORY_SEPARATOR . 'DatabasePDO.php';

class AdminsDAO
{
    public $pdo;

    public function __construct()
    {
        $this->pdo = DatabasePDO::getInstance();
    }

    public function login($entry, $password){
        return $this -> getAdmin($entry, $password);
    }

    public function getAdmin($entry, $password){
        $sql = "SELECT * 
                FROM `bdgt_admins` 
                WHERE (email = :entry1
                OR username = :entry2)
                AND password = :password";
        $qry = $this->pdo->prepare($sql);
        $qry -> bindValue(':entry1', $entry);
        $qry -> bindValue(':entry2', $entry);
        $qry -> bindValue(':password', sha1(CONFIG::SALT.$password));

        if($qry->execute()){
            $admin = $qry->fetch(PDO::FETCH_ASSOC);
            if(!empty($admin)){
                return $admin;
            }
        }
        return array();
    }

    public function getAdminById($id){
        $sql = "SELECT *
                FROM `bdgt_admins`
                WHERE `id` = :id";
        $qry = $this->pdo->prepare($sql);
        $qry->bindValue(':id', $id);

        if($qry->execute()){
            $admin = $qry->fetch(PDO::FETCH_ASSOC);
            if(!empty($admin)){
                return $admin;
            }
        }
        return array();
    }

}