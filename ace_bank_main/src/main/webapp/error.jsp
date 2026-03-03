<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${errorTitle} | AceBank</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:       #080c14;
            --bg2:      #0d1220;
            --bg3:      #111827;
            --surface:  rgba(255,255,255,0.04);
            --surface2: rgba(255,255,255,0.07);
            --border:   rgba(255,255,255,0.08);
            --glow:     rgba(0,212,170,0.3);
            --cyan:     #00d4aa;
            --cyan-dim: #00a882;
            --cyan-bg:  rgba(0,212,170,0.08);
            --red:      #ff4757;
            --txt:      #edf2f7;
            --txt2:     #8892a4;
            --txt3:     #4a5568;
            --font: 'Outfit', sans-serif;
            --mono: 'JetBrains Mono', monospace;
            --ease: cubic-bezier(0.4,0,0.2,1);
            --spring: cubic-bezier(0.34,1.56,0.64,1);
        }
        *,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
        html { height:100%; }
        body {
            font-family:var(--font); background:var(--bg);
            color:var(--txt); min-height:100vh;
            overflow:hidden; -webkit-font-smoothing:antialiased;
            display:flex; flex-direction:column;
        }
        body::before {
            content:''; position:fixed; inset:0;
            background-image:
                linear-gradient(rgba(0,212,170,0.025) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,212,170,0.025) 1px, transparent 1px);
            background-size:64px 64px;
            pointer-events:none; z-index:0;
        }
        /* Radial glow center */
        body::after {
            content:''; position:fixed;
            top:50%; left:50%; transform:translate(-50%,-50%);
            width:700px; height:700px; border-radius:50%;
            background:radial-gradient(circle, rgba(255,71,87,0.07) 0%, transparent 65%);
            pointer-events:none; z-index:0;
        }
        a { text-decoration:none; color:inherit; }
        ::selection { background:rgba(0,212,170,0.2); color:var(--cyan); }

        /* ── HEADER ── */
        header {
            position:relative; z-index:100;
            height:68px; padding:0 2.5rem;
            display:flex; align-items:center;
            backdrop-filter:blur(20px);
            background:rgba(8,12,20,0.75);
            border-bottom:1px solid var(--border);
        }
        .logo {
            font-size:1.55rem; font-weight:800; letter-spacing:-0.045em;
            display:flex; align-items:center;
        }
        .logo-a { color:var(--txt); }
        .logo-b {
            background:linear-gradient(135deg,var(--cyan),#6366f1);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }

        /* ── MAIN ── */
        .error-page {
            flex:1; display:flex; align-items:center; justify-content:center;
            padding:2rem; position:relative; z-index:1;
        }

        .error-box {
            text-align:center; max-width:560px; width:100%;
            animation:pageIn 0.7s var(--spring) both;
        }

        /* Glitch code */
        .error-code-wrap { position:relative; display:inline-block; margin-bottom:0.5rem; }

        .error-code {
            font-family:var(--mono); font-weight:700;
            font-size:clamp(7rem, 22vw, 13rem); line-height:1;
            letter-spacing:-0.06em;
            color:transparent;
            -webkit-text-stroke:2px rgba(255,71,87,0.25);
            position:relative;
            display:block;
        }

        /* Layered gradient fill */
        .error-code::before {
            content:attr(data-code);
            position:absolute; inset:0;
            background:linear-gradient(160deg, #ff6b7a 0%, var(--red) 40%, #c0392b 100%);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
            animation:glitch1 4s infinite;
        }
        .error-code::after {
            content:attr(data-code);
            position:absolute; inset:0;
            background:linear-gradient(160deg, rgba(0,212,170,0.6), rgba(0,212,170,0.2));
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
            animation:glitch2 4s infinite;
            mix-blend-mode:screen;
        }

        /* Reflection */
        .error-code-reflection {
            font-family:var(--mono); font-weight:700;
            font-size:clamp(7rem, 22vw, 13rem); line-height:1;
            letter-spacing:-0.06em; display:block;
            background:linear-gradient(160deg, rgba(255,71,87,0.12) 0%, transparent 60%);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
            transform:scaleY(-1) translateY(2%);
            mask-image:linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, transparent 60%);
            -webkit-mask-image:linear-gradient(to bottom, rgba(0,0,0,0.3) 0%, transparent 60%);
            margin-top:-20px; pointer-events:none;
        }

        .error-divider {
            width:60px; height:3px; border-radius:99px; margin:1.5rem auto;
            background:linear-gradient(90deg, var(--red), rgba(255,71,87,0.1));
        }

        .error-title {
            font-size:clamp(1.4rem, 3.5vw, 2rem);
            font-weight:800; letter-spacing:-0.03em;
            margin-bottom:0.75rem;
        }

        .error-msg {
            font-size:1rem; color:var(--txt2); line-height:1.7;
            margin-bottom:2.5rem; max-width:420px; margin-left:auto; margin-right:auto;
        }

        /* Metadata chip */
        .error-meta {
            display:inline-flex; align-items:center; gap:0.6rem;
            font-family:var(--mono); font-size:0.72rem; color:var(--txt3);
            background:var(--surface); border:1px solid var(--border);
            padding:0.4rem 1rem; border-radius:99px; margin-bottom:2rem;
        }
        .meta-dot { width:6px; height:6px; border-radius:50%; background:var(--red); animation:pulse 2s ease-in-out infinite; }

        /* Actions */
        .error-actions { display:flex; gap:1rem; justify-content:center; flex-wrap:wrap; }

        .btn-primary {
            font-family:var(--font); font-size:0.95rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.85rem 1.9rem; border-radius:12px;
            cursor:pointer; transition:all 0.25s var(--spring);
            display:inline-flex; align-items:center; gap:0.5rem;
            position:relative; overflow:hidden;
        }
        .btn-primary:hover { transform:translateY(-3px); box-shadow:0 14px 36px rgba(0,212,170,0.4); }
        .btn-primary:active { transform:translateY(-1px); }
        .btn-ico { transition:transform 0.25s var(--spring); }
        .btn-primary:hover .btn-ico { transform:translateX(4px); }

        .btn-ghost {
            font-family:var(--font); font-size:0.95rem; font-weight:600;
            color:var(--txt); background:transparent;
            border:1px solid var(--border);
            padding:0.85rem 1.7rem; border-radius:12px;
            cursor:pointer; transition:all 0.25s var(--ease);
            display:inline-flex; align-items:center; gap:0.5rem;
        }
        .btn-ghost:hover { border-color:var(--glow); color:var(--cyan); background:var(--cyan-bg); transform:translateY(-2px); }

        /* Particles canvas */
        #particleCanvas {
            position:fixed; inset:0; pointer-events:none; z-index:0;
        }

        /* ── ANIMATIONS ── */
        @keyframes pageIn {
            from { opacity:0; transform:translateY(30px) scale(0.96); }
            to { opacity:1; transform:translateY(0) scale(1); }
        }
        @keyframes glitch1 {
            0%,90%,100% { transform:translate(0,0); clip-path:none; }
            91% { transform:translate(-3px,1px); clip-path:polygon(0 20%, 100% 20%, 100% 45%, 0 45%); }
            93% { transform:translate(3px,-1px); clip-path:polygon(0 60%, 100% 60%, 100% 80%, 0 80%); }
            95% { transform:translate(0,0); clip-path:none; }
        }
        @keyframes glitch2 {
            0%,87%,100% { transform:translate(0,0); opacity:0.6; clip-path:none; }
            88% { transform:translate(4px,2px); clip-path:polygon(0 40%, 100% 40%, 100% 65%, 0 65%); opacity:0.8; }
            90% { transform:translate(-2px,0); clip-path:polygon(0 10%, 100% 10%, 100% 30%, 0 30%); opacity:0.5; }
            92% { transform:translate(0,0); clip-path:none; opacity:0.6; }
        }
        @keyframes pulse {
            0%,100% { opacity:1; transform:scale(1); }
            50% { opacity:0.4; transform:scale(0.7); }
        }
        @keyframes rippleOut { to { transform:scale(1); opacity:0; } }

        @media (max-width:480px) {
            header { padding:0 1rem; }
            .error-actions { flex-direction:column; align-items:center; }
        }
    </style>
</head>
<body>

<canvas id="particleCanvas"></canvas>

<!-- ══ HEADER ══ -->
<header>
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
        <span class="logo-a">Ace</span><span class="logo-b">Bank</span>
    </a>
</header>

<!-- ══ ERROR ══ -->
<div class="error-page">
    <div class="error-box">

        <div class="error-code-wrap">
            <span class="error-code" data-code="${errorCode}">${errorCode}</span>
            <span class="error-code-reflection" aria-hidden="true">${errorCode}</span>
        </div>

        <div class="error-divider"></div>

        <div class="error-meta">
            <span class="meta-dot"></span>
            Error code ${errorCode} — ${errorTitle}
        </div>

        <h1 class="error-title">${errorTitle}</h1>
        <p class="error-msg">${errorMessage}</p>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/home" class="btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
                Return to Dashboard
                <svg class="btn-ico" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </a>
            <button class="btn-ghost" onclick="history.back()">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M19 12H5M12 19l-7-7 7-7"/></svg>
                Go Back
            </button>
        </div>

    </div>
</div>

<script>
// ── Particle system ──
const canvas = document.getElementById('particleCanvas');
const ctx = canvas.getContext('2d');
let particles = [];

function resize() {
    canvas.width = innerWidth;
    canvas.height = innerHeight;
}
resize();
window.addEventListener('resize', resize);

function spawnParticle() {
    const colors = ['rgba(255,71,87,', 'rgba(0,212,170,', 'rgba(255,165,0,'];
    const col = colors[Math.floor(Math.random()*colors.length)];
    return {
        x: Math.random() * canvas.width,
        y: canvas.height + 10,
        size: Math.random() * 2 + 0.5,
        speed: Math.random() * 0.8 + 0.3,
        drift: (Math.random() - 0.5) * 0.4,
        opacity: Math.random() * 0.4 + 0.1,
        color: col,
        life: 1,
    };
}

for (let i = 0; i < 40; i++) {
    const p = spawnParticle();
    p.y = Math.random() * canvas.height;
    particles.push(p);
}

function animParticles() {
    ctx.clearRect(0,0,canvas.width,canvas.height);
    particles.forEach((p, i) => {
        p.y -= p.speed;
        p.x += p.drift;
        p.life -= 0.003;
        if (p.y < -20 || p.life <= 0) { particles[i] = spawnParticle(); return; }
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.size, 0, Math.PI*2);
        ctx.fillStyle = p.color + (p.opacity * p.life) + ')';
        ctx.fill();
    });
    requestAnimationFrame(animParticles);
}
animParticles();

// Occasionally spawn burst
setInterval(() => {
    for (let i = 0; i < 3; i++) particles.push(spawnParticle());
}, 800);

// ── Ripple ──
document.querySelectorAll('.btn-primary,.btn-ghost').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const r = this.getBoundingClientRect();
        const sz = Math.max(r.width, r.height)*2;
        const rp = document.createElement('span');
        rp.style.cssText = `position:absolute;border-radius:50%;pointer-events:none;
            width:${sz}px;height:${sz}px;
            left:${e.clientX-r.left-sz/2}px;top:${e.clientY-r.top-sz/2}px;
            background:rgba(255,255,255,0.18);transform:scale(0);
            animation:rippleOut 0.65s ease-out forwards;`;
        this.appendChild(rp);
        setTimeout(() => rp.remove(), 700);
    });
});
const rs = document.createElement('style');
rs.textContent = '@keyframes rippleOut{to{transform:scale(1);opacity:0;}}';
document.head.appendChild(rs);
</script>
</body>
</html>
