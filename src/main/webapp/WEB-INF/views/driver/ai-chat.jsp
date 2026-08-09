<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Driver Logistics AI Copilot</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ai-chat.css">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        .wm-chat-wrapper-clean {
            padding: 24px 0 60px;
            font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
            background: #f8fafc;
            min-height: calc(100vh - 76px);
        }

        .wm-chat-card-shell {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px -4px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            height: 720px;
            max-height: 80vh;
        }

        .wm-copilot-header {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #ffffff;
            padding: 18px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .wm-chat-log {
            flex-grow: 1;
            padding: 24px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 16px;
            background: #f8fafc;
        }

        .wm-chat-bubble-bot {
            align-self: flex-start;
            max-width: 80%;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            padding: 14px 18px;
            border-radius: 16px 16px 16px 4px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            font-size: 0.94rem;
            line-height: 1.55;
            color: #0f172a;
        }

        .wm-chat-bubble-user {
            align-self: flex-end;
            max-width: 80%;
            background: #0f172a;
            color: #ffffff;
            padding: 14px 18px;
            border-radius: 16px 16px 4px 16px;
            font-size: 0.94rem;
            line-height: 1.55;
        }

        .wm-quick-chip-tray {
            padding: 12px 20px;
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
            display: flex;
            gap: 8px;
            overflow-x: auto;
            white-space: nowrap;
        }

        .wm-copilot-chip {
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            color: #334155;
            padding: 6px 14px;
            border-radius: 9999px;
            font-size: 0.82rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .wm-copilot-chip:hover {
            background: #0f172a;
            color: #ffffff;
            border-color: #0f172a;
        }

        .wm-input-tray {
            padding: 16px 20px;
            background: #ffffff;
            border-top: 1px solid #e2e8f0;
        }
    </style>
</head>
<body class="wm-home">
    <% 
        String wmUserName = session.getAttribute("username") == null ? "Driver" : String.valueOf(session.getAttribute("username"));
        List<String> suggestedQuestions = List.of(
            "What is my next delivery route?",
            "How many orders are assigned to me today?",
            "What are my total earnings for this week?",
            "How do I verify pickup and delivery OTP?",
            "What should I do if a customer is unreachable?"
        );
    %>

    <%@ include file="/WEB-INF/common/driver-header.jsp" %>

    <div class="wm-app">
        <main class="wm-chat-wrapper-clean">
            <div class="container-fluid px-2 px-md-3 px-lg-4" style="max-width: 1080px;">

                <div class="wm-chat-card-shell">
                    <!-- Header -->
                    <div class="wm-copilot-header">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-circle bg-white text-dark d-flex align-items-center justify-content-center fw-bold" style="width: 42px; height: 42px; font-size: 1.2rem;">
                                <i class="bi bi-robot text-primary"></i>
                            </div>
                            <div>
                                <h5 class="mb-0 text-white fw-bold">WholeMart Logistics AI Copilot</h5>
                                <small class="text-emerald-400 text-success"><i class="bi bi-circle-fill" style="font-size: 8px;"></i> Live Dispatch Assistant</small>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/driver/dashboard" class="btn btn-sm btn-outline-light rounded-pill px-3">
                            <i class="bi bi-speedometer2 me-1"></i> Dashboard
                        </a>
                    </div>

                    <!-- Chat Log -->
                    <div id="chatMessages" class="wm-chat-log">
                        <div class="wm-chat-bubble-bot">
                            <div class="d-flex align-items-center gap-2 mb-1 text-primary small fw-bold font-monospace">
                                <i class="bi bi-robot"></i> WholeMart AI Assistant
                            </div>
                            Hello <strong><%= wmUserName %></strong>! I am your AI delivery copilot. Ask me about your assigned shipments, navigation routes, payout calculations, or OTP verification steps.
                        </div>
                    </div>

                    <!-- Suggestions Tray -->
                    <div class="wm-quick-chip-tray">
                        <% for (String q : suggestedQuestions) { %>
                            <button type="button" class="wm-copilot-chip" onclick="sendSuggestedMessage('<%= q %>')">
                                <%= q %>
                            </button>
                        <% } %>
                    </div>

                    <!-- Input Tray -->
                    <div class="wm-input-tray">
                        <form id="chatForm" onsubmit="handleChatSubmit(event)" class="d-flex gap-2">
                            <input type="text" id="chatInput" class="form-control rounded-pill px-4" placeholder="Ask about routes, shipments, OTPs, or payouts..." autocomplete="off" required>
                            <button type="submit" class="btn btn-dark rounded-pill px-4 fw-bold" id="sendBtn">
                                <i class="bi bi-send-fill me-1"></i> Send
                            </button>
                        </form>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>

    <script>
        function sendSuggestedMessage(text) {
            document.getElementById('chatInput').value = text;
            handleChatSubmit(new Event('submit'));
        }

        function handleChatSubmit(e) {
            if (e && e.preventDefault) e.preventDefault();
            const input = document.getElementById('chatInput');
            const message = input.value.trim();
            if (!message) return;

            const chatMessages = document.getElementById('chatMessages');

            // Add user bubble
            const userDiv = document.createElement('div');
            userDiv.className = 'wm-chat-bubble-user';
            userDiv.textContent = message;
            chatMessages.appendChild(userDiv);

            input.value = '';
            chatMessages.scrollTop = chatMessages.scrollHeight;

            // Add thinking bot placeholder
            const botDiv = document.createElement('div');
            botDiv.className = 'wm-chat-bubble-bot';
            botDiv.innerHTML = '<span class="spinner-border spinner-border-sm me-2 text-primary"></span>Analyzing dispatch routes and orders...';
            chatMessages.appendChild(botDiv);
            chatMessages.scrollTop = chatMessages.scrollHeight;

            fetch('/api/v1/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: message })
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                var answer = data.answer || data.reply || "I am here to assist with your active delivery runs and dispatch route optimization.";
                botDiv.innerHTML = '<div class="d-flex align-items-center gap-2 mb-1 text-primary small fw-bold font-monospace"><i class="bi bi-robot"></i> WholeMart AI Assistant</div>' +
                    $('<div>').text(answer).html();
                chatMessages.scrollTop = chatMessages.scrollHeight;
            })
            .catch(function(err) {
                botDiv.innerHTML = '<div class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i> Unable to reach AI copilot service right now. Please try again.</div>';
                chatMessages.scrollTop = chatMessages.scrollHeight;
            });
        }
    </script>
</body>
</html>
