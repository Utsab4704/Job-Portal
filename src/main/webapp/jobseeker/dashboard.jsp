<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Dashboard — ${seeker.fullName}</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container">

        <div class="flex-between page-header">
            <div>
                <h1>${seeker.fullName}</h1>
                <p class="page-header__sub">
                    📍 ${seeker.location} &nbsp;|&nbsp; 🛠 ${seeker.skills}
                </p>
            </div>
            <div class="dash-actions">
                <a href="/jobs" class="btn btn--primary">Browse Jobs</a>
                <a href="/seekers/edit" class="btn btn--outline">Edit Profile</a>
            </div>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert--success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert--error">${errorMessage}</div>
        </c:if>

        <h2 class="mb-2">My Applications</h2>

        <c:choose>
            <c:when test="${empty applications}">
                <div class="card text-center">
                    <p class="text-muted">No applications yet.</p>
                    <a href="/jobs" class="btn btn--primary mt-2">Browse Jobs</a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="app" items="${applications}">
                    <div class="application-row">
                        <div class="application-row__header">
                            <div>
                                <h3>${app.job.title}</h3>
                                <p class="text-muted">
                                        ${app.job.employer.companyName} &nbsp;·&nbsp;
                                    📍 ${app.job.location}
                                </p>
                            </div>
                            <span class="tag tag--${app.status.toString().toLowerCase()}">
                                    ${app.status}
                            </span>
                        </div>
                        <p class="text-muted">
                            Applied: ${app.appliedAt}
                        </p>
                        <c:if test="${app.status == 'PENDING'}">
                            <form action="/seekers/withdraw/${app.job.id}"
                                  method="post" class="mt-1">
                                <button class="btn btn--danger btn--sm" type="submit"
                                        onclick="return confirm('Withdraw this application?')">
                                    Withdraw
                                </button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <div class="danger-zone">
            <h3>Danger Zone</h3>
            <p>Permanently delete your account and all your applications.</p>
            <form action="/seekers/delete" method="post" class="mt-2">
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