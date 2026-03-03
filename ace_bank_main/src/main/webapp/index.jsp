<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AceBank — Modern Banking</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:        #080c14;
            --bg2:       #0d1220;
            --bg3:       #111827;
            --surface:   rgba(255,255,255,0.04);
            --surface2:  rgba(255,255,255,0.07);
            --border:    rgba(255,255,255,0.08);
            --glow:      rgba(0,212,170,0.35);
            --cyan:      #00d4aa;
            --cyan-dim:  #00a882;
            --cyan-bg:   rgba(0,212,170,0.08);
            --cyan-glow: rgba(0,212,170,0.18);
            --gold:      #f0c040;
            --green:     #2ed573;
            --txt:       #edf2f7;
            --txt2:      #8892a4;
            --txt3:      #4a5568;
            --font: 'Outfit', sans-serif;
            --mono: 'JetBrains Mono', monospace;
            --ease: cubic-bezier(0.4,0,0.2,1);
            --spring: cubic-bezier(0.34,1.56,0.64,1);
        }
        *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
        html { scroll-behavior:smooth; }
        body {
            font-family: var(--font);
            background: var(--bg);
            color: var(--txt);
            min-height:100vh;
            overflow-x:hidden;
            -webkit-font-smoothing:antialiased;
        }
        body::before {
            content:'';
            position:fixed; inset:0;
            background-image:
                linear-gradient(rgba(0,212,170,0.025) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,212,170,0.025) 1px, transparent 1px);
            background-size:64px 64px;
            pointer-events:none; z-index:0;
        }
        .orb {
            position:fixed; border-radius:50%;
            filter:blur(110px); pointer-events:none; z-index:0;
        }
        .orb1 {
            width:650px; height:650px;
            background:radial-gradient(circle, rgba(0,212,170,0.1) 0%, transparent 70%);
            top:-200px; right:-150px;
            animation:orbDrift 14s ease-in-out infinite;
        }
        .orb2 {
            width:500px; height:500px;
            background:radial-gradient(circle, rgba(99,102,241,0.09) 0%, transparent 70%);
            bottom:-100px; left:-100px;
            animation:orbDrift 18s ease-in-out infinite reverse;
        }
        a { text-decoration:none; color:inherit; }
        ::selection { background:rgba(0,212,170,0.25); color:var(--cyan); }
        ::-webkit-scrollbar { width:4px; }
        ::-webkit-scrollbar-track { background:var(--bg2); }
        ::-webkit-scrollbar-thumb { background:var(--cyan-dim); border-radius:99px; }

        /* ── HEADER ── */
        header {
            position:fixed; top:0; left:0; right:0; z-index:1000;
            height:68px; padding:0 2.5rem;
            display:flex; align-items:center; justify-content:space-between;
            backdrop-filter:blur(24px) saturate(180%);
            -webkit-backdrop-filter:blur(24px) saturate(180%);
            background:rgba(8,12,20,0.8);
            border-bottom:1px solid var(--border);
            transition:all 0.3s var(--ease);
        }
        header.scrolled {
            border-bottom-color:var(--glow);
            box-shadow:0 2px 40px rgba(0,212,170,0.07);
        }
        .logo {
            font-size:1.6rem; font-weight:800;
            letter-spacing:-0.045em; display:flex; align-items:center;
        }
        .logo-a { color:var(--txt); }
        .logo-b {
            color:var(--cyan);
            background:linear-gradient(135deg, var(--cyan), #6366f1);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }
        .nav-links {
            display:flex; align-items:center; gap:0.4rem;
        }
        .nav-a {
            font-size:0.9rem; font-weight:500; color:var(--txt2);
            padding:0.45rem 1rem; border-radius:8px;
            transition:all 0.2s var(--ease);
        }
        .nav-a:hover { color:var(--txt); background:var(--surface2); }
        .btn-cta {
            font-family:var(--font); font-size:0.9rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.5rem 1.4rem; border-radius:9px;
            cursor:pointer; transition:all 0.2s var(--spring);
            position:relative; overflow:hidden; display:inline-flex;
            align-items:center; gap:0.4rem;
        }
        .btn-cta:hover {
            transform:translateY(-2px);
            box-shadow:0 8px 28px rgba(0,212,170,0.45);
        }
        .btn-cta:active { transform:translateY(0); }

        /* ── HERO ── */
        .wrap {
            max-width:1200px; margin:0 auto;
            padding:0 2rem; position:relative; z-index:1;
        }
        .hero {
            min-height:100vh; padding-top:68px;
            display:grid; grid-template-columns:1fr 1fr;
            align-items:center; gap:4rem;
        }
        .hero-left { padding:3.5rem 0; }

        .hero-pill {
            display:inline-flex; align-items:center; gap:0.6rem;
            font-family:var(--mono); font-size:0.7rem; font-weight:500;
            color:var(--cyan);
            background:rgba(0,212,170,0.07);
            border:1px solid rgba(0,212,170,0.18);
            padding:0.4rem 1rem; border-radius:99px;
            margin-bottom:1.8rem;
            opacity:0; transform:translateY(16px);
            animation:up 0.6s 0.1s var(--ease) forwards;
        }
        .pill-dot {
            width:6px; height:6px; border-radius:50%;
            background:var(--cyan);
            animation:blink 2s ease-in-out infinite;
        }

        h1.hero-h {
            font-size:clamp(2.8rem, 5.5vw, 4.8rem);
            font-weight:900; line-height:1.04;
            letter-spacing:-0.04em; margin-bottom:1.4rem;
            opacity:0; transform:translateY(24px);
            animation:up 0.7s 0.2s var(--ease) forwards;
        }
        .hl {
            display:inline-block;
            background:linear-gradient(135deg, var(--cyan) 0%, #6366f1 100%);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }

        .hero-sub {
            font-size:1.05rem; color:var(--txt2); line-height:1.75;
            max-width:480px; margin-bottom:2.2rem;
            opacity:0; transform:translateY(20px);
            animation:up 0.7s 0.3s var(--ease) forwards;
        }

        .hero-btns {
            display:flex; gap:1rem; margin-bottom:3rem;
            opacity:0; transform:translateY(20px);
            animation:up 0.7s 0.4s var(--ease) forwards;
        }
        .btn-big {
            font-family:var(--font); font-size:1rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.9rem 2rem; border-radius:12px;
            cursor:pointer; transition:all 0.25s var(--spring);
            display:inline-flex; align-items:center; gap:0.5rem;
            position:relative; overflow:hidden;
        }
        .btn-big:hover {
            transform:translateY(-3px);
            box-shadow:0 14px 36px rgba(0,212,170,0.4);
        }
        .btn-big:active { transform:translateY(-1px); }
        .btn-big .ico { transition:transform 0.25s var(--spring); }
        .btn-big:hover .ico { transform:translateX(4px); }

        .btn-ghost {
            font-family:var(--font); font-size:1rem; font-weight:600;
            color:var(--txt);
            background:transparent; border:1px solid var(--border);
            padding:0.9rem 1.8rem; border-radius:12px;
            cursor:pointer; transition:all 0.25s var(--ease);
            display:inline-flex; align-items:center; gap:0.5rem;
        }
        .btn-ghost:hover {
            border-color:var(--glow); color:var(--cyan);
            background:var(--cyan-bg); transform:translateY(-2px);
        }

        /* Stats */
        .hero-stats {
            display:flex; gap:2rem;
            opacity:0; transform:translateY(20px);
            animation:up 0.7s 0.5s var(--ease) forwards;
        }
        .stat { display:flex; flex-direction:column; gap:0.2rem; }
        .stat-n {
            font-size:1.9rem; font-weight:900;
            letter-spacing:-0.04em; color:var(--txt); line-height:1;
        }
        .stat-n em { color:var(--cyan); font-style:normal; }
        .stat-l {
            font-size:0.72rem; font-weight:600; color:var(--txt3);
            letter-spacing:0.1em; text-transform:uppercase;
        }
        .stat-div { width:1px; background:var(--border); align-self:stretch; }

        /* ── VISUAL ── */
        .hero-right {
            display:flex; justify-content:center; align-items:center;
            opacity:0; animation:scaleIn 0.9s 0.35s var(--spring) forwards;
        }
        .card-scene { position:relative; width:380px; height:430px; }

        .bank-card {
            position:absolute; border-radius:24px; padding:1.8rem; width:320px;
        }
        .card-primary {
            background:linear-gradient(135deg, #0c1628 0%, #0d1f3c 60%, #0a1628 100%);
            border:1px solid rgba(0,212,170,0.22);
            box-shadow:0 24px 60px rgba(0,0,0,0.65), 0 0 0 1px rgba(0,212,170,0.08);
            top:40px; left:25px; z-index:3;
            animation:cardBob 7s ease-in-out infinite;
            cursor:pointer;
            transition:box-shadow 0.3s;
        }
        .card-primary:hover { box-shadow:0 28px 70px rgba(0,0,0,0.7), 0 0 30px rgba(0,212,170,0.15); }
        .card-b1 {
            background:linear-gradient(135deg, rgba(0,212,170,0.12), rgba(0,212,170,0.04));
            border:1px solid rgba(0,212,170,0.1);
            top:5px; left:55px; z-index:2;
            transform:rotate(6deg); width:300px; height:180px;
            animation:cardBob 7s 0.6s ease-in-out infinite;
        }
        .card-b2 {
            background:linear-gradient(135deg, rgba(99,102,241,0.1), rgba(99,102,241,0.03));
            border:1px solid rgba(99,102,241,0.1);
            top:0; left:5px; z-index:1;
            transform:rotate(-5deg); width:300px; height:180px;
            animation:cardBob 7s 1.2s ease-in-out infinite;
        }

        .chip {
            width:46px; height:35px;
            background:linear-gradient(135deg, var(--gold) 0%, #c8961c 100%);
            border-radius:7px; margin-bottom:1.6rem;
            position:relative; overflow:hidden;
        }
        .chip::after {
            content:''; position:absolute; inset:4px;
            border:1px solid rgba(0,0,0,0.2); border-radius:3px;
        }

        .card-num {
            font-family:var(--mono); font-size:0.88rem;
            color:rgba(255,255,255,0.55); letter-spacing:0.18em;
            margin-bottom:1.4rem;
        }
        .card-foot { display:flex; justify-content:space-between; align-items:flex-end; }
        .card-holder { font-size:0.75rem; color:rgba(255,255,255,0.4); text-transform:uppercase; letter-spacing:0.1em; }
        .card-logo-text { font-size:1.4rem; font-weight:900; color:var(--cyan); letter-spacing:-0.03em; }

        /* Floating info chips */
        .chip-float {
            position:absolute; z-index:5;
            background:rgba(13,18,32,0.9);
            border:1px solid var(--border);
            border-radius:14px; padding:0.8rem 1rem;
            display:flex; align-items:center; gap:0.7rem;
            backdrop-filter:blur(16px);
            box-shadow:0 8px 32px rgba(0,0,0,0.5);
        }
        .cf1 { bottom:20px; left:-40px; animation:chipBob 5s 1s ease-in-out infinite; }
        .cf2 { top:10px; right:-30px; animation:chipBob 5s 2s ease-in-out infinite reverse; }
        .cf-ico {
            width:34px; height:34px; border-radius:10px;
            display:flex; align-items:center; justify-content:center; font-size:1rem;
        }
        .ci-g { background:rgba(46,213,115,0.15); }
        .ci-c { background:rgba(0,212,170,0.15); }
        .cf-lbl { font-size:0.68rem; color:var(--txt3); }
        .cf-val { font-size:0.9rem; font-weight:700; }
        .cv-g { color:var(--green); }
        .cv-c { color:var(--cyan); }

        /* ── FEATURES ── */
        .features {
            padding:7rem 0; position:relative; z-index:1;
        }
        .section-eyebrow {
            display:flex; align-items:center; gap:0.7rem;
            font-family:var(--mono); font-size:0.7rem; font-weight:500;
            color:var(--cyan); letter-spacing:0.15em; text-transform:uppercase;
            margin-bottom:1rem;
        }
        .section-eyebrow::before {
            content:''; width:20px; height:2px;
            background:var(--cyan); border-radius:99px;
        }
        h2.sec-h {
            font-size:clamp(1.9rem, 3.5vw, 2.8rem);
            font-weight:900; letter-spacing:-0.04em;
            margin-bottom:0.7rem; line-height:1.1;
        }
        .sec-sub {
            font-size:1rem; color:var(--txt2); line-height:1.7;
            max-width:480px; margin-bottom:3rem;
        }
        .feat-grid {
            display:grid; grid-template-columns:repeat(3,1fr); gap:1.4rem;
        }
        .feat-card {
            background:var(--surface); border:1px solid var(--border);
            border-radius:20px; padding:1.8rem;
            transition:all 0.3s var(--ease); cursor:default;
            position:relative; overflow:hidden;
        }
        .feat-card::before {
            content:''; position:absolute; inset:0;
            background:linear-gradient(135deg, var(--cyan-glow), transparent 60%);
            opacity:0; transition:opacity 0.3s;
        }
        .feat-card:hover {
            border-color:var(--glow); transform:translateY(-5px);
            box-shadow:0 20px 50px rgba(0,212,170,0.1);
        }
        .feat-card:hover::before { opacity:1; }
        .feat-ico {
            width:50px; height:50px; border-radius:14px;
            background:rgba(0,212,170,0.1); border:1px solid rgba(0,212,170,0.18);
            display:flex; align-items:center; justify-content:center;
            font-size:1.3rem; margin-bottom:1.2rem;
            position:relative; z-index:1;
        }
        .feat-t {
            font-size:1rem; font-weight:700; margin-bottom:0.45rem;
            letter-spacing:-0.01em; position:relative; z-index:1;
        }
        .feat-d { font-size:0.86rem; color:var(--txt2); line-height:1.65; position:relative; z-index:1; }

        /* ── CTA BOX ── */
        .cta-wrap { padding-bottom:5rem; position:relative; z-index:1; }
        .cta-inner {
            background:linear-gradient(135deg, rgba(0,212,170,0.08), rgba(99,102,241,0.06));
            border:1px solid rgba(0,212,170,0.18);
            border-radius:28px; padding:4rem;
            text-align:center; position:relative; overflow:hidden;
        }
        .cta-inner::before {
            content:''; position:absolute;
            top:-120px; left:50%; transform:translateX(-50%);
            width:500px; height:500px;
            background:radial-gradient(circle, rgba(0,212,170,0.1), transparent 70%);
            pointer-events:none;
        }
        .cta-inner h2 {
            font-size:clamp(2rem,4.5vw,3.2rem); font-weight:900;
            letter-spacing:-0.04em; margin-bottom:1rem; position:relative; z-index:1;
        }
        .cta-inner p { font-size:1rem; color:var(--txt2); margin-bottom:2rem; position:relative; z-index:1; }

        /* ── ANIMATIONS ── */
        @keyframes up { to { opacity:1; transform:translateY(0); } }
        @keyframes scaleIn { from { opacity:0; transform:scale(0.88); } to { opacity:1; transform:scale(1); } }
        @keyframes orbDrift {
            0%,100% { transform:translate(0,0); }
            33% { transform:translate(40px,-25px); }
            66% { transform:translate(-20px,30px); }
        }
        @keyframes cardBob {
            0%,100% { transform:translateY(0); }
            50% { transform:translateY(-16px); }
        }
        @keyframes chipBob {
            0%,100% { transform:translateY(0); }
            50% { transform:translateY(-9px); }
        }
        @keyframes blink {
            0%,100% { opacity:1; transform:scale(1); }
            50% { opacity:0.4; transform:scale(0.75); }
        }
        @keyframes rippleOut { to { transform:scale(1); opacity:0; } }

        @media (max-width:900px) {
            .hero { grid-template-columns:1fr; min-height:auto; padding:6rem 0 4rem; gap:3rem; }
            .hero-right { order:-1; }
            .card-scene { transform:scale(0.85); }
            .feat-grid { grid-template-columns:1fr 1fr; }
        }
        @media (max-width:600px) {
            header { padding:0 1rem; }
            .wrap { padding:0 1rem; }
            .hero-btns { flex-direction:column; }
            .feat-grid { grid-template-columns:1fr; }
            .cta-inner { padding:2.5rem 1.5rem; }
            .card-scene { transform:scale(0.72); transform-origin:center top; }
        }
    </style>
</head>
<body>
<div class="orb orb1"></div>
<div class="orb orb2"></div>

<!-- ══ HEADER ══ -->
<header id="hdr">
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
        <span class="logo-a">Ace</span><span class="logo-b">Bank</span>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/login.jsp" class="nav-a">Login</a>
        <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn-cta">
            Get Started
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
        </a>
    </div>
</header>

<div class="wrap">

<!-- ══ HERO ══ -->
<section class="hero">
    <div class="hero-left">
        <div class="hero-pill">
            <span class="pill-dot"></span>
            Trusted by 2M+ users worldwide
        </div>

        <h1 class="hero-h">
            Banking Made<br>
            <span class="hl">Easy</span> &amp; Smart
        </h1>

        <p class="hero-sub">
            Join over 40,000 people who open an AceBank account every week.
            Manage, spend, and grow your money with zero friction.
        </p>

        <div class="hero-btns">
            <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn-big">
                Open Free Account
                <svg class="ico" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </a>
            <a href="#features" class="btn-ghost">
                View Features
            </a>
        </div>

        <div class="hero-stats">
            <div class="stat">
                <div class="stat-n"><span class="cnt" data-to="2">0</span>M<em>+</em></div>
                <div class="stat-l">Active Users</div>
            </div>
            <div class="stat-div"></div>
            <div class="stat">
                <div class="stat-n">₹<span class="cnt" data-to="50">0</span>B<em>+</em></div>
                <div class="stat-l">Transferred</div>
            </div>
            <div class="stat-div"></div>
            <div class="stat">
                <div class="stat-n"><span class="cnt" data-to="99">0</span><em>.9%</em></div>
                <div class="stat-l">Uptime</div>
            </div>
        </div>
    </div>

    <div class="hero-right">
        <div class="card-scene">
            <div class="bank-card card-b2"></div>
            <div class="bank-card card-b1"></div>
            <div class="bank-card card-primary" id="tiltCard">
                <div class="chip"></div>
                <div class="card-num">4521 •••• •••• 8834</div>
                <div class="card-foot">
                    <div>
                        <div class="card-holder">Premium Account</div>
                    </div>
                    <div class="card-logo-text">Ace</div>
                </div>
            </div>

            <div class="chip-float cf1">
                <div class="cf-ico ci-g">💰</div>
                <div>
                    <div class="cf-lbl">Last Deposit</div>
                    <div class="cf-val cv-g">+₹24,500</div>
                </div>
            </div>
            <div class="chip-float cf2">
                <div class="cf-ico ci-c">⚡</div>
                <div>
                    <div class="cf-lbl">Instant Transfer</div>
                    <div class="cf-val cv-c">0 Fees</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ══ FEATURES ══ -->
<section class="features" id="features">
    <div class="section-eyebrow">Why AceBank</div>
    <h2 class="sec-h">Everything you need,<br>nothing you don't.</h2>
    <p class="sec-sub">Built for speed, security, and simplicity — every feature is designed to make your financial life frictionless.</p>

    <div class="feat-grid">
        <div class="feat-card rc">
            <div class="feat-ico">🔐</div>
            <div class="feat-t">Bank-Grade Security</div>
            <p class="feat-d">256-bit AES encryption, biometric auth, and real-time fraud detection keep your money safe.</p>
        </div>
        <div class="feat-card rc">
            <div class="feat-ico">⚡</div>
            <div class="feat-t">Instant Transfers</div>
            <p class="feat-d">Send money to anyone in seconds with zero hidden fees — domestic or international.</p>
        </div>
        <div class="feat-card rc">
            <div class="feat-ico">📊</div>
            <div class="feat-t">Smart Analytics</div>
            <p class="feat-d">Real-time spending insights, budgets, and reports so you always know where every rupee goes.</p>
        </div>
        <div class="feat-card rc">
            <div class="feat-ico">🌐</div>
            <div class="feat-t">24/7 Availability</div>
            <p class="feat-d">Your bank never sleeps. Access your account anytime, from anywhere in the world.</p>
        </div>
        <div class="feat-card rc">
            <div class="feat-ico">💳</div>
            <div class="feat-t">Virtual Cards</div>
            <p class="feat-d">Create instant virtual cards for online shopping. Freeze or delete at any time.</p>
        </div>
        <div class="feat-card rc">
            <div class="feat-ico">🤝</div>
            <div class="feat-t">Zero Fees</div>
            <p class="feat-d">No maintenance fees, no minimum balance, no surprise charges — ever.</p>
        </div>
    </div>
</section>

<!-- ══ CTA ══ -->
<div class="cta-wrap">
    <div class="cta-inner">
        <h2>Ready to get started?</h2>
        <p>Open your account in under 3 minutes. No paperwork. No branch visits.</p>
        <a href="${pageContext.request.contextPath}/sign-up.jsp" class="btn-big" style="display:inline-flex; font-size:1rem; padding:1rem 2.5rem;">
            Create Free Account
            <svg class="ico" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
        </a>
    </div>
</div>

</div><!-- /wrap -->

<script>
// ── Scroll header ──
const hdr = document.getElementById('hdr');
addEventListener('scroll', () => hdr.classList.toggle('scrolled', scrollY > 20), {passive:true});

// ── 3D card tilt ──
const tc = document.getElementById('tiltCard');
tc && tc.addEventListener('mousemove', e => {
    const r = tc.getBoundingClientRect();
    const x = (e.clientX - r.left) / r.width - 0.5;
    const y = (e.clientY - r.top) / r.height - 0.5;
    tc.style.transform = `perspective(900px) rotateY(${x*20}deg) rotateX(${-y*15}deg)`;
});
tc && tc.addEventListener('mouseleave', () => tc.style.transform = '');

// ── Counter animation ──
const countIO = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (!e.isIntersecting) return;
        const el = e.target, target = +el.dataset.to;
        let start = null;
        const tick = ts => {
            if (!start) start = ts;
            const p = Math.min((ts-start)/1600, 1);
            el.textContent = Math.floor((1-Math.pow(1-p,4))*target);
            if (p < 1) requestAnimationFrame(tick);
        };
        requestAnimationFrame(tick);
        countIO.unobserve(el);
    });
}, {threshold:0.4});
document.querySelectorAll('.cnt').forEach(el => countIO.observe(el));

// ── Scroll reveal ──
const revIO = new IntersectionObserver(entries => {
    entries.forEach((e, i) => {
        if (!e.isIntersecting) return;
        setTimeout(() => {
            e.target.style.opacity = '1';
            e.target.style.transform = 'translateY(0)';
        }, i * 90);
        revIO.unobserve(e.target);
    });
}, {threshold:0.1});
document.querySelectorAll('.rc').forEach(el => {
    el.style.cssText += 'opacity:0;transform:translateY(28px);transition:opacity 0.6s ease,transform 0.6s ease;';
    revIO.observe(el);
});

// ── Ripple effect ──
document.querySelectorAll('.btn-big,.btn-ghost,.btn-cta').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const r = this.getBoundingClientRect();
        const size = Math.max(r.width, r.height)*2;
        const ripple = document.createElement('span');
        ripple.style.cssText = `position:absolute;border-radius:50%;pointer-events:none;
            width:${size}px;height:${size}px;
            left:${e.clientX-r.left-size/2}px;top:${e.clientY-r.top-size/2}px;
            background:rgba(255,255,255,0.18);transform:scale(0);
            animation:rippleOut 0.65s ease-out forwards;`;
        this.style.cssText += ';position:relative;overflow:hidden;';
        this.appendChild(ripple);
        setTimeout(() => ripple.remove(), 700);
    });
});
const rs = document.createElement('style');
rs.textContent = '@keyframes rippleOut{to{transform:scale(1);opacity:0;}}';
document.head.appendChild(rs);
</script>
</body>
</html>
