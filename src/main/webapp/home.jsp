<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>JobPortal — Find Your Next Role</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="hero">
    <h1>Find Work You Love</h1>
    <p>Browse hundreds of opportunities from companies that care.</p>
    <form class="hero__search" action="/jobs" method="get">
        <input type="text" name="keyword" placeholder="Job title or keyword" />
        <input type="text" name="location" placeholder="Location" />
        <button class="btn btn--primary" type="submit">Search</button>
    </form>
</div>

<div class="container">

    <c:if test="${not empty successMessage}">
        <div class="alert alert--success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert--error">${errorMessage}</div>
    </c:if>

    <div class="flex-between mb-2">
        <h2>Recent Openings</h2>
        <a href="/jobs" class="btn btn--outline btn--sm">View All</a>
    </div>

    <c:choose>
        <c:when test="${empty recentJobs}">
            <div class="card text-center">
                <p class="text-muted">No jobs posted yet. Check back soon!</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="job" items="${recentJobs}">
                <div class="job-card">
                    <div class="flex-between">
                        <h3 class="job-card__title">
                            <a href="/jobs/${job.id}">${job.title}</a>
                        </h3>
                        <span class="tag">${job.jobType}</span>
                    </div>
                    <div class="job-card__meta">
                        <span class="text-muted">${job.employer.companyName}</span>
                        <span class="text-muted">📍 ${job.location}</span>
                        <span class="text-muted">💰 ${job.salaryRange}</span>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>

<div class="footer">© 2026 JobPortal. Built with Spring Boot.</div>
</body>
</html>