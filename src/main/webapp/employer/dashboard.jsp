<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Dashboard — ${employer.companyName}</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container">

        <div class="flex-between page-header">
            <div>
                <h1>${employer.companyName}</h1>
                <p class="page-header__sub">📍 ${employer.location}</p>
            </div>
            <div class="dash-actions">
                <a href="/jobs/post" class="btn btn--primary">+ Post New Job</a>
                <a href="/employers/edit" class="btn btn--outline">Edit Profile</a>
            </div>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert--success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <h2 class="mb-2">Your Posted Jobs</h2>

        <c:choose>
            <c:when test="${empty jobs}">
                <div class="card text-center">
                    <p class="text-muted">No jobs posted yet.</p>
                    <a href="/jobs/post" class="btn btn--primary mt-2">
                        Post Your First Job
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="job" items="${jobs}">
                    <div class="job-card">
                        <div class="flex-between">
                            <h3 class="job-card__title">
                                <a href="/jobs/${job.id}">${job.title}</a>
                            </h3>
                            <span class="tag">
                                    ${job.active ? 'Active' : 'Removed'}
                            </span>
                        </div>
                        <div class="job-card__meta">
                            <span class="text-muted">📍 ${job.location}</span>
                            <span class="tag">${job.jobType}</span>
                            <span class="text-muted">💰 ${job.salaryRange}</span>
                        </div>
                        <div class="dash-actions mt-2">
                            <a href="/jobs/${job.id}/applications"
                               class="btn btn--outline btn--sm">
                                Applications
                            </a>
                            <a href="/jobs/${job.id}/edit"
                               class="btn btn--outline btn--sm">Edit</a>
                            <form action="/jobs/${job.id}/delete" method="post"
                                  style="display:inline">
                                <button class="btn btn--danger btn--sm" type="submit"
                                        onclick="return confirm('Remove this job?')">
                                    Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <div class="danger-zone">
            <h3>Danger Zone</h3>
            <p>Permanently delete your account and all posted jobs.</p>
            <form action="/employers/delete" method="post" class="mt-2">
                <button class="btn btn--danger" type="submit"
                        onclick="return confirm('Delete your account? This cannot be undone.')">
                    Delete My Account
                </button>
            </form>
        </div>

    </div>
</div>
</body>
</html>