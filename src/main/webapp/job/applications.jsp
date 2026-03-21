<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Applications — ${job.title}</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container">

        <div class="page-header">
            <a href="/employers/dashboard" class="text-muted">← Back to Dashboard</a>
            <h1 class="mt-1">Applications for: ${job.title}</h1>
            <p class="page-header__sub">
                ${job.location} · ${job.jobType}
            </p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert--success">${successMessage}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty applications}">
                <div class="card text-center">
                    <p class="text-muted">No applications received yet.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="app" items="${applications}">
                    <div class="application-row">
                        <div class="application-row__header">
                            <div>
                                <h3>${app.jobSeeker.fullName}</h3>
                                <p class="text-muted">${app.jobSeeker.email}</p>
                            </div>
                            <span class="tag tag--${app.status.toString().toLowerCase()}">
                                    ${app.status}
                            </span>
                        </div>

                        <div class="job-card__meta">
                            <span class="text-muted">🛠 ${app.jobSeeker.skills}</span>
                            <span class="text-muted">📍 ${app.jobSeeker.location}</span>
                            <c:if test="${not empty app.jobSeeker.resumeLink}">
                                <a href="${app.jobSeeker.resumeLink}" target="_blank"
                                   class="btn btn--outline btn--sm">
                                    View Resume
                                </a>
                            </c:if>
                        </div>

                        <c:if test="${not empty app.coverLetter}">
                            <p class="mt-1"><em>${app.coverLetter}</em></p>
                        </c:if>

                        <p class="text-muted mt-1">Applied: ${app.appliedAt}</p>

                        <form action="/jobs/applications/${app.id}/status"
                              method="post" class="status-form mt-1">
                            <input type="hidden" name="jobId" value="${job.id}" />
                            <select name="status">
                                <option value="PENDING"
                                    ${app.status == 'PENDING' ? 'selected' : ''}>
                                    PENDING
                                </option>
                                <option value="REVIEWED"
                                    ${app.status == 'REVIEWED' ? 'selected' : ''}>
                                    REVIEWED
                                </option>
                                <option value="ACCEPTED"
                                    ${app.status == 'ACCEPTED' ? 'selected' : ''}>
                                    ACCEPTED
                                </option>
                                <option value="REJECTED"
                                    ${app.status == 'REJECTED' ? 'selected' : ''}>
                                    REJECTED
                                </option>
                            </select>
                            <button class="btn btn--outline btn--sm" type="submit">
                                Update Status
                            </button>
                        </form>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>
</div>
</body>
</html>