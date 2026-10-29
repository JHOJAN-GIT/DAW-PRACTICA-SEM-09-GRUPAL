<?php
session_start();
$titulo = 'Resultado';
$mainClass = 'wide';

// 1. Solo se acepta POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    $titulo = 'Método no permitido';
    $mainClass = 'narrow';
    include 'partials/header.php';
    ?>
    <div class="card centro">
        <div class="alert alert-error">
            <h2>405 · Método no permitido</h2>
            <p>Esta página solo recibe datos enviados desde el formulario (POST).</p>
        </div>
        <a class="btn btn-ghost btn-block" href="index.html">← Ir al formulario</a>
    </div>
    <?php
    include 'partials/footer.php';
    exit;
}

// 2. Limpiar entradas
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

if ($errores) {
    http_response_code(400);
    $titulo = 'Datos inválidos';
    $mainClass = 'narrow';
    include 'partials/header.php';
    ?>
    <div class="card centro">
        <div class="alert alert-error">
            <h2>Datos inválidos</h2>
            <ul>
                <?php foreach ($errores as $e): ?>
                    <li><?= htmlspecialchars($e, ENT_QUOTES, 'UTF-8') ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <a class="btn btn-ghost btn-block" href="index.html">← Volver al formulario</a>
    </div>
    <?php
    include 'partials/footer.php';
    exit;
}

// 4. Guardar en sesión
if (!isset($_SESSION['registros'])) {
    $_SESSION['registros'] = [];
}
$_SESSION['registros'][] = ['nombre' => $nombre, 'correo' => $correo];

// 5. Respuesta con tabla
include 'partials/header.php';
$total = count($_SESSION['registros']);
?>
<div class="card">
    <h2>Registros almacenados</h2>
    <p class="sub">Los datos permanecen en la sesión mientras el navegador esté abierto.</p>

    <div class="alert alert-ok">Registro guardado correctamente.</div>

    <div class="stats">
        <div class="stat">
            <b data-count="<?= $total ?>"><?= $total ?></b>
            <span>Registros</span>
        </div>
    </div>

    <table>
        <thead>
            <tr><th>#</th><th>Nombre</th><th>Correo</th></tr>
        </thead>
        <tbody>
        <?php foreach ($_SESSION['registros'] as $i => $r): ?>
            <tr>
                <td><?= $i + 1 ?></td>
                <td><?= htmlspecialchars($r['nombre'], ENT_QUOTES, 'UTF-8') ?></td>
                <td><?= htmlspecialchars($r['correo'], ENT_QUOTES, 'UTF-8') ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>

    <br>
    <a class="btn" href="index.html">+ Agregar otro registro</a>
</div>
<?php include 'partials/footer.php'; ?>