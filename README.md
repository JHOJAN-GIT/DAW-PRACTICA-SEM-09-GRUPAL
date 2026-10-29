# Sistema de Registro de Contacto - Lab 09 (IS093A)

Práctica grupal de Desarrollo de Aplicaciones Web: implementación del mismo formulario de registro en **PHP** (XAMPP) y **JSP** (Tomcat).

**Integrantes:** [Nombre 1 - código], [Nombre 2 - código]

## Estructura del proyecto

```
DAW-PRACTICA-SEM-09-GRUPAL/
├── php-app/
│   ├── index.html
│   └── procesar.php
├── jsp-app/
│   ├── index.jsp
│   ├── procesar.jsp
│   ├── error.jsp
│   └── WEB-INF/web.xml
└── README.md
```

## Requisitos

- XAMPP (Apache + PHP 8.x)
- JDK 17
- Apache Tomcat 10.1

## Ejecución

**PHP:** copiar `php-app` a `C:\xampp\htdocs\` e iniciar Apache. Abrir `http://localhost/php-app/index.html`.

**JSP:** copiar `jsp-app` a `C:\apache-tomcat-10.1.x\webapps\` e iniciar Tomcat. Abrir `http://localhost:8080/jsp-app/`.

## Ciclo HTTP

```
 Cliente (navegador)
   │ 1. Escribe URL: http://localhost/php-app/index.html
   ▼
 DNS ──► localhost resuelve a 127.0.0.1
   │
   ▼
 TCP/IP ──► Conexión (handshake de 3 vías) al puerto 80 u 8080
   │
   ▼
 HTTP Request ──► POST /php-app/procesar.php  (nombre, correo)
   │
   ▼
 Servidor web (Apache / Tomcat) ──► Enruta a PHP o JSP
   │
   ▼
 Backend ──► Valida, sanitiza, guarda en $_SESSION / session
   │
   ▼
 HTTP Response ──► 200 OK (tabla)  |  400 / 405 / 500
   │
   ▼
 Render ──► El navegador interpreta el HTML y muestra la tabla
```

## Matriz comparativa PHP vs JSP

| Criterio | PHP | JSP |
|---|---|---|
| Ciclo de vida | Cada petición arranca el script desde cero y termina al responder | Se compila a servlet una vez; el contenedor reutiliza la instancia |
| Despliegue | Copiar archivos en `htdocs`; no requiere compilación | Empaquetar en `webapps` de Tomcat; requiere JDK y servidor de aplicaciones |
| Gestión de estado | `$_SESSION` con `session_start()` | `HttpSession` con `request.getSession()` |
| Rendimiento | Muy rápido para sitios de tamaño medio y carga web clásica | Mayor consumo inicial de memoria; muy estable bajo carga alta y concurrencia |
| Seguridad | `htmlspecialchars`, `filter_var`, `$_SERVER['REQUEST_METHOD']` | Escape propio o `<c:out>`, `request.getMethod()`, `error-page` en `web.xml` |
| Madurez del ecosistema | Amplio, ideal para CMS y hosting compartido | Empresarial, con Spring y estándares Jakarta EE |

## Capturas

- Logs de Tomcat / Apache: [captura]
- Respuestas HTTP (código 200, 400, 405): [captura]
- Estructura de carpetas: [captura]
- Sistema funcionando en PHP: [captura]
- Sistema funcionando en JSP: [captura]

## Seguridad aplicada

- Validación de método POST (405 si no lo es)
- Validación de datos y mensajes de error (400)
- Sanitización de entradas con `trim` y escape de salida con `htmlspecialchars` / `esc()`
- Páginas de error personalizadas en JSP (`web.xml`)