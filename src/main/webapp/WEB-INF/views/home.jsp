<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Local B2B Marketplace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
    <link href="/css/wholemart.css?v=project-theme-refresh-32" rel="stylesheet">
</head>
<body class="wm-home">
<div class="wm-app">
    <header class="wm-topbar" role="banner">
        <div class="wm-topbar-left">
            <a class="wm-brand-link" href="/" aria-label="WholeMart home">
                <span class="wm-logo">W</span>
                <span class="wm-brand-name">WholeMart</span>
            </a>
        </div>
        <div class="wm-topbar-center">
            <input id="wm-search" class="wm-search" placeholder="Search marketplace, orders, or support..." aria-label="Search">
        </div>
        <nav class="wm-header-links" aria-label="Header quick links">
            <a class="wm-header-link" href="#impact">Impact</a>
            <a class="wm-header-link" href="#roles">Roles</a>
            <a class="wm-header-link" href="#operations">Operations</a>
            <a class="wm-header-link" href="#faq">FAQ</a>
            <a class="wm-header-link" href="/web/aip-studio" target="_blank" rel="noopener noreferrer">AI Agent</a>
        </nav>
        <div class="wm-top-actions">
            <a class="wm-btn home-btn-primary js-auth-open" data-auth-mode="login" href="/web/auth/login">Sign in</a>
        </div>
    </header>

    <main class="wm-home-main">
        <section class="wm-home-hero">
            <div class="wm-home-container">
                <div class="wm-home-hero-grid">
                    <div class="wm-home-hero-copy">
                        <span class="wm-kicker">LocalB2B AI marketplace</span>
                        <h1 class="wm-home-title">Wholesale ordering that keeps local commerce moving.</h1>
                        <p class="wm-home-subtitle">
                            WholeMart connects retailers, distributors, drivers, and admins in one live operating system for orders, inventory, payments, delivery, and AI-assisted decisions.
                        </p>
                        <div class="wm-home-actions">
                            <a class="btn btn-primary js-auth-open" data-auth-mode="register" href="/web/auth/login">Start now</a>
                            <a class="btn btn-outline-primary" href="#roles">Choose a workspace</a>
                        </div>
                        <div class="wm-home-metrics">
                            <div class="wm-home-metric">
                                <strong>4</strong>
                                <span>role-based workspaces</span>
                            </div>
                            <div class="wm-home-metric">
                                <strong>24/7</strong>
                                <span>AI action support</span>
                            </div>
                            <div class="wm-home-metric">
                                <strong>Live</strong>
                                <span>orders and delivery status</span>
                            </div>
                        </div>
                    </div>
                    <div class="wm-home-visual">
                        <img src="/images/wholemart-home-hero.png" alt="Retailer, distributor, and delivery workflow">
                        <div class="wm-home-metrics">
                            <div class="wm-home-step">
                                <b>Retailer orders</b>
                                <span>Browse distributors, compare products, and build carts quickly.</span>
                            </div>
                            <div class="wm-home-step">
                                <b>Distributor fulfills</b>
                                <span>Manage stock, dues, approvals, and driver assignment.</span>
                            </div>
                            <div class="wm-home-step">
                                <b>Driver delivers</b>
                                <span>Track delivery status, earnings, alerts, and reports.</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="wm-home-ops" id="features">
            <div class="wm-home-container">
                <div class="wm-home-section-head">
                    <h2>The Complete Wholesale OS.</h2>
                    <p>Powerful tools designed for the unique challenges of local supply chains.</p>
                </div>
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="p-3 border rounded bg-white shadow-sm h-100">
                            <h5 class="fw-bold mb-2">Smart Inventory Alerts</h5>
                            <p class="text-muted small mb-0">Get notified before stock runs out. AI suggests reorder quantities based on sales velocity.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 border rounded bg-white shadow-sm h-100">
                            <h5 class="fw-bold mb-2">Digital Credit Ledger</h5>
                            <p class="text-muted small mb-0">Track retailer dues and collections automatically. No more paper-based reconciliation errors.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 border rounded bg-white shadow-sm h-100">
                            <h5 class="fw-bold mb-2">Live Route Optimization</h5>
                            <p class="text-muted small mb-0">Efficient delivery sequencing saves fuel and ensures retailers get accurate time-of-arrival updates.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="wm-home-impact" id="impact">
            <div class="wm-home-container">
                <div class="wm-home-impact-grid">
                    <article class="wm-home-impact-card wm-home-impact-wide">
                        <span>Business lift</span>
                        <strong>38%</strong>
                        <p>average wholesale order spike reported across active retailers last month.</p>
                    </article>
                    <article class="wm-home-impact-card">
                        <span>Distributor network</span>
                        <strong>126</strong>
                        <p>verified distributors ready for local retail demand.</p>
                    </article>
                    <article class="wm-home-impact-card">
                        <span>City coverage</span>
                        <strong>42</strong>
                        <p>cities connected through local order and delivery workflows.</p>
                    </article>
                    <article class="wm-home-impact-card">
                        <span>Monthly orders</span>
                        <strong>18k+</strong>
                        <p>orders coordinated with delivery, ledger, and alert visibility.</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="wm-home-roles" id="roles">
            <div class="wm-home-container">
                <div class="wm-home-section-head">
                    <h2>One homepage, every operator's next step.</h2>
                    <p>Each workspace opens into focused tools for the daily B2B workflow, from procurement to approval queues.</p>
                </div>
                <div class="wm-home-role-grid">
                    <article class="wm-home-role-card">
                        <div class="wm-home-role-icon"><i data-lucide="shield-check"></i></div>
                        <h3>Admin</h3>
                        <p>Oversee marketplace health and keep approvals moving.</p>
                        <ul>
                            <li>User management</li>
                            <li>Order oversight</li>
                            <li>Payment and platform reports</li>
                        </ul>
                        <a class="btn btn-sm btn-outline-primary js-auth-open" data-auth-mode="login" href="/web/auth/login?role=admin">Admin login</a>
                    </article>
                    <article class="wm-home-role-card">
                        <div class="wm-home-role-icon"><i data-lucide="shopping-bag"></i></div>
                        <h3>Retailer</h3>
                        <p>Find distributors, place wholesale orders, and monitor dues.</p>
                        <ul>
                            <li>Product discovery</li>
                            <li>Cart and order tracking</li>
                            <li>Ledger and payments</li>
                        </ul>
                        <a class="btn btn-sm btn-outline-primary js-auth-open" data-auth-mode="login" href="/web/auth/login?role=retailer">Retailer login</a>
                    </article>
                    <article class="wm-home-role-card">
                        <div class="wm-home-role-icon"><i data-lucide="layout-dashboard"></i></div>
                        <h3>Distributor</h3>
                        <p>Sell into local retail demand with inventory and delivery control.</p>
                        <ul>
                            <li>Inventory management</li>
                            <li>Order fulfillment</li>
                            <li>Driver network and dues</li>
                        </ul>
                        <a class="btn btn-sm btn-outline-primary js-auth-open" data-auth-mode="login" href="/web/auth/login?role=distributor">Distributor login</a>
                    </article>
                    <article class="wm-home-role-card">
                        <div class="wm-home-role-icon"><i data-lucide="truck"></i></div>
                        <h3>Driver</h3>
                        <p>Handle assigned deliveries and keep earnings transparent.</p>
                        <ul>
                            <li>Delivery queue</li>
                            <li>Status updates</li>
                            <li>Earnings and reports</li>
                        </ul>
                        <a class="btn btn-sm btn-outline-primary js-auth-open" data-auth-mode="login" href="/web/auth/login?role=driver">Driver login</a>
                    </article>
                </div>
            </div>
        </section>

        <section class="wm-home-ops" id="how-it-works">
            <div class="wm-home-container">
                <div class="wm-home-section-head">
                    <h2>Simple steps to scale your business.</h2>
                    <p>Whether you are buying or selling, WholeMart streamlines the entire wholesale lifecycle.</p>
                </div>
                <div class="row g-4 text-center">
                    <div class="col-md-3">
                        <div class="p-4 border rounded bg-white shadow-sm h-100">
                            <div class="h1 text-primary mb-3">01</div>
                            <h4 class="fw-bold">Register</h4>
                            <p class="text-muted small">Sign up as a retailer, distributor, or driver in under 2 minutes.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-4 border rounded bg-white shadow-sm h-100">
                            <div class="h1 text-primary mb-3">02</div>
                            <h4 class="fw-bold">Connect</h4>
                            <p class="text-muted small">Browse local inventory or list your products for verified buyers.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-4 border rounded bg-white shadow-sm h-100">
                            <div class="h1 text-primary mb-3">03</div>
                            <h4 class="fw-bold">Transact</h4>
                            <p class="text-muted small">Place orders, manage digital ledgers, and track payments live.</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="p-4 border rounded bg-white shadow-sm h-100">
                            <div class="h1 text-primary mb-3">04</div>
                            <h4 class="fw-bold">Deliver</h4>
                            <p class="text-muted small">Coordinate delivery with real-time tracking and earnings reports.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="wm-home-ops" id="operations">
            <div class="wm-home-container">
                <div class="wm-home-section-head">
                    <h2>Built for the work after the order is placed.</h2>
                    <p>WholeMart keeps operational state visible: inventory, approvals, delivery status, payments, alerts, and AI-recommended actions stay connected.</p>
                </div>
                <div class="wm-home-ops-panel">
                    <div class="wm-home-ops-row">
                        <div>
                            <strong>Low stock products</strong>
                            <span>AI can draft reorder and pricing actions for review.</span>
                        </div>
                        <span class="wm-home-pill">Inventory</span>
                    </div>
                    <div class="wm-home-ops-row">
                        <div>
                            <strong>Open distributor approvals</strong>
                            <span>Admin review queues keep onboarding controlled.</span>
                        </div>
                        <span class="wm-home-pill">Approvals</span>
                    </div>
                    <div class="wm-home-ops-row">
                        <div>
                            <strong>COD and ledger visibility</strong>
                            <span>Retailers and distributors can track dues from the same system.</span>
                        </div>
                        <span class="wm-home-pill">Payments</span>
                    </div>
                    <div class="wm-home-ops-row">
                        <div>
                            <strong>Delivery assignments</strong>
                            <span>Drivers receive operational views for current and completed work.</span>
                        </div>
                        <span class="wm-home-pill">Delivery</span>
                    </div>
                </div>
            </div>
        </section>

        <section class="wm-home-impact" id="faq">
            <div class="wm-home-container">
                <div class="wm-home-section-head text-center">
                    <h2>Common Questions</h2>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="accordion" id="wmFaqAccordion">
                            <div class="accordion-item mb-3 border-0 shadow-sm rounded">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                        How does the AI Agent help my business?
                                    </button>
                                </h2>
                                <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#wmFaqAccordion">
                                    <div class="accordion-body text-muted">
                                        Our AI Assistant monitors your inventory, predicts low-stock items, analyzes sales trends, and can even draft reorder requests for you to approve with one click.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item mb-3 border-0 shadow-sm rounded">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                        Is the payment system secure?
                                    </button>
                                </h2>
                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#wmFaqAccordion">
                                    <div class="accordion-body text-muted">
                                        Yes. WholeMart uses an integrated digital ledger for all transactions. We support COD, digital payments, and track credit dues transparently between buyers and sellers.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="wm-home-footer">
        <div class="wm-home-footer-inner">
            <div><strong>WholeMart</strong> connects local B2B commerce teams from order to delivery.</div>
            <a class="js-auth-open" data-auth-mode="login" href="/web/auth/login">Continue to login</a>
        </div>
    </footer>
</div>

<div class="home-auth-modal" id="homeAuthModal" hidden>
    <div class="home-auth-backdrop js-auth-close"></div>
    <section class="home-auth-dialog" role="dialog" aria-modal="true" aria-labelledby="homeAuthTitle">
        <button class="home-auth-close js-auth-close" type="button" aria-label="Close login options">&times;</button>
        <div class="home-auth-head">
            <span class="home-logo">W</span>
            <div>
                <h2 id="homeAuthTitle">Welcome to WholeMart</h2>
                <p id="homeAuthSubtitle">Choose how you want to continue.</p>
            </div>
        </div>
        <div class="home-auth-tiles">
            <button class="home-auth-tile is-active" type="button" data-auth-choice="login">
                <strong>Login</strong>
                <span>Access your dashboard, orders, dues, and AI assistant.</span>
            </button>
            <button class="home-auth-tile" type="button" data-auth-choice="register">
                <strong>Register</strong>
                <span>Join as a retailer, distributor, driver, or admin operator.</span>
            </button>
        </div>
        <div class="home-auth-benefits" aria-label="Authentication benefits">
            <div><b>2 min</b><span>account setup</span></div>
            <div><b>4 roles</b><span>one account flow</span></div>
            <div><b>Live</b><span>orders after login</span></div>
        </div>
        <form class="home-auth-form" method="post" action="/web/auth/login">
            <label>
                <span>Name</span>
                <input name="name" placeholder="Business contact name">
            </label>
            <label>
                <span>Mobile</span>
                <input name="mobile" placeholder="Enter mobile number" required>
            </label>
            <label>
                <span>Role</span>
                <select name="role" required>
                    <option value="ROLE_RETAILER">Retailer</option>
                    <option value="ROLE_DISTRIBUTOR">Distributor</option>
                    <option value="ROLE_DRIVER">Driver</option>
                    <option value="ROLE_ADMIN">Admin</option>
                </select>
            </label>
            <div class="home-distributor-fields" hidden>
                <label>
                    <span>Business Name</span>
                    <input name="businessName" placeholder="Distributor business name">
                </label>
                <label>
                    <span>Contact Name</span>
                    <input name="contactName" placeholder="Primary contact person">
                </label>
                <label>
                    <span>Shop Name</span>
                    <input name="shopName" placeholder="Shop or outlet name">
                </label>
                <label>
                    <span>GSTIN Number</span>
                    <input name="gstin" placeholder="GSTIN number">
                </label>
                <div class="home-auth-field-row">
                    <label>
                        <span>City</span>
                        <input name="city" placeholder="City">
                    </label>
                    <label>
                        <span>State</span>
                        <input name="state" placeholder="State">
                    </label>
                </div>
                <label>
                    <span>Address</span>
                    <input name="addressLine" placeholder="Full business address">
                </label>
                <div class="home-auth-field-row">
                    <label>
                        <span>Pincode</span>
                        <input name="pincode" placeholder="Pincode">
                    </label>
                    <label>
                        <span>Alternate Mobile</span>
                        <input name="alternateMobile" placeholder="Alternate mobile">
                    </label>
                </div>
                <label>
                    <span>Email</span>
                    <input name="email" type="email" placeholder="Business email">
                </label>
                <div class="home-auth-field-row">
                    <label>
                        <span>Latitude</span>
                        <input name="latitude" type="number" step="0.000001" placeholder="0.000000">
                    </label>
                    <label>
                        <span>Longitude</span>
                        <input name="longitude" type="number" step="0.000001" placeholder="0.000000">
                    </label>
                </div>
            </div>
            <button class="home-btn home-btn-primary" type="submit" id="homeAuthSubmit">Continue</button>
        </form>
    </section>
</div>
</div>
<script src="/js/common.js?v=project-theme-refresh-21"></script>
<script>
    (() => {
        const modal = document.getElementById("homeAuthModal");
        const openers = document.querySelectorAll(".js-auth-open");
        const closers = document.querySelectorAll(".js-auth-close");
        const choices = modal.querySelectorAll("[data-auth-choice]");
        const title = modal.querySelector("#homeAuthTitle");
        const subtitle = modal.querySelector("#homeAuthSubtitle");
        const submit = modal.querySelector("#homeAuthSubmit");
        const roleSelect = modal.querySelector("select[name='role']");
        const distributorFields = modal.querySelector(".home-distributor-fields");
        const roleMap = {
            admin: "ROLE_ADMIN",
            retailer: "ROLE_RETAILER",
            distributor: "ROLE_DISTRIBUTOR",
            driver: "ROLE_DRIVER"
        };

        const setRoleFromUrl = (href) => {
            try {
                const url = new URL(href, window.location.origin);
                const role = url.searchParams.get("role");
                if (role && roleMap[role.toLowerCase()]) {
                    roleSelect.value = roleMap[role.toLowerCase()];
                }
            } catch (error) {
                roleSelect.value = "ROLE_RETAILER";
            }
        };

        let currentMode = "login";
        const distributorInputs = distributorFields.querySelectorAll("input, select, textarea");

        const setMode = (mode) => {
            currentMode = mode;
            const isRegister = mode === "register";
            title.textContent = isRegister ? "Register with WholeMart" : "Login to WholeMart";
            subtitle.textContent = isRegister
                ? "Create your business profile and continue."
                : "Verify your mobile number and continue to your workspace.";
            submit.textContent = isRegister ? "Register and continue" : "Continue";
            choices.forEach((choice) => {
                choice.classList.toggle("is-active", choice.dataset.authChoice === mode);
            });
            syncDistributorFields();
        };

        const syncDistributorFields = () => {
            const showDistributorFields = currentMode === "register" &&
                (roleSelect.value === "ROLE_DISTRIBUTOR" || roleSelect.value === "ROLE_RETAILER");
            const isRetailer = roleSelect.value === "ROLE_RETAILER";
            distributorFields.hidden = !showDistributorFields;
            distributorFields.querySelector("input[name='businessName']").closest("label").hidden = isRetailer;
            distributorFields.querySelector("input[name='contactName']").closest("label").hidden = isRetailer;
            distributorFields.querySelector("input[name='gstin']").closest("label").hidden = isRetailer;
            distributorFields.querySelector("input[name='email']").closest("label").hidden = isRetailer;
            distributorFields.querySelector("input[name='alternateMobile']").closest("label").hidden = isRetailer;
            distributorFields.querySelector("input[name='shopName']").placeholder = isRetailer ? "Retailer shop or outlet name" : "Shop or outlet name";
            distributorFields.querySelector("input[name='addressLine']").placeholder = isRetailer ? "Full retailer address" : "Full business address";
            distributorInputs.forEach((input) => {
                input.disabled = !showDistributorFields;
                if (!showDistributorFields) {
                    input.value = "";
                }
            });
        };

        const openModal = (event) => {
            event.preventDefault();
            setRoleFromUrl(event.currentTarget.href);
            setMode(event.currentTarget.dataset.authMode || "login");
            syncDistributorFields();
            modal.hidden = false;
            document.body.classList.add("home-modal-open");
            modal.querySelector("input[name='mobile']").focus();
        };

        const closeModal = () => {
            modal.hidden = true;
            document.body.classList.remove("home-modal-open");
        };

        openers.forEach((opener) => opener.addEventListener("click", openModal));
        roleSelect.addEventListener("change", syncDistributorFields);
        syncDistributorFields();
        choices.forEach((choice) => {
            choice.addEventListener("click", () => setMode(choice.dataset.authChoice));
        });
        closers.forEach((closer) => closer.addEventListener("click", closeModal));
        document.addEventListener("keydown", (event) => {
            if (event.key === "Escape" && !modal.hidden) {
                closeModal();
            }
        });
    })();
</script>
</body>
</html>
