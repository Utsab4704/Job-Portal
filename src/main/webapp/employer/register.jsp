<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Employer Register</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container--narrow">

        <div class="page-header text-center">
            <h1>Create Employer Account</h1>
            <p class="page-header__sub">Post jobs and find great candidates</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <div class="card">
            <form:form action="/employers/register" method="post" modelAttribute="employer">

                <div class="form-group">
                    <label>Company Name</label>
                    <form:input path="companyName" />
                    <form:errors path="companyName" cssClass="form-error" />
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <form:input path="email" type="email" />
                    <form:errors path="email" cssClass="form-error" />
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <form:input path="password" type="password" />
                    <form:errors path="password" cssClass="form-error" />
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <form:input path="location" />
                </div>
                <div class="form-group">
                    <label>Company Description</label>
                    <form:textarea path="description" />
                </div>

                <button class="btn btn--primary btn--full" type="submit">
                    Create Account
                </button>

            </form:form>
        </div>

        <p class="text-center mt-2">
            Already have an account? <a href="/employers/login">Log in</a>
        </p>

    </div>
</div>
</body>
</html>