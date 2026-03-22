<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${job.title} - Job Details</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        /* ── NAVBAR ── */
        .navbar {
            background: #1a1a2e;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand a {
            color: #e94560;
            text-decoration: none;
            font-size: 24px;
            font-weight: bold;
        }

        .navbar-links a {
            color: #fff;
            text-decoration: none;
            margin-left: 20px;
            font-size: 14px;
            transition: color 0.3s;
        }

        .navbar-links a:hover { color: #e94560; }

        /* ── CONTAINER ── */
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* ── BACK LINK ── */
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #888;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .back-link:hover { color: #e94560; }

        /* ── JOB HEADER CARD ── */
        .job-header {
            background: white;
            border-radius: 10px;
            padding: 35px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-top: 4px solid #e94560;
        }

        .job-header h1 {
            font-size: 28px;
            color: #1a1a2e;
            margin-bottom: 8px;
        }

        .job-header .company {
            font-size: 18px;
            color: #e94560;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .job-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            color: #666;
        }

        .meta-item .label {
            font-weight: 600;
            color: #333;
        }

        /* ── BADGES ── */
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-type {
            background: #e8f4fd;
            color: #1a6fa8;
        }

        .badge-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        /* ── FLASH MESSAGES ── */
        .alert {
            padding: 12px 16px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* ── TWO COLUMN LAYOUT ── */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 320px;
            gap: 20px;
            align-items: start;
        }

        /* ── JOB DESCRIPTION CARD ── */
        .description-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .description-card h2 {
            font-size: 18px;
            color: #1a1a2e;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .description-card p {
            font-size: 14px;
            line-height: 1.8;
            color: #555;
            white-space: pre-wrap;
        }

        /* ── SIDEBAR CARD ── */
        .sidebar-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            position: sticky;
            top: 20px;
        }

        .sidebar-card h3 {
            font-size: 16px;
            color: #1a1a2e;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        /* ── COMPANY INFO ── */
        .company-info {
            margin-bottom: 20px;
        }

        .company-info .info-row {
            display: flex;
            gap: 8px;
            margin-bottom: 10px;
            font-size: 13px;
            color: #666;
        }

        .company-info .info-row .info-label {
            font-weight: 600;
            color: #333;
            min-width: 70px;
        }

        /* ── APPLY SECTION ── */
        .apply-section {
            border-top: 1px solid #f0f0f0;
            padding-top: 20px;
        }

        .apply-section h4 {
            font-size: 14px;
            color: #1a1a2e;
            margin-bottom: 12px;
        }

        .cover-letter-input {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 13px;
            resize: vertical;
            min-height: 80px;
            outline: none;
            margin-bottom: 12px;
            transition: border 0.3s;
            font-family: inherit;
        }

        .cover-letter-input:focus {
            border-color: #e94560;
        }

        /* ── BUTTONS ── */
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            border: none;
            text-align: center;
            text-decoration: none;
            transition: background 0.3s;
        }

        .btn-apply {
            background: #e94560;
            color: white;
        }

        .btn-apply:hover { background: #c73652; }

        .btn-withdraw {
            background: #dc3545;
            color: white;
            margin-top: 10px;
        }

        .btn-withdraw:hover { background: #b02a37; }

        .btn-login {
            background: #1a1a2e;
            color: white;
        }

        .btn-login:hover { background: #0f0f1a; }

        .already-applied {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
            text-align: center;
            font-weight: 600;
            border: 1px solid #c3e6cb;
        }

        .job-closed {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 6px;
            font-size: 14px;
            text-align: center;
            font-weight: 600;
        }

        /* ── POSTED DATE ── */
        .posted-date {
            font-size: 12px;
            color: #aaa;
            text-align: center;
            margin-top: 15px;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 700px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            .sidebar-card {
                position: static;
            }
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">

        <%-- Back Link --%>
        <a href="/jobs" class="back-link">← Back to Jobs</a>

        <%-- Flash Messages --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <%-- Job Header --%>
        <div class="job-header">
            <h1>${job.title}</h1>
            <div class="company">🏢 ${job.employer.company}</div>

            <div class="job-meta">
                <c:if test="${not empty job.location}">
                    <div class="meta-item">
                        📍 <span class="label">${job.location}</span>
                    </div>
                </c:if>
                <c:if test="${not empty job.jobType}">
                    <div class="meta-item">
                        <span class="badge badge-type">${job.jobType}</span>
                    </div>
                </c:if>
                <c:if test="${not empty job.salaryRange}">
                    <div class="meta-item">
                        💰 <span class="label">${job.salaryRange}</span>
                    </div>
                </c:if>
                <c:if test="${not job.active}">
                    <span class="badge badge-inactive">
                        ⚠ No Longer Accepting Applications
                    </span>
                </c:if>
            </div>
        </div>

        <%-- Two Column Layout --%>
        <div class="content-grid">

            <%-- Left: Job Description --%>
            <div class="description-card">
                <h2>Job Description</h2>
                <c:choose>
                    <c:when test="${not empty job.description}">
                        <p>${job.description}</p>
                    </c:when>
                    <c:otherwise>
                        <p style="color:#aaa">
                            No description provided.
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Right: Sidebar --%>
            <div class="sidebar-card">
                <h3>Company Info</h3>

                <%-- Company Details --%>
                <div class="company-info">
                    <div class="info-row">
                        <span class="info-label">Company</span>
                        <span>${job.employer.company}</span>
                    </div>
                    <c:if test="${not empty job.employer.location}">
                        <div class="info-row">
                            <span class="info-label">Location</span>
                            <span>${job.employer.location}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty job.employer.description}">
                        <div class="info-row">
                            <span class="info-label">About</span>
                            <span>${job.employer.description}</span>
                        </div>
                    </c:if>
                </div>

                <%-- Apply Section --%>
                <div class="apply-section">

                    <c:choose>

                        <%-- Job is no longer active --%>
                        <c:when test="${not job.active}">
                            <div class="job-closed">
                                This job is no longer accepting applications
                            </div>
                        </c:when>

                        <%-- Logged in as SEEKER --%>
                        <c:when test="${not empty loggedInSeeker}">

                            <%-- Check if already applied --%>
                            <c:set var="alreadyApplied" value="false"/>
                            <c:forEach var="app"
                                       items="${loggedInSeeker.applications}">
                                <c:if test="${app.job.id == job.id}">
                                    <c:set var="alreadyApplied" value="true"/>
                                </c:if>
                            </c:forEach>

                            <c:choose>
                                <c:when test="${alreadyApplied}">
                                    <div class="already-applied">
                                        ✅ You have already applied to this job
                                    </div>
                                    <form action="/seekers/withdraw/${job.id}"
                                          method="post"
                                          onsubmit="return confirm(
                                          'Withdraw your application?')">
                                        <button type="submit"
                                                class="btn btn-withdraw">
                                            Withdraw Application
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <h4>Apply for this position</h4>
                                    <form action="/seekers/apply/${job.id}"
                                          method="post">
                                        <textarea
                                            class="cover-letter-input"
                                            name="coverLetter"
                                            placeholder="Write a brief cover letter
                                             (optional)...">
                                        </textarea>
                                        <button type="submit"
                                                class="btn btn-apply">
                                            Apply Now →
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </c:when>

                        <%-- Logged in as EMPLOYER --%>
                        <c:when test="${sessionScope.userType == 'EMPLOYER'}">
                            <div class="already-applied">
                                Log in as a Job Seeker to apply
                            </div>
                        </c:when>

                        <%-- Not logged in --%>
                        <c:otherwise>
                            <h4>Interested in this role?</h4>
                            <a href="/seekers/login" class="btn btn-login">
                                Log In to Apply
                            </a>
                        </c:otherwise>

                    </c:choose>
                </div>

                <%-- Posted Date --%>
                <div class="posted-date">
                    Posted: ${job.postedAt}
                </div>
            </div>

        </div>
    </div>

</body>
</html>