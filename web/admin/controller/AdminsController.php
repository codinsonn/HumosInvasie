<?php
require_once WWW_ROOT . 'controller' . DS . 'AppController.php';

class AdminsController extends AppController {

	public function logout() {

		if(!empty($_SESSION['user'])){
			unset($_SESSION['user']);
			$this -> redirect("../index.php");
		}

	}

	public function login() {

		if(!empty($_POST['Login'])){
				
			if(empty($_POST['txtLogin'])){
				$this -> addError('txtLogin', "Please fill in your email adress or username.");
			}

			if(empty($_POST['txtPassword'])){
				$this -> addError('txtPassword', "Please fill in your password.");
			}

			if($this -> checkErrors() == false){
				$user = $this -> adminsDAO -> login($_POST['txtLogin'], $_POST['txtPassword']);
				if(!empty($user)){
					$_SESSION['user'] = $user;
					$this -> redirect("index.php");
					exit();
				}else{
					$this -> addError('txtPassword', "Unknown user / password combination.");
				}
			}

		}

	}

}