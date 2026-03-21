<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Post a Job</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container--narrow">

        <div class="page-header">
            <a href="/employers/dashboard" class="text-muted">← Back to Dashboard</a>
            <h1 class="mt-1">Post a New Job</h1>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <div class="card">
            <form:form action="/jobs/post" method="post" modelAttribute="job">
                <div class="form-group">
                    <label>Job Title</label>
                    <form:input path="title" />
                    <form:errors path="title" cssClass="form-error" />
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <form:textarea path="description" />
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <form:input path="location" />
                </div>
                <div class="form-group">
                    <label>Salary Range</label>
                    <form:input path="salaryRange" placeholder="e.g. 50,000 - 70,000" />
                </div>
                <div class="form-group">
                    <label>Job Type</label>
                    <form:select path="jobType">
                        <form:option value="">-- Select --</form:option>
                        <form:option value="Full-Time">Full-Time</form:option>
                        <form:option value="Part-Time">Part-Time</form:option>
                        <form:option value="Remote">Remote</form:option>
                        <form:option value="Contract">Contract</form:option>
                        <form:option value="Internship">Internship</form:option>
                    </form:select>
                </div>
                <button class="btn btn--primary btn--full" type="submit">
                    Post Job
                </button>
            </form:form>
        </div>

    </div>
</div>
</body>
</html>