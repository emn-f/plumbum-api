<?php
class DbConnect
{
    private $server = 'localhost';
    private $port = '3307';
    private $dbname = 'plumbum';
    private $user = 'emanuel';
    private $pass = '';

    public function connect()
    {
        try {
            $conn = new PDO('mysql:host=' . $this->server . ';port=' . $this->port . ';dbname=' . $this->dbname, $this->user, $this->pass);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $conn;
        } catch (\Exception$e) {
            echo "Database Error: " . $e->getMessage();
        }

    }
}
