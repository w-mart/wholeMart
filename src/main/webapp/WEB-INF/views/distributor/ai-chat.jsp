<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Distributor Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap"
        rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ai-chat.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body class="wm-page-background">
    <% String wmUserName = session.getAttribute("name") == null ? "Guest" : String.valueOf(session.getAttribute("name"));
       List<String> suggestedQuestions = List.of(
                "Show today's order summary",
                "Show low stock products",
                "Show pending retailer payments"
            );
    %>

    <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

    <main class="wm-app">
        <div class="wm-chat-container">
            <div class="wm-chat-grid">

                <!-- Sidebar for conversations -->
                <aside class="wm-chat-sidebar">
                    <div class="wm-chat-sidebar-header">
                        <h4 class="mb-0">Conversations</h4>
                        <button id="newChatBtn" class="btn btn-sm btn-primary" title="New Chat">
                            <i class="bi bi-plus-lg"></i>
                        </button>
                    </div>

                    <div id="conversationList" class="wm-chat-list">
                        <div class="p-3 text-muted small">Loading chats...</div>
                    </div>

                    <div class="wm-chat-sidebar-footer">
                        <span class="wm-text-muted">Tip:</span> Ask about inventory, orders, retailers, payments.
                    </div>
                </aside>

                <!-- Main chat panel -->
                <div class="wm-chat-main">
                    <section class="wm-card wm-ai-panel">
                        <div class="navbar-brand wm-logo-wrap"
                            href="${pageContext.request.contextPath}/web/distributor/dashboard">
                            <div class="wm-logo-circle">W</div>
                            <div class="wm-logo-line">
                                <div class="wm-logo-title">WholeMart AI</div>
                                <small style="color: var(--wm-ink-soft);">Ask about inventory, orders, retailers, payments, and business insights.</small>
                            </div>
                        </div>
                        <hr>

                        <div class="wm-chat-log">
                            <div id="chatLog" class="wm-ai-response wm-chat-log">
                                <div class="wm-chat-message">
                                    <div class="wm-chat-avatar">AI</div>
                                    <div class="wm-chat-bubble">
                                        Welcome <strong><%= wmUserName %></strong> 👋
                                        <br><br>
                                        I'm ready to help you with your distributor business. Pick a conversation or start a new one.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="wm-ai-chips" aria-label="Quick suggestions">
                            <% for (String q : suggestedQuestions) { %>
                                <button class="wm-ai-chip" type="button" data-ai-message="<%= q.replace("\"", "\\\"") %>"><%= q %></button>
                            <% } %>
                        </div>

                        <form id="chatForm" class="mt-3">
                            <div class="input-group">
                                <input id="chatInput" type="text" class="form-control"
                                    placeholder="Ask WholeMart AI anything..." autocomplete="off" required>
                                <button class="home-btn home-btn-primary" type="submit">
                                    <i class="bi bi-send"></i> Ask
                                </button>
                            </div>
                        </form>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/common/footer.jsp" %>

    <script>
        $(function () {
            const contextPath = '${pageContext.request.contextPath}';

            window.wmCurrentConversationId = null;

            const $chatForm = $('#chatForm');
            const $chatInput = $('#chatInput');
            const $chatLog = $('#chatLog');
            const $conversationList = $('#conversationList');
            const $newChatBtn = $('#newChatBtn');

            function escapeHtml(str) {
                return String(str)
                    .replaceAll('&', '&amp;')
                    .replaceAll('<', '&lt;')
                    .replaceAll('>', '&gt;')
                    .replaceAll('"', '&quot;')
                    .replaceAll("'", '&#039;');
            }

            function formatUpdatedAt(updatedAt) {
                try {
                    if (!updatedAt) return '-';
                    const d = new Date(updatedAt);
                    if (isNaN(d.getTime())) return '-';
                    return d.toLocaleString();
                } catch (e) {
                    return '-';
                }
            }

            function renderMessage(sender, text, extra) {
                const isUser = sender === 'USER';
                const avatarHtml = isUser
                    ? '<div class="wm-chat-avatar is-user"><i class="bi bi-person"></i></div>'
                    : '<div class="wm-chat-avatar">AI</div>';

                const badgeHtml = (extra && extra.toolUsed)
                    ? '<div class="wm-chat-title" style="margin-bottom:6px">Tool: ' + escapeHtml(extra.toolUsed) + '</div>'
                    : '';

                const $message = $('<div class="wm-chat-message"></div>');
                if (isUser) $message.addClass('is-user');
                $message.html(avatarHtml + '<div class="wm-chat-bubble">' + badgeHtml + text + '</div>');

                $chatLog.append($message);
                $chatLog.scrollTop($chatLog[0].scrollHeight);

                return $message;
            }

            function setActiveConversation(id) {
                window.wmCurrentConversationId = id;
                $('[data-conversation-id]').each(function () {
                    const $el = $(this);
                    $el.toggleClass('active', String($el.data('conversationId')) === String(id));
                });
            }

            function createConversation() {
                return $.ajax({
                    url: contextPath + '/api/v1/ai/conversations',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ title: 'AI Chat' })
                }).then(function (data) {
                    if (!data || !data.conversation || !data.conversation.id) {
                        return $.Deferred().reject('Failed to create conversation').promise();
                    }
                    return data.conversation.id;
                });
            }

            function ensureConversation() {
                if (window.wmCurrentConversationId) {
                    return $.Deferred().resolve(window.wmCurrentConversationId).promise();
                }
                return createConversation().then(function (id) {
                    setActiveConversation(id);
                    return id;
                });
            }

            function loadConversations() {
                $conversationList.html('<div class="p-3 text-muted small">Loading chats...</div>');

                return $.getJSON(contextPath + '/api/v1/ai/conversations?limit=50')
                    .then(function (data) {
                        const conversations = (data && data.conversations) ? data.conversations : [];

                        if (!conversations.length) {
                            $conversationList.html('<div class="p-3 text-muted small">No conversations yet. Click New Chat.</div>');
                            return;
                        }

                        $conversationList.empty();

                        conversations.forEach(function (c) {
                            const isActive = String(c.id) === String(window.wmCurrentConversationId);
                            const $item = $('<div class="wm-chat-list-item"></div>');
                            if (isActive) $item.addClass('active');
                            $item.attr('data-conversation-id', c.id);
                            $item.html(
                                '<i class="bi bi-chat-dots"></i>' +
                                '<div>' +
                                '<div class="wm-history-title">' + escapeHtml(c.title || 'AI Chat') + '</div>' +
                                '<div class="wm-history-date">' + escapeHtml(formatUpdatedAt(c.updatedAt)) + '</div>' +
                                '</div>'
                            );

                            $item.on('click', function () {
                                setActiveConversation(c.id);
                                loadMessages(c.id);
                            });

                            $conversationList.append($item);
                        });

                        // Select the first conversation by default
                        if (!window.wmCurrentConversationId) {
                            setActiveConversation(conversations[0].id);
                            loadMessages(conversations[0].id);
                        }
                    })
                    .catch(function (err) {
                        $conversationList.html('<div class="p-3 text-danger small">Failed to load conversations.</div>');
                        console.error(err);
                    });
            }

            function loadMessages(conversationId) {
                $chatLog.empty();
                renderMessage('ASSISTANT', 'Loading conversation...');

                return $.getJSON(contextPath + '/api/v1/ai/conversations/' + conversationId + '/messages?limit=20')
                    .then(function (data) {
                        const messages = (data && data.messages) ? data.messages : [];

                        $chatLog.empty();

                        if (!messages.length) {
                            renderMessage('ASSISTANT', 'No messages yet. Ask a question to start.');
                            return;
                        }

                        // Defensive sort: guarantees each user message renders above the
                        // assistant reply that answers it, even if the backend response
                        // isn't strictly ordered by createdAt.
                        const sortedMessages = messages.slice().sort(function (a, b) {
                            const aTime = new Date(a.createdAt || a.updatedAt || 0).getTime();
                            const bTime = new Date(b.createdAt || b.updatedAt || 0).getTime();
                            return aTime - bTime;
                        });

                        sortedMessages.forEach(function (m) {
                            const role = (m.role || '').toLowerCase();
                            const sender = role === 'user' ? 'USER' : 'ASSISTANT';
                            const toolUsed = m.toolUsed || null;
                            const text = String(m.message || '');
                            renderMessage(sender, text.replace(/\n/g, '<br>'), { toolUsed: toolUsed });
                        });
                    });
            }

            function sendMessage(message) {
                if (!message) return;

                ensureConversation().then(function (conversationId) {
                    renderMessage('USER', escapeHtml(message));
                    $chatInput.val('');
                    const $thinkingMsg = renderMessage('ASSISTANT', 'Thinking...');

                    $.ajax({
                        url: contextPath + '/api/v1/ai/agent/chat',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            conversationId: conversationId,
                            message: message
                        })
                    }).done(function (data) {
                        const $bubble = $thinkingMsg.find('.wm-chat-bubble');

                        const messages = (data && data.messages) ? data.messages : null;
                        const sortedMessages = (messages && messages.length)
                            ? messages.slice().sort(function (a, b) {
                                const aTime = new Date(a.createdAt || a.updatedAt || 0).getTime();
                                const bTime = new Date(b.createdAt || b.updatedAt || 0).getTime();
                                return aTime - bTime;
                            })
                            : null;
                        const assistant = (sortedMessages && sortedMessages.length)
                            ? sortedMessages.filter(function (m) { return (m.role || '').toLowerCase() === 'assistant'; }).slice(-1)[0]
                            : null;

                        const text = (assistant && assistant.message) ? assistant.message : ((data && data.answer) ? data.answer : null);
                        $bubble.html(text ? String(text).replace(/\n/g, '<br>') : 'Sorry, I could not find an answer.');

                        // refresh sidebar + messages so history stays consistent
                        loadConversations().then(function () {
                            loadMessages(conversationId);
                        });
                    }).fail(function (error) {
                        const $bubble = $thinkingMsg.find('.wm-chat-bubble');
                        $bubble.text('Unable to connect to the AI assistant. Please try again.');
                        console.error('Chat error:', error);
                    });
                });
            }

            $chatForm.on('submit', function (e) {
                e.preventDefault();
                e.stopPropagation();
                sendMessage($chatInput.val().trim());
            });

            $newChatBtn.on('click', function () {
                createConversation().then(function (id) {
                    setActiveConversation(id);
                    loadMessages(id).then(function () {
                        loadConversations();
                    });
                });
            });

            $('[data-ai-message]').on('click', function () {
                const msg = $(this).data('aiMessage');
                sendMessage(msg);
            });

            loadConversations();
        });
    </script>
</body>

</html>
