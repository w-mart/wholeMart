<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Something went wrong</title>
  <link rel="stylesheet" href="/css/common.css"/>
  <link rel="stylesheet" href="/css/footer.css"/>
  <link rel="stylesheet" href="/css/header.css"/>
  <link rel="stylesheet" href="/css/home.css"/>
</head>
<body>
  <div style="max-width:920px;margin:48px auto;padding:0 16px;font-family:system-ui, -apple-system, Segoe UI, Roboto, Arial;">
    <h1 style="margin:0 0 12px;font-size:28px;">Whitelabel Error Page</h1>
    <p style="margin:0 0 24px;color:#555;">
      An unexpected error occurred while processing your request.
    </p>

    <div style="background:#fff7e6;border:1px solid #ffd591;border-radius:10px;padding:16px;">
      <div style="font-weight:700;margin-bottom:8px;">Details</div>
      <pre style="white-space:pre-wrap;word-break:break-word;margin:0;font-size:13px;">${pageContext.errorData ? pageContext.errorData.toString() : ''}</pre>
      <p style="margin:10px 0 0;color:#666;font-size:13px;">
        Try refreshing the page or return to the dashboard.
      </p>
    </div>

    <div style="margin-top:18px;">
      <a href="/" style="display:inline-block;padding:10px 14px;border-radius:8px;background:#0d6efd;color:white;text-decoration:none;">Go to Home</a>
    </div>
  </div>
</body>
</html>

