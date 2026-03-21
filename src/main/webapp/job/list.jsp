<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Browse Jobs</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container">

        <div class="page-header">
            <h1>Browse Jobs</h1>
            <p class="page-header__sub">Find your next opportunity</p>
        </div>

        <form class="search-bar" action="/jobs" method="get">
            <input type="text" name="keyword" placeholder="Job title or keyword"
                   value="${keyword}" />
            <input type="text" name="location" placeholder="Location"
                   value="${location}" />
            <button class="btn btn--primary" type="submit">Search</button>
            <a href="/jobs" class="btn btn--outline">Clear</a>
        </form>

        <c:choose>
            <c:when test="${empty jobs}">
                <div class="card text-center">
                    <p class="text-muted">No jobs found. Try a different search.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="job" items="${jobs}">
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
                        <p class="text-muted">Posted: ${job.postedAt}</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>
</div>
</body>
</html>