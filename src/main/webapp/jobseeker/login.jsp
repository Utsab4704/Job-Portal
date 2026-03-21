<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Seeker Login</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container--narrow">

        <div class="page-header text-center">
            <h1>Welcome Back</h1>
            <p class="page-header__sub">Log in to your seeker account</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert--success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <div class="card">
            <form action="/seekers/login" method="post">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required />
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required />
                </div>
                <button class="btn btn--primary btn--full" type="submit">
                    Log In
                </button>
            </form>
        </div>

        <p class="text-center mt-2">
            No account? <a href="/seekers/register">Register here</a>
        </p>

    </div>
</div>
</body>
</html>