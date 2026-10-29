<?php $mainClass = $mainClass ?? 'wide'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($titulo ?? 'Registro', ENT_QUOTES, 'UTF-8') ?> | UNCP</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="blob b1"></div>
    <div class="blob b2"></div>

    <header class="site-header">
        <div class="brand">
            <h1>Universidad Nacional del Centro del Perú<br>
                <span>Facultad de Ingeniería de Sistemas · IS093A</span></h1>
        </div>
        <span class="badge">Lab 09 · PHP</span>
    </header>

    <main class="<?= $mainClass ?>">