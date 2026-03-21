<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${job.title}</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="page-wrapper">
    <div class="container">

        <a href="/jobs" class="text-muted">← Back to Jobs</a>

        <div class="card mt-2">

            <div class="flex-between mb-2">
                <div>
                    <h1>${job.title}</h1>
                    <p class="page-header__sub">${job.employer.companyName}</p>
                </div>
                <span class="tag">${job.jobType}</span>
            </div>

            <div class="job-card__meta mb-2">
                <span class="text-muted">📍 ${job.location}</span>
                <span class="text-muted">💰 ${job.salaryRange}</span>
                <span class="text-muted">🗓 ${job.postedAt}</span>
            </div>

            <hr>
            <p>${job.description}</p>
            <hr>

            <c:if test="${not empty successMessage}">
                <div class="alert alert--success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert--error">${errorMessage}</div>
            </c:if>

            <c:choose>
                <c:when test="${not empty sessionScope.loggedInSeeker}">
                    <h2 class="mt-2">Apply for this Role</h2>
                    <form action="/seekers/apply/${job.id}" method="post" class="mt-1">
                        <div class="form-group">
                            <label>Cover Letter
                                <span class="text-muted">(optional)</span>
                            </label>
                            <textarea name="coverLetter" class="form-group"></textarea>
                        </div>
                        <button class="btn btn--primary" type="submit">
                            Submit Application
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="card mt-2 text-center">
                        <p class="text-muted">Want to apply?</p>
                        <a href="/seekers/login" class="btn btn--primary mt-1">
                            Log in as Job Seeker
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

    </div>
</div>
</body>
</html>