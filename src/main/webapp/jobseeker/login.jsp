<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        /* ── NAVBAR ── */
        .navbar {
            background: #1a1a2e;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand a {
            color: #e94560;
            text-decoration: none;
            font-size: 24px;
            font-weight: bold;
        }

        .navbar-links a {
            color: #fff;
            text-decoration: none;
            margin-left: 20px;
            font-size: 14px;
            transition: color 0.3s;
        }

        .navbar-links a:hover { color: #e94560; }

        /* ── CONTAINER ── */
        .container {
            max-width: 450px;
            margin: 80px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            border-top: 4px solid #e94560;
        }

        .card h2 {
            font-size: 26px;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .card p {
            color: #888;
            margin-bottom: 30px;
            font-size: 14px;
        }

        /* ── FORM FIELDS ── */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #555;
            margin-bottom: 6px;
        }

        .form-group input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border 0.3s;
        }

        .form-group input:focus {
            border-color: #e94560;
        }

        /* ── SUBMIT BUTTON ── */
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #e94560;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .btn-submit:hover { background: #c73652; }

        /* ── FLASH MESSAGES ── */
        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* ── BOTTOM LINKS ── */
        .bottom-links {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #888;
        }

        .bottom-links a {
            color: #e94560;
            text-decoration: none;
            font-weight: 600;
        }

        .bottom-links a:hover { text-decoration: underline; }

        .divider {
            margin: 0 8px;
            color: #ddd;
        }

        /* ── ROLE SWITCHER ── */
        .role-switcher {
            display: flex;
            margin-bottom: 25px;
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid #e94560;
        }

        .role-switcher a {
            flex: 1;
            text-align: center;
            padding: 10px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .role-switcher .active-role {
            background: #e94560;
            color: white;
        }

        .role-switcher .inactive-role {
            background: white;
            color: #e94560;
        }

        .role-switcher .inactive-role:hover {
            background: #fff0f3;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">
        <div class="card">
            <h2>Welcome Back!</h2>
            <p>Log in to your account to continue</p>

            <%-- Role Switcher --%>
            <div class="role-switcher">
                <a href="/seekers/login"
                   class="active-role">
                    👤 Job Seeker
                </a>
                <a href="/employers/login"
                   class="inactive-role">
                    🏢 Employer
                </a>
            </div>

            <%-- Flash Messages --%>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <%-- Login Form --%>
            <form action="/seekers/login" method="post">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="utsab@example.com"
                           required/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           required/>
                </div>

                <button type="submit" class="btn-submit">
                    Log In
                </button>

            </form>

            <div class="bottom-links">
                Don't have an account?
                <a href="/seekers/register">Register here</a>
                <span class="divider">|</span>
                <a href="/employers/login">Employer Login</a>
            </div>
        </div>
    </div>

</body>
</html>