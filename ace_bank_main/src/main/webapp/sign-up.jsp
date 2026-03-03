<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get Started | AceBank</title>
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
            --orange:   #ffa502;
            --txt:      #edf2f7;
            --txt2:     #8892a4;
            --txt3:     #4a5568;
            --font: 'Outfit', sans-serif;
            --mono: 'JetBrains Mono', monospace;
            --ease: cubic-bezier(0.4,0,0.2,1);
            --spring: cubic-bezier(0.34,1.56,0.64,1);
        }
        *,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
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
            width:550px; height:550px;
            background:radial-gradient(circle, rgba(0,212,170,0.1) 0%, transparent 70%);
            top:-150px; right:-100px;
        }
        .orb2 {
            width:450px; height:450px;
            background:radial-gradient(circle, rgba(99,102,241,0.09) 0%, transparent 70%);
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
        .hdr-links { display:flex; gap:0.4rem; }
        .nav-a {
            font-size:0.88rem; font-weight:500; color:var(--txt2);
            padding:0.4rem 0.9rem; border-radius:8px;
            transition:all 0.2s var(--ease);
        }
        .nav-a:hover { color:var(--txt); background:var(--surface2); }

        /* ── LAYOUT ── */
        .page {
            flex:1; display:flex; align-items:center; justify-content:center;
            padding:2.5rem 1.5rem; position:relative; z-index:1;
        }

        /* ── CARD ── */
        .card {
            width:100%; max-width:520px;
            background:rgba(13,18,32,0.85);
            border:1px solid var(--border);
            border-radius:24px; padding:2.8rem;
            backdrop-filter:blur(20px);
            box-shadow:0 24px 80px rgba(0,0,0,0.6);
            position:relative; overflow:hidden;
            animation:slideUp 0.6s 0.05s var(--spring) both;
        }
        .card::before {
            content:''; position:absolute;
            top:0; left:0; right:0; height:1px;
            background:linear-gradient(90deg, transparent, var(--cyan) 50%, transparent);
            opacity:0.5;
        }
        .card::after {
            content:''; position:absolute; inset:0;
            background:radial-gradient(ellipse 70% 35% at 50% 0%, rgba(0,212,170,0.06), transparent 60%);
            pointer-events:none;
        }

        .card-icon {
            width:54px; height:54px; border-radius:16px;
            background:rgba(0,212,170,0.1); border:1px solid rgba(0,212,170,0.2);
            display:flex; align-items:center; justify-content:center;
            font-size:1.4rem; margin-bottom:1.4rem;
            position:relative; z-index:1;
        }
        .card-h {
            font-size:1.7rem; font-weight:800; letter-spacing:-0.03em;
            margin-bottom:0.4rem; position:relative; z-index:1;
        }
        .card-sub {
            font-size:0.9rem; color:var(--txt2); margin-bottom:2rem;
            position:relative; z-index:1;
        }

        /* ── STEP INDICATOR ── */
        .steps {
            display:flex; align-items:center; margin-bottom:2.2rem;
            position:relative; z-index:1;
        }
        .step {
            display:flex; flex-direction:column; align-items:center; gap:0.35rem; flex:1;
        }
        .step-dot {
            width:30px; height:30px; border-radius:50%;
            border:2px solid var(--border);
            background:var(--surface);
            display:flex; align-items:center; justify-content:center;
            font-family:var(--mono); font-size:0.72rem; font-weight:700;
            color:var(--txt3); transition:all 0.3s var(--ease);
        }
        .step.active .step-dot {
            border-color:var(--cyan); background:rgba(0,212,170,0.12);
            color:var(--cyan); box-shadow:0 0 12px rgba(0,212,170,0.25);
        }
        .step.done .step-dot {
            border-color:var(--cyan); background:var(--cyan);
            color:var(--bg); font-size:0.9rem;
        }
        .step-lbl { font-size:0.65rem; color:var(--txt3); letter-spacing:0.06em; text-transform:uppercase; }
        .step.active .step-lbl { color:var(--cyan); }
        .step.done .step-lbl { color:var(--cyan-dim); }
        .step-line { flex:1; height:1px; background:var(--border); margin-bottom:1.1rem; margin-top:-0.55rem; transition:background 0.3s; }
        .step-line.done { background:var(--cyan); }

        /* ── FORM ── */
        .form { display:flex; flex-direction:column; gap:1.1rem; position:relative; z-index:1; }

        .row-2 { display:grid; grid-template-columns:1fr 1fr; gap:1rem; }

        .field { display:flex; flex-direction:column; gap:0.4rem; }

        label {
            font-size:0.73rem; font-weight:600; color:var(--txt2);
            letter-spacing:0.07em; text-transform:uppercase;
        }

        .input-wrap { position:relative; }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width:100%; background:rgba(255,255,255,0.04);
            border:1px solid var(--border); border-radius:10px;
            padding:0.78rem 1rem 0.78rem 2.75rem;
            font-family:var(--font); font-size:0.95rem;
            color:var(--txt); outline:none;
            transition:all 0.25s var(--ease);
        }
        input::placeholder { color:var(--txt3); }
        input:focus {
            border-color:var(--cyan); background:rgba(0,212,170,0.04);
            box-shadow:0 0 0 3px rgba(0,212,170,0.12);
        }
        input.err {
            border-color:var(--red);
            background:rgba(255,71,87,0.04);
            box-shadow:0 0 0 3px rgba(255,71,87,0.1);
        }
        input.ok {
            border-color:var(--green);
            background:rgba(46,213,115,0.03);
        }

        .i-ico {
            position:absolute; left:0.9rem; top:50%; transform:translateY(-50%);
            font-size:0.95rem; pointer-events:none; transition:all 0.2s;
            color:var(--txt3);
        }
        .input-wrap:focus-within .i-ico { color:var(--cyan); }

        .eye-btn {
            position:absolute; right:0.9rem; top:50%; transform:translateY(-50%);
            background:none; border:none; color:var(--txt3);
            cursor:pointer; font-size:1rem; padding:0; line-height:1;
            transition:color 0.2s;
        }
        .eye-btn:hover { color:var(--txt2); }

        .field-err {
            font-size:0.74rem; color:var(--red);
            display:none; align-items:center; gap:0.3rem;
        }
        .field-err.show { display:flex; animation:errPop 0.2s var(--spring); }

        /* Password strength */
        .pw-bars {
            display:flex; gap:3px; height:3px; margin-top:0.5rem;
        }
        .pw-bar {
            flex:1; border-radius:99px;
            background:var(--surface2); transition:background 0.35s ease;
        }
        .pw-hint {
            font-size:0.74rem; margin-top:0.3rem;
            transition:color 0.3s; color:var(--txt3);
        }

        /* Aadhar format helper */
        .format-hint {
            font-family:var(--mono); font-size:0.72rem; color:var(--txt3);
            margin-top:0.3rem;
        }

        /* Submit */
        .btn-submit {
            font-family:var(--font); font-size:1rem; font-weight:700;
            color:var(--bg); background:var(--cyan);
            border:none; padding:0.9rem; border-radius:12px; width:100%;
            cursor:pointer; transition:all 0.25s var(--spring);
            display:flex; align-items:center; justify-content:center; gap:0.5rem;
            position:relative; overflow:hidden; margin-top:0.5rem;
        }
        .btn-submit:hover { transform:translateY(-3px); box-shadow:0 14px 36px rgba(0,212,170,0.4); }
        .btn-submit:active { transform:translateY(-1px); }
        .btn-ico { transition:transform 0.25s var(--spring); }
        .btn-submit:hover .btn-ico { transform:translateX(4px); }
        .btn-submit:disabled { opacity:0.7; pointer-events:none; }

        .terms {
            text-align:center; font-size:0.78rem; color:var(--txt3);
            margin-top:0.5rem; line-height:1.5;
        }
        .terms a { color:var(--cyan); }

        .footer-txt {
            text-align:center; font-size:0.88rem; color:var(--txt2);
            margin-top:1.5rem; position:relative; z-index:1;
        }
        .footer-txt a { color:var(--cyan); font-weight:600; }
        .footer-txt a:hover { color:#fff; }

        /* ── ANIMATIONS ── */
        @keyframes slideUp {
            from { opacity:0; transform:translateY(28px); }
            to { opacity:1; transform:translateY(0); }
        }
        @keyframes errPop { from { transform:translateX(-5px); } to { transform:translateX(0); } }
        @keyframes spin { to { transform:rotate(360deg); } }
        @keyframes rippleOut { to { transform:scale(1); opacity:0; } }

        @media (max-width:540px) {
            .row-2 { grid-template-columns:1fr; }
            .card { padding:2rem 1.4rem; }
            header { padding:0 1rem; }
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
        <a href="login.jsp" class="nav-a">Already a member? Sign in</a>
    </div>
</header>

<!-- ══ PAGE ══ -->
<div class="page">
    <div class="card">
        <div class="card-icon">✦</div>
        <h1 class="card-h">Create Account</h1>
        <p class="card-sub">Join thousands of users managing money smarter.</p>

        <!-- Step indicator -->
        <div class="steps" id="steps">
            <div class="step active" id="s1">
                <div class="step-dot">1</div>
                <div class="step-lbl">Personal</div>
            </div>
            <div class="step-line" id="sl1"></div>
            <div class="step" id="s2">
                <div class="step-dot">2</div>
                <div class="step-lbl">Identity</div>
            </div>
            <div class="step-line" id="sl2"></div>
            <div class="step" id="s3">
                <div class="step-dot">3</div>
                <div class="step-lbl">Security</div>
            </div>
        </div>

        <form class="form" action="signup" method="POST" id="signupForm" novalidate>

            <!-- Row: names -->
            <div class="row-2">
                <div class="field" id="fn-group">
                    <label for="firstName">First Name</label>
                    <div class="input-wrap">
                        <input type="text" name="firstName" id="firstName" placeholder="John" autocomplete="given-name">
                        <span class="i-ico">👤</span>
                    </div>
                    <div class="field-err" id="fn-err"><span>⚠</span> Required</div>
                </div>
                <div class="field" id="ln-group">
                    <label for="lastName">Last Name</label>
                    <div class="input-wrap">
                        <input type="text" name="lastName" id="lastName" placeholder="Doe" autocomplete="family-name">
                        <span class="i-ico">👤</span>
                    </div>
                    <div class="field-err" id="ln-err"><span>⚠</span> Required</div>
                </div>
            </div>

            <!-- Aadhar -->
            <div class="field" id="aadhar-group">
                <label for="aadharNumber">Aadhar Number</label>
                <div class="input-wrap">
                    <input type="text" name="aadharNumber" id="aadharNumber"
                           placeholder="xxxx xxxx xxxx" maxlength="14" inputmode="numeric" autocomplete="off">
                    <span class="i-ico">🪪</span>
                </div>
                <div class="format-hint" id="aadharHint">0 / 12 digits</div>
                <div class="field-err" id="aadhar-err"><span>⚠</span> Must be exactly 12 digits</div>
            </div>

            <!-- Email -->
            <div class="field" id="email-group">
                <label for="email">Email Address</label>
                <div class="input-wrap">
                    <input type="email" name="email" id="email" placeholder="you@example.com" autocomplete="email">
                    <span class="i-ico">✉️</span>
                </div>
                <div class="field-err" id="email-err"><span>⚠</span> Enter a valid email address</div>
            </div>

            <!-- Password -->
            <div class="field" id="password-group">
                <label for="password">Password</label>
                <div class="input-wrap">
                    <input type="password" name="password" id="password" placeholder="Min. 10 characters" autocomplete="new-password">
                    <span class="i-ico">🔒</span>
                    <button type="button" class="eye-btn" id="eyeBtn" aria-label="Toggle password">👁</button>
                </div>
                <div class="pw-bars">
                    <div class="pw-bar" id="b1"></div>
                    <div class="pw-bar" id="b2"></div>
                    <div class="pw-bar" id="b3"></div>
                    <div class="pw-bar" id="b4"></div>
                </div>
                <div class="pw-hint" id="pwHint">Enter a password</div>
                <div class="field-err" id="pw-err"><span>⚠</span> Minimum 10 characters required</div>
            </div>

            <button type="submit" class="btn-submit" id="submitBtn">
                <span id="btnLbl">Create Account</span>
                <svg class="btn-ico" id="btnIco" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </button>

            <p class="terms">By continuing, you agree to our <a href="#">Terms</a> &amp; <a href="#">Privacy Policy</a></p>
        </form>

        <p class="footer-txt">Already have an account? <a href="login.jsp">Sign in</a></p>
    </div>
</div>

<script>
// ── Aadhar formatting ──
const aadharInput = document.getElementById('aadharNumber');
const aadharHint = document.getElementById('aadharHint');
aadharInput.addEventListener('input', function() {
    let val = this.value.replace(/\D/g, '').slice(0,12);
    this.value = val.replace(/(\d{4})(?=\d)/g, '$1 ').trim();
    aadharHint.textContent = `${val.length} / 12 digits`;
    aadharHint.style.color = val.length === 12 ? 'var(--green)' : 'var(--txt3)';
});

// ── Password strength ──
const pwInput = document.getElementById('password');
const bars = [document.getElementById('b1'),document.getElementById('b2'),document.getElementById('b3'),document.getElementById('b4')];
const pwHint = document.getElementById('pwHint');
const levels = [
    {color:'var(--red)',    label:'Weak — too short'},
    {color:'var(--orange)', label:'Fair — add uppercase'},
    {color:'#a3e635',       label:'Good — add symbols'},
    {color:'var(--green)',  label:'Strong ✓'},
];
pwInput.addEventListener('input', function() {
    const v = this.value;
    let score = 0;
    if (v.length >= 10) score++;
    if (/[A-Z]/.test(v)) score++;
    if (/[0-9]/.test(v)) score++;
    if (/[^A-Za-z0-9]/.test(v)) score++;
    bars.forEach((bar, i) => {
        bar.style.background = i < score ? levels[score-1].color : 'rgba(255,255,255,0.07)';
    });
    if (v.length === 0) {
        pwHint.textContent = 'Enter a password';
        pwHint.style.color = 'var(--txt3)';
    } else {
        const lvl = levels[score-1] || levels[0];
        pwHint.textContent = lvl.label;
        pwHint.style.color = lvl.color;
    }
});

// ── Eye toggle ──
const eyeBtn = document.getElementById('eyeBtn');
eyeBtn.addEventListener('click', () => {
    const show = pwInput.type === 'password';
    pwInput.type = show ? 'text' : 'password';
    eyeBtn.textContent = show ? '🙈' : '👁';
});

// ── Step indicator update ──
function updateSteps(filledCount) {
    const steps = ['s1','s2','s3'];
    const lines = ['sl1','sl2'];
    steps.forEach((id, i) => {
        const el = document.getElementById(id);
        el.classList.remove('active','done');
        if (i < filledCount) el.classList.add('done'), el.querySelector('.step-dot').textContent = '✓';
        else if (i === filledCount) el.classList.add('active'), el.querySelector('.step-dot').textContent = i+1;
        else el.querySelector('.step-dot').textContent = i+1;
    });
    lines.forEach((id, i) => {
        document.getElementById(id).classList.toggle('done', i < filledCount-1);
    });
}

const stepFields = [
    [document.getElementById('firstName'), document.getElementById('lastName')],
    [document.getElementById('aadharNumber'), document.getElementById('email')],
    [pwInput]
];

function checkStepProgress() {
    let filled = 0;
    for (const group of stepFields) {
        if (group.every(inp => inp.value.trim().length > 0)) filled++;
        else break;
    }
    updateSteps(filled);
}

document.querySelectorAll('input').forEach(inp => inp.addEventListener('input', checkStepProgress));

// ── Validation ──
function showErr(group, errId) {
    document.getElementById(group).querySelector('input').classList.add('err');
    document.getElementById(errId).classList.add('show');
}
function clearErr(group, errId) {
    document.getElementById(group).querySelector('input').classList.remove('err');
    document.getElementById(errId).classList.remove('show');
}

const rules = [
    { group:'fn-group', err:'fn-err', check: () => document.getElementById('firstName').value.trim().length >= 2 },
    { group:'ln-group', err:'ln-err', check: () => document.getElementById('lastName').value.trim().length >= 2 },
    { group:'aadhar-group', err:'aadhar-err', check: () => aadharInput.value.replace(/\s/g,'').length === 12 },
    { group:'email-group', err:'email-err', check: () => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(document.getElementById('email').value) },
    { group:'password-group', err:'pw-err', check: () => pwInput.value.length >= 10 },
];

// Live clear on input
rules.forEach(r => {
    const inp = document.getElementById(r.group).querySelector('input');
    inp.addEventListener('input', () => { if(r.check()) clearErr(r.group, r.err); });
    inp.addEventListener('blur', () => { if(!r.check() && inp.value) showErr(r.group, r.err); else clearErr(r.group, r.err); });
});

document.getElementById('signupForm').addEventListener('submit', function(e) {
    let valid = true;
    rules.forEach(r => {
        clearErr(r.group, r.err);
        if (!r.check()) { showErr(r.group, r.err); valid = false; }
    });
    if (!valid) {
        e.preventDefault();
        const first = this.querySelector('.field-err.show');
        if (first) first.scrollIntoView({behavior:'smooth', block:'center'});
        return;
    }
    const btn = document.getElementById('submitBtn');
    btn.disabled = true;
    document.getElementById('btnLbl').textContent = 'Creating…';
    document.getElementById('btnIco').outerHTML = `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="animation:spin 0.8s linear infinite"><path d="M21 12a9 9 0 11-6.219-8.56"/></svg>`;
});

// ── Ripple ──
document.querySelectorAll('.btn-submit').forEach(btn => {
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
rs.textContent = '@keyframes rippleOut{to{transform:scale(1);opacity:0;}} @keyframes spin{to{transform:rotate(360deg);}}';
document.head.appendChild(rs);
</script>
</body>
</html>
