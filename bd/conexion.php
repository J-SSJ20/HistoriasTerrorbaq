<?php
$host = "localhost";
$usuario = "root";     // Cambia si tienes otro usuario
$clave = "";           // Escribe tu contraseña de MySQL
$base_datos = "biblioteca_virtual";

$conexion = new mysqli($host, $usuario, $clave, $base_datos);

if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}
?>
