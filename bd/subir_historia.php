<?php
include("conexion.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_usuario = $_POST['id_usuario'];
    $titulo = $_POST['titulo'];
    $autor = $_POST['autor'];
    $descripcion = $_POST['descripcion'];
    $estado = 'pendiente';

    // Carpeta donde se guardarán los archivos PDF
    $directorio = "archivos_pdf/";

    // Crear carpeta si no existe
    if (!file_exists($directorio)) {
        mkdir($directorio, 0777, true);
    }

    // Procesar archivo subido
    $nombreArchivo = basename($_FILES["archivo_pdf"]["name"]);
    $rutaArchivo = $directorio . $nombreArchivo;

    $tipoArchivo = strtolower(pathinfo($rutaArchivo, PATHINFO_EXTENSION));

    if ($tipoArchivo != "pdf") {
        echo "<p style='color:red;'>Solo se permiten archivos PDF.</p>";
    } else {
        if (move_uploaded_file($_FILES["archivo_pdf"]["tmp_name"], $rutaArchivo)) {
            // Insertar datos en la tabla Historias
            $sql = "INSERT INTO Historias (Id_usuario, titulo, autor, descripcion, archivo_pdf, fecha_publicacion, estado)
                    VALUES (?, ?, ?, ?, ?, CURDATE(), ?)";

            $stmt = $conexion->prepare($sql);
            $stmt->bind_param("isssss", $id_usuario, $titulo, $autor, $descripcion, $nombreArchivo, $estado);

            if ($stmt->execute()) {
                echo "<p style='color:green;'>Historia subida correctamente 🎉</p>";
            } else {
                echo "<p style='color:red;'>Error al guardar en la base de datos: " . $conexion->error . "</p>";
            }
        } else {
            echo "<p style='color:red;'>Error al subir el archivo.</p>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Subir Historia</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            padding: 20px;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input, textarea, select {
            width: 100%;
            margin: 8px 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        button {
            background: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }
        button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">📚 Subir Nueva Historia</h2>

<form method="POST" enctype="multipart/form-data">
    <label>ID Usuario:</label>
    <input type="number" name="id_usuario" required>

    <label>Título:</label>
    <input type="text" name="titulo" required>

    <label>Autor:</label>
    <input type="text" name="autor" required>

    <label>Descripción:</label>
    <textarea name="descripcion" rows="4" required></textarea>

    <label>Archivo PDF:</label>
    <input type="file" name="archivo_pdf" accept="application/pdf" required>

    <button type="submit">Subir Historia</button>
</form>

</body>
</html>
