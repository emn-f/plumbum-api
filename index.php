<?php

declare(strict_types = 1)
header( header: 'Access-Control-Allow-Origin: http://localhost:3000/cadastro');
header( header: 'Access-Control-Allow-Headers: content-typee');
header( header: 'Access-Control-Allow-Methods: POST');

include 'DbConnect.php';
$objDb = new DbConnect;
$conn = $objDb->connect();

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
    case 'POST':
        $user = json_decode( file_get_contents('php://input') );
        $sql = 'INSERT INTO usuarios(user_dtcadastro, user_nome, user_email, user_senha, user_tipo) VALUES(:user_dtcadastro, :user_nome, :user_email, :user_senha, :user_tipo)';
        $stmt = $conn->prepare($sql);
        $dataCreated = date('d-m-Y');
        $stmt->bindParam(':user_dtcadastro', $dataCreated);
        $stmt->bindParam(':user_nome', $user->user_nome);
        $stmt->bindParam(':user_email', $user->user_email);
        $stmt->bindParam(':user_senha', $user->user_senha);
        $stmt->bindParam(':user_tipo', $user->user_tipo);
        if ($stmt->execute()) {
            $response = ['status' => 1, 'message' => 'Funcionou :D'];
        } else {
            $response = ['status' => 0, 'message' => 'x('];
        }
        echo json_encode($response);
        break;
};

