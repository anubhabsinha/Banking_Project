<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password | AceBank</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500&display=swap"
            rel="stylesheet">
        <style>
            :root {
                --bg: #080c14;
                --bg2: #0d1220;
                --bg3: #111827;
                --surface: rgba(255, 255, 255, 0.04);
                --surface2: rgba(255, 255, 255, 0.07);
                --border: rgba(255, 255, 255, 0.08);
                --glow: rgba(0, 212, 170, 0.3);
                --cyan: #00d4aa;
                --cyan-dim: #00a882;
                --cyan-bg: rgba(0, 212, 170, 0.08);
                --red: #ff4757;
                --green: #2ed573;
                --txt: #edf2f7;
                --txt2: #8892a4;
                --txt3: #4a5568;
                --font: 'Outfit', sans-serif;
                --mono: 'JetBrains Mono', monospace;
                --ease: cubic-bezier(0.4, 0, 0.2, 1);
                --spring: cubic-bezier(0.34, 1.56, 0.64, 1);
            }

            *,
            *::before,
            *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            html {
                scroll-behavior: smooth;
            }

            body {
                font-family: var(--font);
                background: var(--bg);
                color: var(--txt);
                min-height: 100vh;
                overflow-x: hidden;
                -webkit-font-smoothing: antialiased;
                display: flex;
                flex-direction: column;
            }

            body::before {
                content: '';
                position: fixed;
                inset: 0;
                background-image:
                    linear-gradient(rgba(0, 212, 170, 0.025) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(0, 212, 170, 0.025) 1px, transparent 1px);
                background-size: 64px 64px;
                pointer-events: none;
                z-index: 0;
            }

            .orb {
                position: fixed;
                border-radius: 50%;
                filter: blur(100px);
                pointer-events: none;
                z-index: 0;
            }

            .orb1 {
                width: 500px;
                height: 500px;
                background: radial-gradient(circle, rgba(0, 212, 170, 0.12) 0%, transparent 70%);
                top: -150px;
                right: -100px;
            }

            .orb2 {
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(99, 102, 241, 0.1) 0%, transparent 70%);
                bottom: -100px;
                left: -100px;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            ::selection {
                background: rgba(0, 212, 170, 0.2);
                color: var(--cyan);
            }

            ::-webkit-scrollbar {
                width: 4px;
            }

            ::-webkit-scrollbar-track {
                background: var(--bg2);
            }

            ::-webkit-scrollbar-thumb {
                background: var(--cyan-dim);
                border-radius: 99px;
            }

            header {
                position: relative;
                z-index: 100;
                height: 68px;
                padding: 0 2.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                backdrop-filter: blur(20px);
                background: rgba(8, 12, 20, 0.75);
                border-bottom: 1px solid var(--border);
            }

            .logo {
                font-size: 1.55rem;
                font-weight: 800;
                letter-spacing: -0.045em;
                display: flex;
                align-items: center;
            }

            .logo-a {
                color: var(--txt);
            }

            .logo-b {
                background: linear-gradient(135deg, var(--cyan), #6366f1);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .nav-a {
                font-size: 0.88rem;
                font-weight: 500;
                color: var(--txt2);
                padding: 0.4rem 0.9rem;
                border-radius: 8px;
                transition: all 0.2s var(--ease);
            }

            .nav-a:hover {
                color: var(--txt);
                background: var(--surface2);
            }

            .page {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2.5rem 1.5rem;
                position: relative;
                z-index: 1;
            }

            .auth-card {
                width: 100%;
                max-width: 420px;
                background: rgba(13, 18, 32, 0.8);
                border: 1px solid var(--border);
                border-radius: 24px;
                padding: 2.8rem;
                backdrop-filter: blur(16px);
                position: relative;
                overflow: hidden;
                box-shadow: 0 24px 80px rgba(0, 0, 0, 0.6);
                animation: slideUp 0.6s 0.1s var(--spring) both;
            }

            .auth-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 1px;
                background: linear-gradient(90deg, transparent 0%, var(--cyan) 50%, transparent 100%);
                opacity: 0.5;
            }

            .auth-card::after {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(ellipse 80% 40% at 50% 0%, rgba(0, 212, 170, 0.06), transparent 60%);
                pointer-events: none;
            }

            .card-icon {
                width: 56px;
                height: 56px;
                border-radius: 16px;
                background: rgba(0, 212, 170, 0.1);
                border: 1px solid rgba(0, 212, 170, 0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                position: relative;
                z-index: 1;
            }

            .card-h {
                font-size: 1.75rem;
                font-weight: 800;
                letter-spacing: -0.03em;
                margin-bottom: 0.4rem;
                position: relative;
                z-index: 1;
            }

            .card-sub {
                font-size: 0.9rem;
                color: var(--txt2);
                margin-bottom: 2rem;
                position: relative;
                z-index: 1;
            }

            .alert {
                padding: 0.85rem 1rem;
                border-radius: 10px;
                font-size: 0.88rem;
                margin-bottom: 1.2rem;
                display: flex;
                align-items: flex-start;
                gap: 0.6rem;
                position: relative;
                z-index: 1;
                line-height: 1.5;
            }

            .alert-success {
                background: rgba(46, 213, 115, 0.1);
                border: 1px solid rgba(46, 213, 115, 0.25);
                color: var(--green);
            }

            .alert-error {
                background: rgba(255, 71, 87, 0.1);
                border: 1px solid rgba(255, 71, 87, 0.25);
                color: var(--red);
            }

            .form {
                display: flex;
                flex-direction: column;
                gap: 1.2rem;
                position: relative;
                z-index: 1;
            }

            .field {
                display: flex;
                flex-direction: column;
                gap: 0.45rem;
            }

            label {
                font-size: 0.75rem;
                font-weight: 600;
                color: var(--txt2);
                letter-spacing: 0.07em;
                text-transform: uppercase;
            }

            .input-wrap {
                position: relative;
            }

            .input-ico {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--txt3);
                font-size: 1rem;
                pointer-events: none;
                transition: color 0.2s;
            }

            input[type="email"],
            input[type="text"] {
                width: 100%;
                background: rgba(255, 255, 255, 0.04);
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 0.8rem 1rem 0.8rem 2.8rem;
                font-family: var(--font);
                font-size: 0.95rem;
                color: var(--txt);
                outline: none;
                transition: all 0.25s var(--ease);
            }

            input::placeholder {
                color: var(--txt3);
            }

            input:focus {
                border-color: var(--cyan);
                background: rgba(0, 212, 170, 0.05);
                box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.12);
            }

            .input-wrap:focus-within .input-ico {
                color: var(--cyan);
            }

            .field-err {
                font-size: 0.76rem;
                color: var(--red);
                margin-top: 0.2rem;
                display: none;
                align-items: center;
                gap: 0.35rem;
            }

            .field-err.show {
                display: flex;
            }

            .btn-submit {
                font-family: var(--font);
                font-size: 1rem;
                font-weight: 700;
                color: var(--bg);
                background: var(--cyan);
                border: none;
                padding: 0.9rem;
                border-radius: 12px;
                width: 100%;
                cursor: pointer;
                transition: all 0.25s var(--spring);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                position: relative;
                overflow: hidden;
                margin-top: 0.4rem;
            }

            .btn-submit:hover {
                transform: translateY(-3px);
                box-shadow: 0 14px 36px rgba(0, 212, 170, 0.4);
            }

            .btn-submit:active {
                transform: translateY(-1px);
            }

            .footer-txt {
                text-align: center;
                font-size: 0.88rem;
                color: var(--txt2);
                margin-top: 1.5rem;
                position: relative;
                z-index: 1;
            }

            .footer-txt a {
                color: var(--cyan);
                font-weight: 600;
                transition: color 0.2s;
            }

            .footer-txt a:hover {
                color: #fff;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            @media (max-width:480px) {
                header {
                    padding: 0 1rem;
                }

                .auth-card {
                    padding: 2rem 1.4rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="orb orb1"></div>
        <div class="orb orb2"></div>

        <header>
            <a href="login.jsp" class="logo">
                <span class="logo-a">Ace</span><span class="logo-b">Bank</span>
            </a>
            <a href="login.jsp" class="nav-a">← Sign In</a>
        </header>

        <div class="page">
            <div class="auth-card">
                <div class="card-icon">📧</div>
                <h1 class="card-h">Recover Account</h1>
                <p class="card-sub">Enter your email and we'll send your account details.</p>

                <% String success=request.getParameter("success"); String error=request.getParameter("error"); %>
                    <% if ("true".equals(success)) { %>
                        <div class="alert alert-success">✅ If an account is associated with that email, recovery details
                            have been sent. Check your inbox!</div>
                        <% } else if ("notfound".equals(error)) { %>
                            <div class="alert alert-error">❌ No account found with that email address.</div>
                            <% } else if ("empty".equals(error)) { %>
                                <div class="alert alert-error">❌ Please enter your email address.</div>
                                <% } else if ("system".equals(error)) { %>
                                    <div class="alert alert-error">❌ A system error occurred. Please try again later.
                                    </div>
                                    <% } %>

                                        <% if (!"true".equals(success)) { %>
                                            <form class="form" action="ForgotPassword" method="POST" id="fpForm"
                                                novalidate>
                                                <div class="field">
                                                    <label for="email">Email Address</label>
                                                    <div class="input-wrap">
                                                        <input type="email" id="email" name="email"
                                                            placeholder="you@example.com" autocomplete="email">
                                                        <span class="input-ico">✉️</span>
                                                    </div>
                                                    <div class="field-err" id="emailErr"><span>⚠</span> Please enter a
                                                        valid email</div>
                                                </div>

                                                <button type="submit" class="btn-submit" id="submitBtn">
                                                    <span class="btn-lbl">Send Recovery Email</span>
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                                                        stroke="currentColor" stroke-width="2.5">
                                                        <path d="M5 12h14M12 5l7 7-7 7" />
                                                    </svg>
                                                </button>
                                            </form>
                                            <% } %>

                                                <p class="footer-txt">Remember it? <a href="login.jsp">Back to Sign
                                                        In</a></p>
            </div>
        </div>

        <script>
            const form = document.getElementById('fpForm');
            if (form) {
                const emailInput = document.getElementById('email');
                form.addEventListener('submit', function (e) {
                    const errEl = document.getElementById('emailErr');
                    emailInput.classList.remove('err');
                    errEl.classList.remove('show');
                    const valid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value.trim());
                    if (!valid) {
                        emailInput.classList.add('err');
                        errEl.classList.add('show');
                        e.preventDefault();
                        return;
                    }
                    const btn = document.getElementById('submitBtn');
                    btn.disabled = true;
                    btn.innerHTML = `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="animation:spin 0.8s linear infinite"><path d="M21 12a9 9 0 11-6.219-8.56"/></svg> Sending…`;
                });
            }
            const rs = document.createElement('style');
            rs.textContent = '@keyframes spin{to{transform:rotate(360deg);}}';
            document.head.appendChild(rs);
        </script>
    </body>

    </html>