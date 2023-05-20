<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
header('Access—Control—Allow-Credentials: true');

include 'DbConnect.php';
$objDb = new DbConnect;
$conn = $objDb->connect();

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
    case 'POST':
        $user = json_decode( file_get_contents('php://input') );
        $sql = 'INSERT INTO usuarios(dt_cadastro, nome, email, senha, tipo) VALUES(:dt_cadastro, :nome, :email, :senha, :tipo)';
        $stmt = $conn->prepare($sql);
        $dataCreated = date('d-m-Y');
        $stmt->bindParam(':dt_cadastro', $dataCreated);
        $stmt->bindParam(':nome', $user->nome);
        $stmt->bindParam(':email', $user->email);
        $stmt->bindParam(':senha', $user->senha);
        $stmt->bindParam(':tipo', $user->tipo);
        if ($stmt->execute()) {
            $response = ['status' => 1, 'message' => 'Funcionou :D'];
        } else {
            $response = ['status' => 0, 'message' => 'x('];
        }
        echo json_encode($response);
        break;
};

