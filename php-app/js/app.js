document.addEventListener("DOMContentLoaded", () => {

    // Contador animado en las estadísticas
    document.querySelectorAll("[data-count]").forEach(el => {
        const destino = parseInt(el.dataset.count, 10) || 0;
        let actual = 0;
        const paso = Math.max(1, Math.ceil(destino / 30));
        const timer = setInterval(() => {
            actual += paso;
            if (actual >= destino) {
                actual = destino;
                clearInterval(timer);
            }
            el.textContent = actual;
        }, 30);
    });

    // Botón en estado "enviando" (solo si el formulario pasa la validación del navegador)
    const form = document.querySelector("form.contact-form");
    if (form) {
        form.addEventListener("submit", () => {
            const btn = form.querySelector("button[type=submit]");
            btn.disabled = true;
            btn.textContent = "Enviando...";
        });
    }

    // Efecto de onda al hacer clic en botones
    document.querySelectorAll(".btn").forEach(btn => {
        btn.addEventListener("click", e => {
            const r = document.createElement("span");
            const size = Math.max(btn.offsetWidth, btn.offsetHeight);
            r.style.cssText = `position:absolute;border-radius:50%;background:rgba(255,255,255,.5);
                width:${size}px;height:${size}px;left:${e.offsetX - size / 2}px;top:${e.offsetY - size / 2}px;
                transform:scale(0);animation:ripple .6s linear;pointer-events:none;`;
            btn.appendChild(r);
            setTimeout(() => r.remove(), 600);
        });
    });
});

// Animación del efecto de onda
const style = document.createElement("style");
style.textContent = "@keyframes ripple{to{transform:scale(4);opacity:0}}";
document.head.appendChild(style);