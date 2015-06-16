<?php
require_once WWW_ROOT . 'controller' . DS . 'AppController.php';

class PagesController extends AppController {

	public function __construct()
	{
		require_once WWW_ROOT . 'dao' . DS . 'CharactersDAO.php';
		$this -> charactersDAO = new CharactersDAO();

		require_once WWW_ROOT . 'dao' . DS . 'UitlaatDAO.php';
		$this -> uitlaatDAO = new UitlaatDAO();
	}

	public function onepager() {

		$latestChars = $this->charactersDAO->getLatestCharacters(7);
		$this -> set('latestChars', $latestChars);

		$latestMsgs = $this->uitlaatDAO->getLatestMessages(7);
		$this -> set('uitlaatMsgs', $latestMsgs);

	}

}