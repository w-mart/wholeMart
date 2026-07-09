<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WholeMart | Distributor Dashboard</title>

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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

    </head>
    <% String wmUserName=session.getAttribute("name")==null ? "Guest" :
            String.valueOf(session.getAttribute("name")); String wmUserInitial=wmUserName.substring(0,1).toUpperCase();
            %>

            <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

                <div class="wm-app">
<h1 class="wm-title">AI Agent</h1>
<p class="wm-subtitle">Ask for help using your current account scope.</p>
<div id="log" class="border rounded p-3 mb-3" style="min-height:240px;background:#fff"></div>
<form id="chat" class="d-flex gap-2"><input id="msg" class="wm-input" placeholder="Type your message" required><button class="btn wm-gradient-btn" type="submit">Send</button></form>
<script>
document.addEventListener('DOMContentLoaded',function(){var chatForm=document.getElementById('chat');var msgInput=document.getElementById('msg');var log=document.getElementById('log');if(!chatForm||!msgInput||!log){return;}chatForm.addEventListener('submit',function(e){e.preventDefault();var message=msgInput.value.trim();if(!message){return;}fetch('/api/v1/ai/agent/chat',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({message:message})}).then(function(response){return response.json();}).then(function(data){var text=(data && data.answer) ? data.answer : 'No response yet.';var paragraph=document.createElement('p');paragraph.textContent=text;log.appendChild(paragraph);msgInput.value='';log.scrollTop=log.scrollHeight;}).catch(function(){var paragraph=document.createElement('p');paragraph.textContent='Unable to send message. Try again.';log.appendChild(paragraph);});});});
</script>
            <%@ include file="/WEB-INF/common/footer.jsp" %>

                <div class="wm-app">
                </div>
    </html>
    

