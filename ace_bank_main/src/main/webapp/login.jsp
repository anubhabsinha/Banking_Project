<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String savedAccount = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("rememberedAccount".equals(c.getName())) {
                savedAccount = c.getValue();
                pageContext.setAttribute("savedAccount", savedAccount);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | AceBank</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
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
            --green:    #2ed573;
            --gold:     #f0c040;
            --txt:      #edf2f7;
            --txt2:     #8892a4;
            --txt3:     #4a5568;
            --font: 'Outfit', sans-serif;
            --mono: 'JetBrains Mono', monospace;
            --ease: cubic-bezier(0.4,0,0.2,1);
            --spring: cubic-bezier(0.34,1.56,0.64,1);
        }
        *,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
        html { scroll-behavior:smooth; }
        body {
            font-family:var(--font); background:var(--bg);
            color:var(--txt); min-height:100vh;
            overflow-x:hidden; -webkit-font-smoothing:antialiased;
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
        .orb {
            position:fixed; border-radius:50%;
            filter:blur(100px); pointer-events:none; z-index:0;
        }
        .orb1 {
            width:500px; height:500px;
            background:radial-gradient(circle, rgba(0,212,170,0.12) 0%, transparent 70%);
            top:-150px; right:-100px;
        }
        .orb2 {
            width:400px; height:400px;
            background:radial-gradient(circle, rgba(99,102,241,0.1) 0%, transparent 70%);
            bottom:-100px; left:-100px;
        }
        a { text-decoration:none; color:inherit; }
        ::selection { background:rgba(0,212,170,0.2); color:var(--cyan); }
        ::-webkit-scrollbar { width:4px; }
        ::-webkit-scrollbar-track { background:var(--bg2); }
        ::-webkit-scrollbar-thumb { background:var(--cyan-dim); border-radius:99px; }

        /* ── HEADER ── */
        header {
            position:relative; z-index:100;
            height:68px; padding:0 2.5rem;
            display:flex; align-items:center; justify-content:space-between;
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
        .hdr-links { display:flex; align-items:center; gap:0.4rem; }
        .nav-a {
            font-size:0.88rem; font-weight:500; color:var(--txt2);
            padding:0.4rem 0.9rem; border-radius:8px;
            transition:all 0.2s var(--ease);
        }
        .nav-a:hover { color:var(--txt); background:var(--surface2); }
        .btn-nav {
            font-family:var(--font); font-size:0.88rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.4rem 1.2rem; border-radius:8px;
            cursor:pointer; transition:all 0.2s var(--spring);
        }
        .btn-nav:hover { transform:translateY(-2px); box-shadow:0 6px 20px rgba(0,212,170,0.4); }

        /* ── MAIN LAYOUT ── */
        .auth-page {
            flex:1; display:grid; grid-template-columns:1fr 1fr;
            min-height:calc(100vh - 68px); position:relative; z-index:1;
        }

        /* Left decorative panel */
        .auth-left {
            background:linear-gradient(160deg, rgba(0,212,170,0.06) 0%, transparent 50%);
            border-right:1px solid var(--border);
            display:flex; flex-direction:column;
            align-items:center; justify-content:center;
            padding:3rem; gap:3rem;
        }
        .auth-left-inner { max-width:380px; width:100%; }
        .brand-title {
            font-size:2.4rem; font-weight:900;
            letter-spacing:-0.04em; margin-bottom:1rem; line-height:1.1;
        }
        .brand-title span {
            background:linear-gradient(135deg,var(--cyan),#6366f1);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }
        .brand-sub { font-size:0.95rem; color:var(--txt2); line-height:1.7; margin-bottom:2.5rem; }

        /* Feature list */
        .feat-list { display:flex; flex-direction:column; gap:0.9rem; }
        .feat-item {
            display:flex; align-items:center; gap:1rem;
            padding:1rem 1.2rem;
            background:var(--surface); border:1px solid var(--border);
            border-radius:12px; transition:all 0.25s var(--ease);
        }
        .feat-item:hover { border-color:var(--glow); background:var(--surface2); }
        .feat-ico-wrap {
            width:38px; height:38px; border-radius:10px;
            background:rgba(0,212,170,0.1); border:1px solid rgba(0,212,170,0.15);
            display:flex; align-items:center; justify-content:center;
            font-size:1rem; flex-shrink:0;
        }
        .feat-txt { font-size:0.86rem; font-weight:500; color:var(--txt2); }
        .feat-txt strong { display:block; font-size:0.92rem; color:var(--txt); margin-bottom:0.1rem; }

        /* ── AUTH CARD ── */
        .auth-right {
            display:flex; align-items:center; justify-content:center;
            padding:2.5rem;
        }
        .auth-card {
            width:100%; max-width:420px;
            background:rgba(13,18,32,0.8);
            border:1px solid var(--border);
            border-radius:24px; padding:2.8rem;
            backdrop-filter:blur(16px);
            position:relative; overflow:hidden;
            box-shadow:0 24px 80px rgba(0,0,0,0.6);
            animation:slideUp 0.6s 0.1s var(--spring) both;
        }
        .auth-card::before {
            content:''; position:absolute;
            top:0; left:0; right:0; height:1px;
            background:linear-gradient(90deg, transparent 0%, var(--cyan) 50%, transparent 100%);
            opacity:0.5;
        }
        .auth-card::after {
            content:''; position:absolute;
            inset:0;
            background:radial-gradient(ellipse 80% 40% at 50% 0%, rgba(0,212,170,0.06), transparent 60%);
            pointer-events:none;
        }

        .card-icon {
            width:56px; height:56px; border-radius:16px;
            background:rgba(0,212,170,0.1);
            border:1px solid rgba(0,212,170,0.2);
            display:flex; align-items:center; justify-content:center;
            font-size:1.5rem; margin-bottom:1.5rem;
            position:relative; z-index:1;
        }

        .card-h {
            font-size:1.75rem; font-weight:800; letter-spacing:-0.03em;
            margin-bottom:0.4rem; position:relative; z-index:1;
        }
        .card-sub {
            font-size:0.9rem; color:var(--txt2); margin-bottom:2rem;
            position:relative; z-index:1;
        }

        /* ── FORM ── */
        .form { display:flex; flex-direction:column; gap:1.2rem; position:relative; z-index:1; }

        .field { display:flex; flex-direction:column; gap:0.45rem; }

        label {
            font-size:0.75rem; font-weight:600; color:var(--txt2);
            letter-spacing:0.07em; text-transform:uppercase;
        }

        .input-wrap { position:relative; }

        .input-ico {
            position:absolute; left:1rem; top:50%; transform:translateY(-50%);
            color:var(--txt3); font-size:1rem; pointer-events:none;
            transition:color 0.2s;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="number"] {
            width:100%;
            background:rgba(255,255,255,0.04);
            border:1px solid var(--border);
            border-radius:10px;
            padding:0.8rem 1rem 0.8rem 2.8rem;
            font-family:var(--font); font-size:0.95rem;
            color:var(--txt); outline:none;
            transition:all 0.25s var(--ease);
        }
        input::placeholder { color:var(--txt3); }
        input:focus {
            border-color:var(--cyan);
            background:rgba(0,212,170,0.05);
            box-shadow:0 0 0 3px rgba(0,212,170,0.12);
        }
        input:focus + .input-ico,
        .input-wrap:focus-within .input-ico { color:var(--cyan); }
        input.err {
            border-color:var(--red);
            background:rgba(255,71,87,0.05);
            box-shadow:0 0 0 3px rgba(255,71,87,0.1);
        }

        /* Eye toggle */
        .eye-btn {
            position:absolute; right:1rem; top:50%; transform:translateY(-50%);
            background:none; border:none; color:var(--txt3);
            cursor:pointer; font-size:1.1rem; padding:0;
            transition:color 0.2s; line-height:1;
        }
        .eye-btn:hover { color:var(--txt2); }

        .field-err {
            font-size:0.76rem; color:var(--red); margin-top:0.2rem;
            display:none; align-items:center; gap:0.35rem;
        }
        .field-err.show { display:flex; animation:errPop 0.2s var(--spring); }

        /* Checkbox row */
        .check-row {
            display:flex; align-items:center; justify-content:space-between; gap:1rem;
        }
        .check-label {
            display:flex; align-items:center; gap:0.6rem; cursor:pointer;
        }
        input[type="checkbox"] {
            appearance:none; -webkit-appearance:none;
            width:18px; height:18px; border-radius:5px;
            border:1.5px solid var(--border);
            background:var(--surface);
            cursor:pointer; position:relative;
            transition:all 0.2s var(--ease);
            flex-shrink:0;
        }
        input[type="checkbox"]:checked {
            background:var(--cyan); border-color:var(--cyan);
        }
        input[type="checkbox"]:checked::after {
            content:'✓'; position:absolute;
            inset:0; display:flex; align-items:center; justify-content:center;
            font-size:11px; color:var(--bg); font-weight:700;
        }
        .check-txt { font-size:0.86rem; color:var(--txt2); }
        .forgot-a {
            font-size:0.84rem; color:var(--cyan);
            transition:color 0.2s;
        }
        .forgot-a:hover { color:#fff; }

        /* Submit */
        .btn-submit {
            font-family:var(--font); font-size:1rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.9rem; border-radius:12px; width:100%;
            cursor:pointer; transition:all 0.25s var(--spring);
            display:flex; align-items:center; justify-content:center; gap:0.5rem;
            position:relative; overflow:hidden; margin-top:0.4rem;
        }
        .btn-submit:hover {
            transform:translateY(-3px); box-shadow:0 14px 36px rgba(0,212,170,0.4);
        }
        .btn-submit:active { transform:translateY(-1px); }
        .btn-submit .btn-ico { transition:transform 0.25s var(--spring); }
        .btn-submit:hover .btn-ico { transform:translateX(4px); }
        .btn-submit.loading { pointer-events:none; opacity:0.8; }

        /* Divider */
        .divider {
            display:flex; align-items:center; gap:1rem; color:var(--txt3);
            font-size:0.78rem; text-transform:uppercase; letter-spacing:0.1em;
        }
        .divider::before, .divider::after {
            content:''; flex:1; height:1px; background:var(--border);
        }

        .footer-txt {
            text-align:center; font-size:0.88rem; color:var(--txt2);
            position:relative; z-index:1;
        }
        .footer-txt a { color:var(--cyan); font-weight:600; transition:color 0.2s; }
        .footer-txt a:hover { color:#fff; }

        /* ── TOAST ── */
        .toast {
            position:fixed; bottom:2rem; right:2rem; z-index:9999;
            padding:1rem 1.4rem; border-radius:14px;
            background:var(--bg3); border:1px solid var(--border);
            display:flex; align-items:center; gap:0.75rem;
            font-size:0.9rem; box-shadow:0 12px 40px rgba(0,0,0,0.5);
            animation:toastIn 0.35s var(--spring) both;
            max-width:320px;
        }
        .toast.err-toast { border-color:rgba(255,71,87,0.4); }
        .toast-ico { font-size:1.1rem; flex-shrink:0; }

        /* ── ANIMATIONS ── */
        @keyframes slideUp {
            from { opacity:0; transform:translateY(30px); }
            to { opacity:1; transform:translateY(0); }
        }
        @keyframes errPop { from { transform:translateX(-6px); } to { transform:translateX(0); } }
        @keyframes toastIn {
            from { opacity:0; transform:translateY(20px) scale(0.92); }
            to { opacity:1; transform:translateY(0) scale(1); }
        }
        @keyframes spin { to { transform:rotate(360deg); } }
        @keyframes rippleOut { to { transform:scale(1); opacity:0; } }

        /* ── RESPONSIVE ── */
        @media (max-width:900px) {
            .auth-page { grid-template-columns:1fr; }
            .auth-left { display:none; }
            .auth-right { padding:2rem 1.5rem; }
        }
        @media (max-width:480px) {
            header { padding:0 1rem; }
            .auth-card { padding:2rem 1.4rem; }
        }
    </style>
</head>
<body>
<div class="orb orb1"></div>
<div class="orb orb2"></div>

<!-- ══ HEADER ══ -->
<header>
    <a href="index.jsp" class="logo">
        <span class="logo-a">Ace</span><span class="logo-b">Bank</span>
    </a>
    <div class="hdr-links">
        <a href="index.jsp" class="nav-a">Home</a>
        <a href="sign-up.jsp" class="btn-nav">Join Now</a>
    </div>
</header>

<!-- ══ AUTH PAGE ══ -->
<div class="auth-page">

    <!-- Left panel -->
    <div class="auth-left">
        <div class="auth-left-inner">
            <div class="brand-title">Secure.<br><span>Smart. Simple.</span></div>
            <p class="brand-sub">Your financial life, simplified. AceBank gives you complete control over your money with zero complexity.</p>
            <div class="feat-list">
                <div class="feat-item">
                    <div class="feat-ico-wrap">🔐</div>
                    <div class="feat-txt">
                        <strong>Multi-Factor Auth</strong>
                        Bank-grade security on every login
                    </div>
                </div>
                <div class="feat-item">
                    <div class="feat-ico-wrap">⚡</div>
                    <div class="feat-txt">
                        <strong>Instant Access</strong>
                        View balance and transactions in real-time
                    </div>
                </div>
                <div class="feat-item">
                    <div class="feat-ico-wrap">🛡️</div>
                    <div class="feat-txt">
                        <strong>Fraud Protection</strong>
                        AI-powered monitoring around the clock
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Right: form -->
    <div class="auth-right">
        <div class="auth-card">
            <div class="card-icon">🔑</div>
            <h1 class="card-h">Welcome back</h1>
            <p class="card-sub">Sign in to access your AceBank account.</p>

            <form class="form" action="Login" method="POST" id="loginForm" novalidate>

                <div class="field">
                    <label for="accNo">Account Number</label>
                    <div class="input-wrap">
                        <input type="text" id="accNo" name="accountNumber"
                               value="${savedAccount}" autocomplete="username"
                               placeholder="Enter your account number">
                        <span class="input-ico">🏦</span>
                    </div>
                    <div class="field-err" id="accErr">
                        <span>⚠</span> Account number is required
                    </div>
                </div>

                <div class="field">
                    <label for="pass">Password</label>
                    <div class="input-wrap">
                        <input type="password" id="pass" name="password"
                               autocomplete="current-password" placeholder="••••••••••">
                        <span class="input-ico">🔒</span>
                        <button type="button" class="eye-btn" id="eyeBtn" aria-label="Toggle password visibility">👁</button>
                    </div>
                    <div class="field-err" id="passErr">
                        <span>⚠</span> Password is required
                    </div>
                </div>

                <div class="check-row">
                    <label class="check-label">
                        <input type="checkbox" name="rememberMe" id="remember"
                            ${not empty savedAccount ? 'checked' : ''}>
                        <span class="check-txt">Remember me</span>
                    </label>
                    <a href="ForgotPassword.jsp" class="forgot-a">Forgot password?</a>
                </div>

                <button type="submit" class="btn-submit" id="submitBtn">
                    <span class="btn-lbl">Sign In</span>
                    <svg class="btn-ico" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </button>

            </form>

            <div style="margin-top:1.5rem; position:relative; z-index:1;">
                <p class="footer-txt">Don't have an account? <a href="sign-up.jsp">Create one free</a></p>
            </div>
        </div>
    </div>
</div>

<script>
// ── Password toggle ──
const eye = document.getElementById('eyeBtn');
const passInput = document.getElementById('pass');
eye && eye.addEventListener('click', () => {
    const show = passInput.type === 'password';
    passInput.type = show ? 'text' : 'password';
    eye.textContent = show ? '🙈' : '👁';
});

// ── Form validation ──
const form = document.getElementById('loginForm');
const accInput = document.getElementById('accNo');

function showErr(input, errEl) {
    input.classList.add('err');
    errEl.classList.add('show');
}
function clearErr(input, errEl) {
    input.classList.remove('err');
    errEl.classList.remove('show');
}

[accInput, passInput].forEach(inp => {
    inp.addEventListener('input', () => {
        const errId = inp.id === 'accNo' ? 'accErr' : 'passErr';
        if (inp.value.trim()) clearErr(inp, document.getElementById(errId));
    });
});

form.addEventListener('submit', function(e) {
    let valid = true;
    if (!accInput.value.trim()) {
        showErr(accInput, document.getElementById('accErr')); valid = false;
    }
    if (!passInput.value.trim()) {
        showErr(passInput, document.getElementById('passErr')); valid = false;
    }
    if (!valid) { e.preventDefault(); return; }

    const btn = document.getElementById('submitBtn');
    btn.classList.add('loading');
    btn.innerHTML = `
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"
             style="animation:spin 0.8s linear infinite">
          <path d="M21 12a9 9 0 11-6.219-8.56"/>
        </svg>
        Signing in…
    `;
});

// ── Input focus animation ──
document.querySelectorAll('input[type="text"], input[type="password"]').forEach(inp => {
    inp.addEventListener('focus', () => {
        inp.closest('.field').style.transform = 'translateY(-1px)';
        inp.closest('.field').style.transition = 'transform 0.2s ease';
    });
    inp.addEventListener('blur', () => {
        inp.closest('.field').style.transform = '';
    });
});

// ── Ripple ──
document.querySelectorAll('.btn-submit,.btn-nav').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const r = this.getBoundingClientRect();
        const sz = Math.max(r.width, r.height)*2;
        const rp = document.createElement('span');
        rp.style.cssText = `position:absolute;border-radius:50%;pointer-events:none;
            width:${sz}px;height:${sz}px;
            left:${e.clientX-r.left-sz/2}px;top:${e.clientY-r.top-sz/2}px;
            background:rgba(255,255,255,0.2);transform:scale(0);
            animation:rippleOut 0.65s ease-out forwards;`;
        this.style.cssText += ';position:relative;overflow:hidden;';
        this.appendChild(rp);
        setTimeout(() => rp.remove(), 700);
    });
});
const rs = document.createElement('style');
rs.textContent = '@keyframes rippleOut{to{transform:scale(1);opacity:0;}} @keyframes spin{to{transform:rotate(360deg);}}';
document.head.appendChild(rs);
</script>
</body>
</html>
