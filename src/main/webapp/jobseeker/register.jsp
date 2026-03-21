<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Job Seeker Register</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container--narrow">

        <div class="page-header text-center">
            <h1>Create Seeker Account</h1>
            <p class="page-header__sub">Find your next opportunity</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <div class="card">
            <form:form action="/seekers/register" method="post" modelAttribute="jobSeeker">
                <div class="form-group">
                    <label>Full Name</label>
                    <form:input path="fullName" />
                    <form:errors path="fullName" cssClass="form-error" />
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
                    <label>Skills
                        <span class="text-muted">(e.g. Java, Spring, MySQL)</span>
                    </label>
                    <form:input path="skills" />
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <form:input path="location" />
                </div>
                <div class="form-group">
                    <label>Resume Link</label>
                    <form:input path="resumeLink" />
                </div>
                <button class="btn btn--primary btn--full" type="submit">
                    Create Account
                </button>
            </form:form>
        </div>

        <p class="text-center mt-2">
            Already have an account? <a href="/seekers/login">Log in</a>
        </p>

    </div>
</div>
</body>
</html>