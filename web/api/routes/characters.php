<?php

$charactersDAO = new CharactersDAO();
$imagesDAO = new ImagesDAO();

// --- Getters --------------------------
$app->get('/characters/filter/seconds/:seconds_ago/?',function($seconds_ago) use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getCharactersByTimespan($seconds_ago, "SECOND"), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/characters/filter/id/:latest_id/?',function($latest_id) use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getCharactersAfterId($latest_id), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/characters/:id/?', function($id) use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getCharacterById($id), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/presets/?', function() use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getPresets(), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/presets/:id/?', function($id) use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getPresetById($id), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/presets/type/:type/?', function($type) use ($charactersDAO){
    header("Content-Type: application/json");
    echo json_encode($charactersDAO->getPresetsByType($type), JSON_NUMERIC_CHECK);
    exit();
});

// --- Setters --------------------------
$app->post('/characters/?', function() use ($app, $charactersDAO, $imagesDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }

    echo json_encode($charactersDAO->insertCharacter($post['char_img_id'], $post['nickname'], $post['head_preset_id'], $post['upper_body_preset_id'], $post['lower_body_preset_id']), JSON_NUMERIC_CHECK);
    exit();
});

$app->put('/characters/:id/?', function($id) use ($app, $charactersDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }
    echo json_encode($charactersDAO->updateCharacter($id, $post['char_img_id'], $post['nickname'], $post['head_preset_id'], $post['upper_body_preset_id'], $post['lower_body_preset_id']), JSON_NUMERIC_CHECK);
    exit();
});

