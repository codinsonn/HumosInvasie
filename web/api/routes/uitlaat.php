<?php

$uitlaatDAO = new UitlaatDAO();

// --- Getters --------------------------
$app->get('/uitlaat/filter/hours/:hours_ago/min_lat/:min_lat/max_lat/:max_lat/min_long/:min_long/max_long/:max_long/last_swiped_id/:last_swiped_id/?',function($hours_ago, $min_lat, $max_lat, $min_long, $max_long, $last_swiped_id) use ($uitlaatDAO){
    header("Content-Type: application/json");
    echo json_encode($uitlaatDAO->getMessagesByTimespanAndLocation($hours_ago, "HOUR", $min_lat, $max_lat, $min_long, $max_long, $last_swiped_id), JSON_NUMERIC_CHECK);
    exit();
});

$app->get('/uitlaat/:id/?', function($id) use ($uitlaatDAO){
    header("Content-Type: application/json");
    echo json_encode($uitlaatDAO->getMessageById($id), JSON_NUMERIC_CHECK);
    exit();
});

// --- Setters --------------------------
$app->post('/uitlaat/?', function() use ($app, $uitlaatDAO){
    header("Content-Type: application/json");
    $post = $app->request->post();
    if(empty($post)){
        $post = (array) json_decode($app->request()->getBody());
    }
    echo json_encode($uitlaatDAO->insertMessage($post['character_id'], $post['title'], $post['message'], $post['latitude'], $post['longitude']), JSON_NUMERIC_CHECK);
    exit();
});

