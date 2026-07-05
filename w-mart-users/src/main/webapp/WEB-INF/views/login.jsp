<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - W-Mart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="form-container">
        <h2>Login to W-Mart</h2>
        <form id="loginForm">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div id="message-area" class="message"></div>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
    </div>
    <script>
        document.getElementById('loginForm').addEventListener('submit', async function(e) {
            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);
            const loginData = Object.fromEntries(formData.entries());

            const messageArea = document.getElementById('message-area');
            messageArea.textContent = '';
            messageArea.className = 'message';

            try {
                // NOTE: This assumes you have a /api/v1/login endpoint
                const response = await fetch('/api/v1/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(loginData),
                });

                const responseData = await response.json();

                if (response.ok && responseData.token) {
                    localStorage.setItem('jwt_token', responseData.token);
                    window.location.href = '/dashboard';
                } else {
                    const errorMessage = responseData.message || 'Invalid credentials';
                    messageArea.textContent = `Error: ${errorMessage}`;
                    messageArea.classList.add('error');
                }
            } catch (error) {
                console.error('Login failed:', error);
                messageArea.textContent = 'Login failed. Please try again later.';
                messageArea.classList.add('error');
            }
        });
    </script>
</body>
</html>