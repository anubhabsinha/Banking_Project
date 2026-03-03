<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | AceBank</title>
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
            --glow:     rgba(0,212,170,0.28);
            --cyan:     #00d4aa;
            --cyan-dim: #00a882;
            --cyan-bg:  rgba(0,212,170,0.08);
            --red:      #ff4757;
            --green:    #2ed573;
            --orange:   #ffa502;
            --blue:     #4facfe;
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
        body {
            font-family:var(--font); background:var(--bg);
            color:var(--txt); min-height:100vh;
            overflow-x:hidden; -webkit-font-smoothing:antialiased;
        }
        body::before {
            content:''; position:fixed; inset:0;
            background-image:
                linear-gradient(rgba(0,212,170,0.018) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,212,170,0.018) 1px, transparent 1px);
            background-size:64px 64px;
            pointer-events:none; z-index:0;
        }
        .orb {
            position:fixed; border-radius:50%;
            filter:blur(110px); pointer-events:none; z-index:0;
        }
        .orb1 {
            width:500px; height:500px;
            background:radial-gradient(circle, rgba(0,212,170,0.08) 0%, transparent 70%);
            top:-100px; right:-100px;
        }
        .orb2 {
            width:400px; height:400px;
            background:radial-gradient(circle, rgba(79,172,254,0.07) 0%, transparent 70%);
            bottom:-100px; left:-80px;
        }
        ::selection { background:rgba(0,212,170,0.2); color:var(--cyan); }
        ::-webkit-scrollbar { width:4px; }
        ::-webkit-scrollbar-track { background:var(--bg2); }
        ::-webkit-scrollbar-thumb { background:var(--cyan-dim); border-radius:99px; }
        a { text-decoration:none; color:inherit; }

        /* ── HEADER ── */
        header {
            position:sticky; top:0; z-index:200;
            height:68px; padding:0 2.5rem;
            display:flex; align-items:center;
            backdrop-filter:blur(24px) saturate(180%);
            -webkit-backdrop-filter:blur(24px) saturate(180%);
            background:rgba(8,12,20,0.85);
            border-bottom:1px solid var(--border);
        }
        .hdr-inner {
            width:100%; display:flex; align-items:center; justify-content:space-between;
        }
        .logo {
            font-size:1.5rem; font-weight:800; letter-spacing:-0.04em;
            display:flex; align-items:center;
        }
        .logo-a { color:var(--txt); }
        .logo-b {
            background:linear-gradient(135deg,var(--cyan),#6366f1);
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }
        .hdr-nav { display:flex; align-items:center; gap:0.5rem; }
        .nav-a {
            font-size:0.88rem; font-weight:500; color:var(--txt2);
            padding:0.4rem 0.9rem; border-radius:8px;
            transition:all 0.2s var(--ease);
        }
        .nav-a:hover { color:var(--txt); background:var(--surface2); }
        .logout-btn {
            font-family:var(--font); font-size:0.88rem; font-weight:600;
            color:var(--red); background:rgba(255,71,87,0.08);
            border:1px solid rgba(255,71,87,0.2);
            padding:0.4rem 1rem; border-radius:8px;
            cursor:pointer; transition:all 0.2s var(--ease);
            display:flex; align-items:center; gap:0.4rem;
        }
        .logout-btn:hover {
            background:rgba(255,71,87,0.15);
            border-color:rgba(255,71,87,0.4);
            transform:translateY(-1px);
        }

        /* ── MAIN LAYOUT ── */
        .dashboard {
            max-width:1200px; margin:0 auto;
            padding:2.5rem 2rem 4rem;
            position:relative; z-index:1;
        }

        /* Welcome */
        .welcome-bar {
            display:flex; align-items:center; justify-content:space-between;
            margin-bottom:2.5rem; flex-wrap:wrap; gap:1rem;
        }
        .welcome-greet { display:flex; flex-direction:column; gap:0.4rem; }
        .welcome-greet h1 {
            font-size:clamp(1.6rem,3.5vw,2.4rem);
            font-weight:900; letter-spacing:-0.04em; line-height:1;
        }
        .welcome-greet h1 .name { color:var(--cyan); }
        .acc-badge {
            display:inline-flex; align-items:center; gap:0.5rem;
            font-family:var(--mono); font-size:0.82rem;
            color:var(--txt2); background:var(--surface);
            border:1px solid var(--border);
            padding:0.25rem 0.8rem; border-radius:6px;
        }
        .acc-badge::before {
            content:''; width:6px; height:6px; border-radius:50%;
            background:var(--green); box-shadow:0 0 6px var(--green);
            flex-shrink:0;
        }
        .welcome-meta { text-align:right; }
        .date-txt { font-size:0.85rem; color:var(--txt3); margin-bottom:0.2rem; }
        .time-txt { font-size:1.3rem; font-weight:700; font-family:var(--mono); color:var(--txt2); }

        /* ── CARDS GRID ── */
        .cards-row {
            display:grid;
            grid-template-columns:repeat(4,1fr);
            gap:1.3rem; margin-bottom:2rem;
        }

        .dash-card {
            background:rgba(13,18,32,0.7);
            border:1px solid var(--border);
            border-radius:20px; padding:1.6rem;
            backdrop-filter:blur(12px);
            box-shadow:0 4px 24px rgba(0,0,0,0.4);
            transition:all 0.3s var(--ease);
            position:relative; overflow:hidden;
        }
        .dash-card::after {
            content:''; position:absolute; inset:0;
            background:radial-gradient(ellipse 70% 40% at 50% 0%, rgba(0,212,170,0.06), transparent 65%);
            pointer-events:none;
        }
        .dash-card:hover {
            border-color:var(--glow);
            box-shadow:0 8px 40px rgba(0,212,170,0.1);
            transform:translateY(-3px);
        }

        .card-lbl {
            display:flex; align-items:center; gap:0.55rem;
            font-size:0.72rem; font-weight:700; color:var(--txt3);
            letter-spacing:0.1em; text-transform:uppercase; margin-bottom:1rem;
        }
        .card-lbl-ico {
            width:30px; height:30px; border-radius:8px;
            background:rgba(0,212,170,0.1); border:1px solid rgba(0,212,170,0.15);
            display:flex; align-items:center; justify-content:center; font-size:0.9rem;
        }

        /* Balance card */
        .balance-val {
            font-size:2rem; font-weight:900; letter-spacing:-0.04em;
            line-height:1.1; margin-bottom:0.3rem;
            font-family:var(--mono);
        }
        .balance-val span {
            background:linear-gradient(135deg, var(--txt) 30%, var(--cyan));
            -webkit-background-clip:text; -webkit-text-fill-color:transparent;
            background-clip:text;
        }
        .balance-sub { font-size:0.78rem; color:var(--txt3); }

        /* Action cards */
        .card-form { display:flex; flex-direction:column; gap:0.8rem; position:relative; z-index:1; }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width:100%; background:rgba(255,255,255,0.04);
            border:1px solid var(--border); border-radius:9px;
            padding:0.7rem 0.9rem;
            font-family:var(--font); font-size:0.9rem;
            color:var(--txt); outline:none;
            transition:all 0.22s var(--ease);
        }
        input::placeholder { color:var(--txt3); font-size:0.86rem; }
        input:focus {
            border-color:var(--cyan); background:rgba(0,212,170,0.04);
            box-shadow:0 0 0 3px rgba(0,212,170,0.1);
        }

        .btn-card {
            font-family:var(--font); font-size:0.88rem; font-weight:700;
            border:none; padding:0.7rem; border-radius:10px; width:100%;
            cursor:pointer; transition:all 0.22s var(--spring);
            display:flex; align-items:center; justify-content:center; gap:0.4rem;
            position:relative; overflow:hidden;
        }
        .btn-card:hover { transform:translateY(-2px); }
        .btn-card:active { transform:translateY(0); }

        .btn-deposit {
            background:linear-gradient(135deg, #0b3d2e, #0d5c3d);
            color:var(--green); border:1px solid rgba(46,213,115,0.2);
        }
        .btn-deposit:hover { box-shadow:0 8px 24px rgba(46,213,115,0.2); }

        .btn-transfer {
            background:linear-gradient(135deg, #0d1f4a, #1a2d6e);
            color:var(--blue); border:1px solid rgba(79,172,254,0.2);
        }
        .btn-transfer:hover { box-shadow:0 8px 24px rgba(79,172,254,0.2); }

        .btn-withdraw {
            background:linear-gradient(135deg, #3d0d15, #5c1520);
            color:var(--red); border:1px solid rgba(255,71,87,0.2);
        }
        .btn-withdraw:hover { box-shadow:0 8px 24px rgba(255,71,87,0.2); }

        /* ── TRANSACTIONS ── */
        .tx-section {
            background:rgba(13,18,32,0.7);
            border:1px solid var(--border);
            border-radius:20px; overflow:hidden;
            backdrop-filter:blur(12px);
            box-shadow:0 4px 24px rgba(0,0,0,0.4);
        }

        .tx-header {
            display:flex; align-items:center; justify-content:space-between;
            padding:1.4rem 1.8rem; border-bottom:1px solid var(--border);
        }
        .tx-header h2 { font-size:1rem; font-weight:700; }

        .tx-toolbar { display:flex; gap:0.6rem; align-items:center; }

        .btn-csv {
            font-family:var(--font); font-size:0.82rem; font-weight:600;
            color:var(--cyan); background:var(--cyan-bg);
            border:1px solid rgba(0,212,170,0.2);
            padding:0.4rem 1rem; border-radius:8px;
            cursor:pointer; transition:all 0.2s var(--ease);
            display:flex; align-items:center; gap:0.4rem;
        }
        .btn-csv:hover { background:rgba(0,212,170,0.14); border-color:var(--glow); }

        .search-bar {
            position:relative; display:flex; align-items:center;
        }
        .search-ico { position:absolute; left:0.8rem; color:var(--txt3); font-size:0.9rem; pointer-events:none; }
        .search-bar input {
            background:var(--surface); border:1px solid var(--border);
            border-radius:8px; padding:0.4rem 0.9rem 0.4rem 2.4rem;
            width:200px; font-size:0.85rem; color:var(--txt);
        }
        .search-bar input:focus { border-color:var(--cyan); box-shadow:0 0 0 2px rgba(0,212,170,0.1); }

        /* Filter tabs */
        .filter-tabs {
            display:flex; gap:0.4rem; padding:0.9rem 1.8rem;
            border-bottom:1px solid var(--border);
            overflow-x:auto;
        }
        .filter-tab {
            font-family:var(--font); font-size:0.8rem; font-weight:600;
            padding:0.3rem 0.9rem; border-radius:99px;
            border:1px solid var(--border); background:transparent;
            color:var(--txt2); cursor:pointer;
            transition:all 0.2s var(--ease); white-space:nowrap;
        }
        .filter-tab.active {
            background:var(--cyan-bg); border-color:rgba(0,212,170,0.3);
            color:var(--cyan);
        }
        .filter-tab:hover:not(.active) { border-color:var(--glow); color:var(--txt); }

        /* Table */
        .tx-table { width:100%; border-collapse:collapse; }
        .tx-table thead th {
            font-family:var(--mono); font-size:0.68rem; font-weight:500;
            letter-spacing:0.1em; text-transform:uppercase; color:var(--txt3);
            background:rgba(255,255,255,0.02);
            padding:0.8rem 1.8rem; text-align:left;
            border-bottom:1px solid var(--border);
        }
        .tx-table tbody tr {
            border-bottom:1px solid rgba(255,255,255,0.04);
            transition:background 0.18s var(--ease);
        }
        .tx-table tbody tr:last-child { border-bottom:none; }
        .tx-table tbody tr:hover { background:rgba(255,255,255,0.03); }
        .tx-table tbody td {
            padding:0.95rem 1.8rem; font-size:0.9rem; color:var(--txt2);
            vertical-align:middle;
        }
        .tx-table tbody td:first-child { font-family:var(--mono); font-size:0.8rem; color:var(--txt3); }
        .tx-table tbody td:last-child { font-family:var(--mono); font-weight:600; color:var(--txt); }

        /* Badges */
        .badge {
            display:inline-flex; align-items:center; gap:0.35rem;
            font-size:0.68rem; font-weight:700; letter-spacing:0.08em;
            text-transform:uppercase; padding:0.22rem 0.65rem;
            border-radius:99px;
        }
        .badge::before { content:''; width:5px; height:5px; border-radius:50%; flex-shrink:0; }

        .badge-deposit  { background:rgba(46,213,115,0.12); color:var(--green); border:1px solid rgba(46,213,115,0.22); }
        .badge-deposit::before { background:var(--green); }
        .badge-withdrawal { background:rgba(255,71,87,0.12); color:var(--red); border:1px solid rgba(255,71,87,0.22); }
        .badge-withdrawal::before { background:var(--red); }
        .badge-transfer { background:rgba(79,172,254,0.12); color:var(--blue); border:1px solid rgba(79,172,254,0.22); }
        .badge-transfer::before { background:var(--blue); }

        .ref-text { font-family:var(--mono); font-size:0.8rem; color:var(--txt3); }
        .remark-text { font-size:0.85rem; color:var(--txt2); }

        /* Amount coloring */
        .amt-credit { color:var(--green) !important; }
        .amt-debit  { color:var(--red) !important; }

        .tx-empty {
            text-align:center; padding:4rem 2rem;
            color:var(--txt3); font-size:0.95rem;
        }
        .tx-empty-ico { font-size:2.5rem; margin-bottom:0.75rem; opacity:0.4; display:block; }

        /* ── TOAST ── */
        .toast-container { position:fixed; bottom:2rem; right:2rem; z-index:9999; display:flex; flex-direction:column; gap:0.6rem; }
        .toast {
            padding:1rem 1.4rem; border-radius:14px;
            background:rgba(13,18,32,0.95); border:1px solid var(--border);
            backdrop-filter:blur(16px);
            display:flex; align-items:center; gap:0.75rem;
            font-size:0.9rem; box-shadow:0 12px 40px rgba(0,0,0,0.5);
            animation:toastIn 0.35s var(--spring) both;
            max-width:320px; pointer-events:auto;
        }
        .toast-ico { font-size:1rem; flex-shrink:0; }
        .toast-close { margin-left:auto; background:none; border:none; color:var(--txt3); cursor:pointer; font-size:1rem; padding:0; }

        /* ── CONFIRM MODAL ── */
        .modal-overlay {
            position:fixed; inset:0; z-index:500;
            background:rgba(0,0,0,0.7); backdrop-filter:blur(6px);
            display:flex; align-items:center; justify-content:center;
            padding:1.5rem;
            opacity:0; pointer-events:none; transition:opacity 0.25s;
        }
        .modal-overlay.show { opacity:1; pointer-events:all; }
        .modal {
            background:var(--bg2); border:1px solid var(--border);
            border-radius:20px; padding:2rem; max-width:400px; width:100%;
            box-shadow:0 24px 80px rgba(0,0,0,0.7);
            transform:scale(0.9) translateY(20px);
            transition:transform 0.3s var(--spring);
        }
        .modal-overlay.show .modal { transform:scale(1) translateY(0); }
        .modal-ico { font-size:2.5rem; text-align:center; margin-bottom:1rem; }
        .modal-h { font-size:1.2rem; font-weight:700; text-align:center; margin-bottom:0.5rem; }
        .modal-txt { font-size:0.9rem; color:var(--txt2); text-align:center; line-height:1.6; margin-bottom:1.8rem; }
        .modal-txt strong { color:var(--txt); }
        .modal-actions { display:flex; gap:0.75rem; }
        .modal-cancel {
            flex:1; font-family:var(--font); font-size:0.92rem; font-weight:600;
            color:var(--txt2); background:var(--surface); border:1px solid var(--border);
            border-radius:10px; padding:0.75rem; cursor:pointer;
            transition:all 0.2s var(--ease);
        }
        .modal-cancel:hover { color:var(--txt); background:var(--surface2); }
        .modal-confirm {
            flex:1; font-family:var(--font); font-size:0.92rem; font-weight:700;
            color:var(--bg); background:var(--red); border:none;
            border-radius:10px; padding:0.75rem; cursor:pointer;
            transition:all 0.2s var(--spring);
        }
        .modal-confirm:hover { transform:translateY(-2px); box-shadow:0 8px 24px rgba(255,71,87,0.4); }

        /* ── ANIMATIONS ── */
        @keyframes toastIn {
            from { opacity:0; transform:translateX(30px) scale(0.9); }
            to { opacity:1; transform:translateX(0) scale(1); }
        }
        @keyframes toastOut {
            to { opacity:0; transform:translateX(40px) scale(0.9); }
        }
        @keyframes countUp {
            from { opacity:0; transform:translateY(8px); }
            to { opacity:1; transform:translateY(0); }
        }
        @keyframes fadeDash {
            from { opacity:0; transform:translateY(20px); }
            to { opacity:1; transform:translateY(0); }
        }
        @keyframes spin { to { transform:rotate(360deg); } }
        @keyframes rippleOut { to { transform:scale(1); opacity:0; } }

        .cards-row { animation:fadeDash 0.6s 0.1s var(--ease) both; }
        .tx-section { animation:fadeDash 0.6s 0.25s var(--ease) both; }
        .welcome-bar { animation:fadeDash 0.6s 0.05s var(--ease) both; }

        /* ── RESPONSIVE ── */
        @media (max-width:1100px) { .cards-row { grid-template-columns:1fr 1fr; } }
        @media (max-width:680px) {
            .cards-row { grid-template-columns:1fr; }
            .dashboard { padding:1.5rem 1rem 3rem; }
            header { padding:0 1rem; }
            .tx-header { flex-direction:column; align-items:flex-start; gap:0.75rem; }
            .tx-toolbar { width:100%; }
            .search-bar input { width:100%; }
        }
    </style>
</head>
<body>
<div class="orb orb1"></div>
<div class="orb orb2"></div>

<!-- ══ HEADER ══ -->
<header>
    <div class="hdr-inner">
        <div class="logo"><span class="logo-a">Ace</span><span class="logo-b">Bank</span></div>
        <nav class="hdr-nav">
            <a href="ChangePassword.jsp" class="nav-a">🔑 Reset Password</a>
            <a href="Logout" class="logout-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4M16 17l5-5-5-5M21 12H9"/></svg>
                Logout
            </a>
        </nav>
    </div>
</header>

<!-- ══ DASHBOARD ══ -->
<main class="dashboard">

    <!-- Welcome -->
    <div class="welcome-bar">
        <div class="welcome-greet">
            <h1>Hello, <span class="name">${sessionScope.firstName}</span> 👋</h1>
            <span class="acc-badge">${sessionScope.accountNumber}</span>
        </div>
        <div class="welcome-meta">
            <div class="date-txt" id="dateStr"></div>
            <div class="time-txt" id="timeTxt"></div>
        </div>
    </div>

    <!-- Cards -->
    <div class="cards-row">

        <%-- Balance Card --%>
        <div class="dash-card" style="border-color:rgba(0,212,170,0.18);">
            <div class="card-lbl">
                <div class="card-lbl-ico">💳</div>
                Total Balance
            </div>
            <div class="balance-val">
                <span>₹ <span id="balanceDisplay">${sessionScope.balance}</span></span>
            </div>
            <div class="balance-sub" style="margin-top:0.4rem;">Available for withdrawal</div>
        </div>

        <%-- Deposit --%>
        <div class="dash-card">
            <div class="card-lbl">
                <div class="card-lbl-ico" style="background:rgba(46,213,115,0.1);">⬇</div>
                Quick Deposit
            </div>
            <form action="home" method="post" class="card-form" id="depositForm">
                <input type="text" name="deposit" placeholder="Amount to Add (₹)"
                       pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required/>
                <button type="button" class="btn-card btn-deposit" onclick="confirmAction('deposit')">
                    + Add to Balance
                </button>
            </form>
        </div>

        <%-- Transfer --%>
        <div class="dash-card">
            <div class="card-lbl">
                <div class="card-lbl-ico" style="background:rgba(79,172,254,0.1);">↗</div>
                Send Money
            </div>
            <form action="home" method="post" class="card-form" id="transferForm">
                <input type="text" name="toAccount" placeholder="Recipient Account No" required/>
                <input type="text" name="toAmount" placeholder="Amount (₹)"
                       pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required/>
                <button type="button" class="btn-card btn-transfer" onclick="confirmAction('transfer')">
                    Transfer Now →
                </button>
            </form>
        </div>

        <%-- Withdraw --%>
        <div class="dash-card">
            <div class="card-lbl">
                <div class="card-lbl-ico" style="background:rgba(255,71,87,0.1);">⬆</div>
                Withdraw
            </div>
            <form action="home" method="post" class="card-form" id="withdrawForm">
                <input type="text" name="withdraw" placeholder="Amount to Withdraw (₹)"
                       pattern="[0-9]*\.?[0-9]+" inputmode="decimal" required/>
                <button type="button" class="btn-card btn-withdraw" onclick="confirmAction('withdraw')">
                    Withdraw Now
                </button>
            </form>
        </div>

    </div>

    <!-- ══ TRANSACTIONS ══ -->
    <div class="tx-section">
        <div class="tx-header">
            <h2>Recent Transactions</h2>
            <div class="tx-toolbar">
                <div class="search-bar">
                    <span class="search-ico">🔍</span>
                    <input type="text" id="txSearch" placeholder="Search…">
                </div>
                <button class="btn-csv" onclick="downloadCSV()">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3"/></svg>
                    CSV
                </button>
            </div>
        </div>

        <div class="filter-tabs">
            <button class="filter-tab active" data-filter="all">All</button>
            <button class="filter-tab" data-filter="deposit">Deposits</button>
            <button class="filter-tab" data-filter="withdrawal">Withdrawals</button>
            <button class="filter-tab" data-filter="transfer">Transfers</button>
        </div>

        <table class="tx-table" id="txTable">
            <thead>
                <tr>
                    <th>Date & Time</th>
                    <th>Type</th>
                    <th>Reference</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody id="txBody">
                <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
                    <tr data-type="${tx.txType().toLowerCase()}">
                        <td>${tx.createdAt()}</td>
                        <td>
                            <span class="badge badge-${tx.txType().toLowerCase()}">${tx.txType()}</span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${tx.txType() == 'TRANSFER'}">
                                    <span class="ref-text">
                                        ${tx.senderAccount() == sessionScope.accountNumber ? '↗ To' : '↙ From'}
                                        ${tx.senderAccount() == sessionScope.accountNumber ? tx.receiverAccount() : tx.senderAccount()}
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="remark-text">${tx.remark()}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="${tx.txType() == 'DEPOSIT' ? 'amt-credit' : 'amt-debit'}">
                            ${tx.txType() == 'DEPOSIT' ? '+' : '-'}₹${tx.amount()}
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty sessionScope.transactionDetailsList}">
            <div class="tx-empty">
                <span class="tx-empty-ico">📋</span>
                No transactions yet — make your first deposit!
            </div>
        </c:if>
    </div>

</main>

<!-- ══ CONFIRM MODAL ══ -->
<div class="modal-overlay" id="modalOverlay">
    <div class="modal">
        <div class="modal-ico" id="modalIco">⚠️</div>
        <div class="modal-h" id="modalH">Confirm Action</div>
        <p class="modal-txt" id="modalTxt">Are you sure?</p>
        <div class="modal-actions">
            <button class="modal-cancel" onclick="closeModal()">Cancel</button>
            <button class="modal-confirm" id="modalConfirmBtn" onclick="doConfirm()">Confirm</button>
        </div>
    </div>
</div>

<!-- ══ TOAST CONTAINER ══ -->
<div class="toast-container" id="toastContainer"></div>

<script>
// ── Clock ──
function updateClock() {
    const now = new Date();
    document.getElementById('dateStr').textContent = now.toLocaleDateString('en-IN', {weekday:'long', day:'numeric', month:'long', year:'numeric'});
    document.getElementById('timeTxt').textContent = now.toLocaleTimeString('en-IN', {hour:'2-digit', minute:'2-digit', second:'2-digit', hour12:true});
}
updateClock();
setInterval(updateClock, 1000);

// ── Balance counter animation ──
function animateBalance(el, target) {
    const start = performance.now();
    const duration = 1600;
    const fmt = v => v.toLocaleString('en-IN', {minimumFractionDigits:2, maximumFractionDigits:2});
    function tick(now) {
        const p = Math.min((now - start) / duration, 1);
        const ease = 1 - Math.pow(1-p, 4);
        el.textContent = fmt(ease * target);
        if (p < 1) requestAnimationFrame(tick);
    }
    requestAnimationFrame(tick);
}
const balEl = document.getElementById('balanceDisplay');
if (balEl) {
    const raw = parseFloat(balEl.textContent.replace(/[^0-9.]/g,''));
    if (!isNaN(raw)) {
        balEl.textContent = '0.00';
        setTimeout(() => animateBalance(balEl, raw), 400);
    }
}

// ── Filter tabs ──
document.querySelectorAll('.filter-tab').forEach(tab => {
    tab.addEventListener('click', function() {
        document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
        this.classList.add('active');
        const filter = this.dataset.filter;
        document.querySelectorAll('#txBody tr').forEach(row => {
            const type = row.dataset.type;
            row.style.display = (filter === 'all' || type === filter) ? '' : 'none';
        });
    });
});

// ── Search ──
document.getElementById('txSearch').addEventListener('input', function() {
    const q = this.value.toLowerCase();
    document.querySelectorAll('#txBody tr').forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
});

// ── Modal system ──
let pendingForm = null;
function confirmAction(type) {
    const configs = {
        deposit: {
            ico:'💰', h:'Confirm Deposit', confirm:'Add to Balance',
            getMsg: () => {
                const v = document.querySelector('[name="deposit"]').value;
                return v ? `Add <strong>₹${parseFloat(v).toLocaleString('en-IN')}</strong> to your balance?` : null;
            },
            form: 'depositForm', color:'var(--green)'
        },
        transfer: {
            ico:'↗️', h:'Confirm Transfer', confirm:'Transfer Now',
            getMsg: () => {
                const acc = document.querySelector('[name="toAccount"]').value;
                const amt = document.querySelector('[name="toAmount"]').value;
                return (acc && amt) ? `Transfer <strong>₹${parseFloat(amt).toLocaleString('en-IN')}</strong> to account <strong>${acc}</strong>?` : null;
            },
            form: 'transferForm', color:'var(--blue)'
        },
        withdraw: {
            ico:'⬆️', h:'Confirm Withdrawal', confirm:'Withdraw',
            getMsg: () => {
                const v = document.querySelector('[name="withdraw"]').value;
                return v ? `Withdraw <strong>₹${parseFloat(v).toLocaleString('en-IN')}</strong> from your account?` : null;
            },
            form: 'withdrawForm', color:'var(--red)'
        }
    };
    const cfg = configs[type];
    if (!cfg) return;
    const msg = cfg.getMsg();
    if (!msg) { showToast('Please fill in the amount', 'warn'); return; }
    document.getElementById('modalIco').textContent = cfg.ico;
    document.getElementById('modalH').textContent = cfg.h;
    document.getElementById('modalTxt').innerHTML = msg;
    document.getElementById('modalConfirmBtn').style.background = cfg.color;
    document.getElementById('modalConfirmBtn').style.color = type === 'deposit' ? 'var(--bg)' : '#fff';
    pendingForm = document.getElementById(cfg.form);
    document.getElementById('modalOverlay').classList.add('show');
}
function closeModal() {
    document.getElementById('modalOverlay').classList.remove('show');
    pendingForm = null;
}
function doConfirm() {
    if (pendingForm) {
        closeModal();
        const btn = pendingForm.querySelector('button[type="button"]');
        if (btn) { btn.disabled = true; btn.innerHTML = `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" style="animation:spin 0.8s linear infinite"><path d="M21 12a9 9 0 11-6.219-8.56"/></svg> Processing…`; }
        setTimeout(() => pendingForm.submit(), 300);
    }
}
document.getElementById('modalOverlay').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
});
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

// ── Toast system ──
function showToast(msg, type='info') {
    const cfg = {
        info:   {ico:'ℹ️', border:'rgba(79,172,254,0.3)'},
        success:{ico:'✅', border:'rgba(46,213,115,0.3)'},
        warn:   {ico:'⚠️', border:'rgba(255,165,2,0.3)'},
        error:  {ico:'❌', border:'rgba(255,71,87,0.3)'},
    }[type] || {ico:'ℹ️', border:'rgba(255,255,255,0.1)'};
    const t = document.createElement('div');
    t.className = 'toast';
    t.style.borderColor = cfg.border;
    t.innerHTML = `<span class="toast-ico">${cfg.ico}</span><span style="flex:1">${msg}</span><button class="toast-close" onclick="this.parentElement.remove()">×</button>`;
    document.getElementById('toastContainer').appendChild(t);
    setTimeout(() => { t.style.animation = 'toastOut 0.3s ease forwards'; setTimeout(() => t.remove(), 320); }, 4000);
}
window.showToast = showToast;

// ── CSV download ──
function downloadCSV() {
    const table = document.getElementById('txTable');
    if (!table) return;
    const rows = [...table.querySelectorAll('tr')].map(r =>
        [...r.querySelectorAll('th,td')].map(c => '"' + c.innerText.trim().replace(/"/g,'""') + '"').join(',')
    );
    const a = document.createElement('a');
    a.href = 'data:text/csv;charset=utf-8,' + encodeURIComponent(rows.join('\n'));
    a.download = `acebank-transactions-${new Date().toISOString().slice(0,10)}.csv`;
    a.click();
    showToast('Transactions downloaded!', 'success');
}

// ── Ripple on card buttons ──
document.querySelectorAll('.btn-card,.btn-csv,.logout-btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const r = this.getBoundingClientRect();
        const sz = Math.max(r.width, r.height) * 2;
        const rp = document.createElement('span');
        rp.style.cssText = `position:absolute;border-radius:50%;pointer-events:none;
            width:${sz}px;height:${sz}px;
            left:${e.clientX-r.left-sz/2}px;top:${e.clientY-r.top-sz/2}px;
            background:rgba(255,255,255,0.12);transform:scale(0);
            animation:rippleOut 0.65s ease-out forwards;`;
        this.style.position = 'relative';
        this.style.overflow = 'hidden';
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
