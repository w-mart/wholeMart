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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
    <link href="/css/orders.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ai-chat.css">

    </head>
    <body class="wm-page-background">
        <%
            String wmUserName = session.getAttribute("name") == null ? "Guest" : String.valueOf(session.getAttribute("name"));
            List<String> suggestedQuestions = List.of(
                "Show today's order summary",
                "Show low stock products",
                "Show pending retailer payments",
                "Business performance summary",
                "Suggest products to reorder",
                "Today's priorities"
            );
        %>

        <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

        <div class="wm-app">
            <main>
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
                                <!-- Conversations will be loaded here -->
                                <div class="p-3 text-muted small">Loading chats...</div>
                            </div>
                        </aside>

                        <!-- Main chat panel -->
                        <div class="wm-chat-main">
                            <section class="wm-card wm-ai-panel">
                                <div class="wm-ai-header">
                                    <div class="wm-ai-avatar">AI</div>
                                    <div>
                                        <h2 class="mb-1">WholeMart AI Assistant</h2>
                                        <p class="text-muted mb-0">
                                            Ask anything about your orders, products, payments, or business performance.
                                        </p>
                                    </div>
                                </div>

                                <div id="chatLog" class="wm-ai-response wm-chat-log">
                                    <div class="wm-chat-message">
                                        <div class="wm-chat-avatar">AI</div>
                                        <div class="wm-chat-bubble">
                                            Welcome <strong><%= wmUserName %></strong> 👋
                                            <br><br>
                                            I'm ready to help you with your distributor business. Ask me a question or choose from the suggestions.
                                        </div>
                                    </div>
                                </div>

                                <div id="quickButtons" class="wm-ai-chips mt-3">
                                    <% for (String question : suggestedQuestions) { %>
                                        <button type="button" class="wm-ai-chip" data-ai-message="<%= question %>">
                                            <%= question %>
                                        </button>
                                    <% } %>
                                </div>

                                <form id="chatForm" class="mt-4">
                                    <div class="input-group">
                                        <input id="chatInput" type="text" class="form-control" placeholder="Ask WholeMart AI anything..." autocomplete="off" required>
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
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const chatForm = document.getElementById('chatForm');
                const chatInput = document.getElementById('chatInput');
                const chatLog = document.getElementById('chatLog');
                const quickButtons = document.getElementById('quickButtons');

                function addMessageToLog(sender, message) {
                    const messageDiv = document.createElement('div');
                    messageDiv.className = 'wm-chat-message';
                    const avatar = sender === 'USER' ? `<div class="wm-chat-avatar is-user"><i class="bi bi-person"></i></div>` : `<div class="wm-chat-avatar">AI</div>`;
                    messageDiv.innerHTML = `${avatar}<div class="wm-chat-bubble">${message}</div>`;
                    chatLog.appendChild(messageDiv);
                    chatLog.scrollTop = chatLog.scrollHeight;
                }

                async function sendMessage(message) {
                    if (!message) return;
                    addMessageToLog('USER', message);
                    chatInput.value = '';
                    addMessageToLog('ASSISTANT', 'Thinking...');

                    try {
                        const response = await fetch('/api/v1/ai/agent/chat', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ message: message })
                        });
                        const data = await response.json();
                        const lastBubble = chatLog.querySelector('.wm-chat-message:last-child .wm-chat-bubble');
                        if (lastBubble) {
                            lastBubble.innerHTML = (data && data.answer) ? data.answer.replace(/\n/g, '<br>') : 'Sorry, I could not find an answer.';
                        }
                    } catch (error) {
                        const lastBubble = chatLog.querySelector('.wm-chat-message:last-child .wm-chat-bubble');
                        if (lastBubble) {
                            lastBubble.textContent = 'Unable to connect to the AI assistant. Please try again.';
                        }
                        console.error("Chat error:", error);
                    }
                }

                chatForm.addEventListener('submit', function (e) {
                    e.preventDefault();
                    sendMessage(chatInput.value.trim());
                });

                quickButtons.addEventListener('click', function(e) {
                    const btn = e.target.closest('[data-ai-message]');
                    if (btn) {
                        sendMessage(btn.dataset.aiMessage);
                    }
                });
            });
        </script>
    </body>
    </html>
