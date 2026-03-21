<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container--narrow">

        <div class="page-header">
            <a href="/seekers/dashboard" class="text-muted">← Back to Dashboard</a>
            <h1 class="mt-1">Edit Profile</h1>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <div class="card">
            <form:form action="/seekers/edit" method="post" modelAttribute="jobSeeker">
                <div class="form-group">
                    <label>Full Name</label>
                    <form:input path="fullName" />
                    <form:errors path="fullName" cssClass="form-error" />
                </div>
                <div class="form-group">
                    <label>Skills</label>
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
                <div class="form-group">
                    <label>New Password
                        <span class="text-muted">(leave blank to keep current)</span>
                    </label>
                    <form:input path="password" type="password" />
                </div>
                <button class="btn btn--primary btn--full" type="submit">
                    Save Changes
                </button>
            </form:form>
        </div>

    </div>
</div>
</body>
</html>