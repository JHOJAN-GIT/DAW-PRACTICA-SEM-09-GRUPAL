<?php
session_start();

// 1. Solo se acepta POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    exit('Método no permitido');
}

// 2. Obtener y limpiar entradas
$nombre = trim($_POST['nombre'] ?? '');
$correo = trim($_POST['correo'] ?? '');

// 3. Validar
$errores = [];
if ($nombre === '' || mb_strlen($nombre) > 100) {
    $errores[] = 'El nombre es obligatorio y no debe superar 100 caracteres.';
}
if (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
    $errores[] = 'El correo no tiene un formato válido.';
}

if (!empty($errores)) {
    http_response_code(400);
    echo '<h3>Datos inválidos</h3><ul>';
    foreach ($errores as $error) {
        echo '<li>' . htmlspecialchars($error, ENT_QUOTES, 'UTF-8') . '</li>';
    }
    echo '</ul><a href="index.html">Volver al formulario</a>';
    exit;
}

// 4. Guardar en sesión
if (!isset($_SESSION['registros'])) {
    $_SESSION['registros'] = [];
}
$_SESSION['registros'][] = ['nombre' => $nombre, 'correo' => $correo];
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado | Registro PHP</title>
</head>
<body>
    <h3>Registros almacenados</h3>
    <table border="1">
        <tr>
            <th>Nombre</th>
            <th>Correo</th>
        </tr>
        <?php foreach ($_SESSION['registros'] as $registro): ?>
        <tr>
            <td><?= htmlspecialchars($registro['nombre'], ENT_QUOTES, 'UTF-8') ?></td>
            <td><?= htmlspecialchars($registro['correo'], ENT_QUOTES, 'UTF-8') ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
    <br>
    <a href="index.html">Agregar otro registro</a>
</body>
</html>