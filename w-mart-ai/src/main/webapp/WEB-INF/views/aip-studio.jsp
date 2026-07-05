<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart AIP Studio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/wholemart.css?v=project-theme-refresh-22" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
</head>
<body class="wm-home">
<div class="home-global-container">
    <div class="home-shell">
        <header class="home-header">
            <div class="home-header-inner">
                <a class="home-brand" href="/" aria-label="WholeMart home">
                    <span class="home-logo">W</span>
                    <span>WholeMart</span>
                </a>
                <nav class="home-header-links" aria-label="Primary navigation">
                    <a class="home-btn home-btn-secondary" href="/" target="_self">Back to home</a>
                </nav>
            </div>
        </header>

        <main>
            <section class="aip-chat" aria-label="AIP Studio chat workspace">
                <div class="aip-chat-grid">
                    <aside class="aip-chat-sidebar" aria-label="AIP Studio navigation">
                        <div class="aip-chat-sidebar-title">AIP Studio</div>
                        <button class="home-btn home-btn-secondary aip-chat-new" type="button">New chat</button>
                        <div class="aip-chat-sessions">
                            <button class="aip-chat-session is-active" type="button">Supply chain assistant</button>
                            <button class="aip-chat-session" type="button">Retail reorder agent</button>
                            <button class="aip-chat-session" type="button">Delivery routing</button>
                            <button class="aip-chat-session" type="button">Cash collection</button>
                        </div>
                    </aside>

                    <div class="aip-chat-main">
                        <div class="aip-chat-topbar">
                            <div>
                                <div class="home-kicker">AIP Agent</div>
                                <h2>Chat with your marketplace intelligence assistant.</h2>
                            </div>
                        </div>

                        <div class="aip-chat-window" aria-label="AIP chat conversation">
                            <div class="chat-message assistant">
                                <div class="chat-message-bubble">
                                    <strong>Assistant</strong>
                                    <p>Welcome to AIP Studio. Type a question or prompt below to get started.</p>
                                </div>
                            </div>
                        </div>

                        <form class="aip-chat-input" action="javascript:void(0);" method="get" onsubmit="event.preventDefault();">
                            <textarea placeholder="Write your prompt here..." aria-label="Type your prompt" rows="5"></textarea>
                            <button type="button" class="home-btn home-btn-primary">Send</button>
                        </form>
                    </div>
                </div>
            </section>
        </main>

        <footer class="home-footer">
            <div class="home-footer-inner">
                <div><strong>WholeMart</strong> connects local B2B commerce teams from order to delivery.</div>
            </div>
        </footer>
    </div>
</div>
    <script src="/js/aip-studio.js"></script>
</body>
</html>
