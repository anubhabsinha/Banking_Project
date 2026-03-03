<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Failed | AceBank</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500&display=swap"
            rel="stylesheet">
        <style>
            :root {
                --bg: #080c14;
                --bg2: #0d1220;
                --surface: rgba(255, 255, 255, 0.04);
                --border: rgba(255, 255, 255, 0.08);
                --cyan: #00d4aa;
                --cyan-dim: #00a882;
                --red: #ff4757;
                --txt: #edf2f7;
                --txt2: #8892a4;
                --txt3: #4a5568;
                --font: 'Outfit', sans-serif;
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

            body {
                font-family: var(--font);
                background: var(--bg);
                color: var(--txt);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                -webkit-font-smoothing: antialiased;
            }

            body::before {
                content: '';
                position: fixed;
                inset: 0;
                background-image: linear-gradient(rgba(0, 212, 170, 0.025) 1px, transparent 1px),
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
                background: radial-gradient(circle, rgba(255, 71, 87, 0.12) 0%, transparent 70%);
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

            .page {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem 1.5rem;
                position: relative;
                z-index: 1;
            }

            .card {
                width: 100%;
                max-width: 420px;
                background: rgba(13, 18, 32, 0.85);
                border: 1px solid rgba(255, 71, 87, 0.2);
                border-radius: 24px;
                padding: 3rem 2.8rem;
                backdrop-filter: blur(16px);
                box-shadow: 0 24px 80px rgba(0, 0, 0, 0.6), 0 0 40px rgba(255, 71, 87, 0.05);
                text-align: center;
                position: relative;
                overflow: hidden;
                animation: slideUp 0.6s 0.1s var(--spring) both;
            }

            .card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 1px;
                background: linear-gradient(90deg, transparent, var(--red) 50%, transparent);
                opacity: 0.5;
            }

            .card::after {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(ellipse 80% 40% at 50% 0%, rgba(255, 71, 87, 0.06), transparent 60%);
                pointer-events: none;
            }

            .err-ico {
                font-size: 3.5rem;
                margin-bottom: 1.2rem;
                display: block;
                position: relative;
                z-index: 1;
                animation: shake 0.5s 0.3s ease both;
            }

            .card-h {
                font-size: 1.8rem;
                font-weight: 900;
                letter-spacing: -0.03em;
                margin-bottom: 0.6rem;
                position: relative;
                z-index: 1;
            }

            .card-sub {
                font-size: 0.95rem;
                color: var(--txt2);
                line-height: 1.65;
                margin-bottom: 2rem;
                position: relative;
                z-index: 1;
            }

            .btn-primary {
                font-family: var(--font);
                font-size: 1rem;
                font-weight: 700;
                color: var(--bg);
                background: var(--cyan);
                border: none;
                padding: 0.9rem 2rem;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.25s var(--spring);
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                text-decoration: none;
                position: relative;
                z-index: 1;
            }

            .btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 14px 36px rgba(0, 212, 170, 0.4);
            }

            .btn-ghost {
                font-family: var(--font);
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--txt2);
                background: transparent;
                border: 1px solid var(--border);
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                cursor: pointer;
                transition: all 0.2s var(--ease);
                display: inline-flex;
                align-items: center;
                text-decoration: none;
                margin-top: 0.75rem;
                position: relative;
                z-index: 1;
            }

            .btn-ghost:hover {
                border-color: rgba(255, 255, 255, 0.2);
                color: var(--txt);
            }

            .actions {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 0;
                position: relative;
                z-index: 1;
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

            @keyframes shake {

                0%,
                100% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-8px);
                }

                75% {
                    transform: translateX(8px);
                }
            }

            @media(max-width:480px) {
                header {
                    padding: 0 1rem;
                }

                .card {
                    padding: 2rem 1.4rem;
                }
            }
        </style>
    </head>

    <body>
        <div class="orb orb1"></div>
        <div class="orb orb2"></div>
        <header>
            <a href="index.jsp" class="logo">
                <span class="logo-a">Ace</span><span class="logo-b">Bank</span>
            </a>
        </header>
        <div class="page">
            <div class="card">
                <span class="err-ico">🚫</span>
                <h1 class="card-h">Login Failed</h1>
                <p class="card-sub">The account number or password you entered is incorrect. Please double-check your
                    credentials and try again.</p>
                <div class="actions">
                    <a href="login.jsp" class="btn-primary">
                        Try Again
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2.5">
                            <path d="M5 12h14M12 5l7 7-7 7" />
                        </svg>
                    </a>
                    <a href="ForgotPassword.jsp" class="btn-ghost">Forgot Password?</a>
                </div>
            </div>
        </div>
    </body>

    </html>