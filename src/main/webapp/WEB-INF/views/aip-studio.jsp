<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart AIP Studio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
    <link href="/css/wholemart.css?v=project-theme-refresh-22" rel="stylesheet">
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

                        <form class="aip-chat-input" id="aipForm" action="javascript:void(0);" method="post" onsubmit="handleSendAiMessage(event);">
                            <textarea id="aipPrompt" placeholder="Write your prompt here (e.g. 'What orders need reordering?' or 'Check my pending dues')..." aria-label="Type your prompt" rows="3"></textarea>
                            <button type="submit" id="aipSendBtn" class="home-btn home-btn-primary">Send</button>
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

<script>
async function handleSendAiMessage(e) {
    if (e) e.preventDefault();
    const promptInput = document.getElementById('aipPrompt');
    const sendBtn = document.getElementById('aipSendBtn');
    const chatWindow = document.querySelector('.aip-chat-window');
    const messageText = promptInput.value.trim();

    if (!messageText) return;

    // Append User Message
    const userBubble = document.createElement('div');
    userBubble.className = 'chat-message user';
    userBubble.innerHTML = `
        <div class="chat-message-bubble" style="background: rgba(30, 58, 138, 0.08); border: 1px solid rgba(30, 58, 138, 0.2); margin-left: auto; max-width: 80%; border-radius: 12px; padding: 12px; margin-bottom: 12px;">
            <strong>You</strong>
            <p style="margin: 4px 0 0 0;">\${escapeHtml(messageText)}</p>
        </div>
    `;
    chatWindow.appendChild(userBubble);
    promptInput.value = '';
    sendBtn.disabled = true;
    chatWindow.scrollTop = chatWindow.scrollHeight;

    // Loading indicator
    const loadingBubble = document.createElement('div');
    loadingBubble.className = 'chat-message assistant';
    loadingBubble.id = 'aiLoadingBubble';
    loadingBubble.innerHTML = `
        <div class="chat-message-bubble" style="background: #f8fafc; border: 1px solid #e2e8f0; max-width: 80%; border-radius: 12px; padding: 12px; margin-bottom: 12px;">
            <strong>Assistant</strong>
            <p style="margin: 4px 0 0 0; color: #64748b;"><em>Thinking...</em></p>
        </div>
    `;
    chatWindow.appendChild(loadingBubble);
    chatWindow.scrollTop = chatWindow.scrollHeight;

    try {
        const response = await fetch('/api/v1/ai/agent/chat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ message: messageText })
        });
        const data = await response.json();
        loadingBubble.remove();

        const answer = (data && data.data && data.data.answer) || data.answer || "I'm processing your marketplace request.";

        const aiBubble = document.createElement('div');
        aiBubble.className = 'chat-message assistant';
        aiBubble.innerHTML = `
            <div class="chat-message-bubble" style="background: #f8fafc; border: 1px solid #e2e8f0; max-width: 80%; border-radius: 12px; padding: 12px; margin-bottom: 12px;">
                <strong>Assistant</strong>
                <p style="margin: 4px 0 0 0;">\${escapeHtml(answer)}</p>
            </div>
        `;
        chatWindow.appendChild(aiBubble);
    } catch (err) {
        if (loadingBubble) loadingBubble.remove();
        const errBubble = document.createElement('div');
        errBubble.className = 'chat-message assistant';
        errBubble.innerHTML = `
            <div class="chat-message-bubble" style="background: #fef2f2; border: 1px solid #fecaca; max-width: 80%; border-radius: 12px; padding: 12px; margin-bottom: 12px; color: #991b1b;">
                <strong>Assistant</strong>
                <p style="margin: 4px 0 0 0;">Unable to connect to AI service. Please try again.</p>
            </div>
        `;
        chatWindow.appendChild(errBubble);
    } finally {
        sendBtn.disabled = false;
        chatWindow.scrollTop = chatWindow.scrollHeight;
    }
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.innerText = text;
    return div.innerHTML;
}

document.getElementById('aipPrompt')?.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
        e.preventDefault();
        handleSendAiMessage(e);
    }
});
</script>
</body>
</html>
