<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Applications - ${job.title}</title>
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
            max-width: 1000px;
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

        /* ── PAGE HEADER ── */
        .page-header {
            background: white;
            border-radius: 10px;
            padding: 25px 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 5px solid #e94560;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .page-header h1 {
            font-size: 22px;
            color: #1a1a2e;
            margin-bottom: 5px;
        }

        .page-header p {
            font-size: 13px;
            color: #888;
        }

        .page-header .count {
            font-size: 36px;
            font-weight: bold;
            color: #e94560;
            text-align: center;
        }

        .page-header .count-label {
            font-size: 12px;
            color: #888;
            text-align: center;
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

        /* ── APPLICATION CARDS ── */
        .application-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 4px solid #e94560;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 20px;
            align-items: start;
        }

        .application-card.status-accepted {
            border-left-color: #28a745;
        }

        .application-card.status-rejected {
            border-left-color: #dc3545;
        }

        .application-card.status-reviewed {
            border-left-color: #ffc107;
        }

        /* ── APPLICANT INFO ── */
        .applicant-name {
            font-size: 18px;
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 6px;
        }

        .applicant-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            font-size: 13px;
            color: #666;
            margin-bottom: 12px;
        }

        .cover-letter {
            background: #f9f9f9;
            border-radius: 6px;
            padding: 12px 15px;
            font-size: 13px;
            color: #555;
            line-height: 1.6;
            border-left: 3px solid #e94560;
            margin-top: 10px;
        }

        .cover-letter-label {
            font-size: 11px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        /* ── BADGES ── */
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-pending  {
            background: #fff3cd;
            color: #856404;
        }

        .badge-reviewed {
            background: #fff3cd;
            color: #856404;
        }

        .badge-accepted {
            background: #d4edda;
            color: #155724;
        }

        .badge-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        /* ── STATUS UPDATE FORM ── */
        .status-form {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 160px;
        }

        .status-form label {
            font-size: 11px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 13px;
            outline: none;
            cursor: pointer;
            background: white;
            transition: border 0.3s;
        }

        .status-select:focus {
            border-color: #e94560;
        }

        .btn-update {
            padding: 8px 16px;
            background: #1a1a2e;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-update:hover { background: #0f0f1a; }

        /* ── NO APPLICATIONS ── */
        .no-applications {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            color: #888;
        }

        .no-applications h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #1a1a2e;
        }

        /* ── APPLIED DATE ── */
        .applied-date {
            font-size: 12px;
            color: #aaa;
            margin-top: 8px;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">

        <%-- Back Link --%>
        <a href="/employers/dashboard" class="back-link">
            ← Back to Dashboard
        </a>

        <%-- Flash Messages --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <%-- Page Header --%>
        <div class="page-header">
            <div>
                <h1>Applications for: ${job.title}</h1>
                <p>
                    📍 ${job.employer.company}
                    <c:if test="${not empty job.location}">
                        &nbsp;|&nbsp; ${job.location}
                    </c:if>
                </p>
            </div>
            <div>
                <div class="count">${applications.size()}</div>
                <div class="count-label">Total Applications</div>
            </div>
        </div>

        <%-- Applications List --%>
        <c:choose>
            <c:when test="${empty applications}">
                <div class="no-applications">
                    <h3>No applications yet</h3>
                    <p>
                        Applications for this job will appear here
                        once seekers apply.
                    </p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="app" items="${applications}">

                    <%-- Card border color changes based on status --%>
                    <div class="application-card
                        status-${fn:toLowerCase(app.status)}">

                        <%-- Left: Applicant Info --%>
                        <div>
                            <div class="applicant-name">
                                ${app.jobSeeker.fullName}
                            </div>

                            <div class="applicant-meta">
                                <span>📧 ${app.jobSeeker.email}</span>

                                <c:if test="${not empty
                                    app.jobSeeker.location}">
                                    <span>
                                        📍 ${app.jobSeeker.location}
                                    </span>
                                </c:if>

                                <c:if test="${not empty
                                    app.jobSeeker.skills}">
                                    <span>
                                        🛠 ${app.jobSeeker.skills}
                                    </span>
                                </c:if>

                                <c:if test="${not empty
                                    app.jobSeeker.resumeLink}">
                                    <span>
                                        <a href="${app.jobSeeker.resumeLink}"
                                           target="_blank">
                                            📄 View Resume
                                        </a>
                                    </span>
                                </c:if>
                            </div>

                            <%-- Current Status Badge --%>
                            <span class="badge badge-${fn:toLowerCase(
                                app.status)}">
                                ${app.status}
                            </span>

                            <%-- Cover Letter --%>
                            <c:if test="${not empty app.coverLetter}">
                                <div class="cover-letter">
                                    <div class="cover-letter-label">
                                        Cover Letter
                                    </div>
                                    ${app.coverLetter}
                                </div>
                            </c:if>

                            <%-- Applied Date --%>
                            <div class="applied-date">
                                Applied: ${app.appliedAt}
                            </div>
                        </div>

                        <%-- Right: Status Update Form --%>
                        <div class="status-form">
                            <label>Update Status</label>
                            <form action="/jobs/applications/${app.id}/status"
                                  method="post">

                                <input type="hidden"
                                       name="jobId"
                                       value="${job.id}"/>

                                <select name="status"
                                        class="status-select">
                                    <option value="PENDING"
                                        ${app.status == 'PENDING' ?
                                        'selected' : ''}>
                                        Pending
                                    </option>
                                    <option value="REVIEWED"
                                        ${app.status == 'REVIEWED' ?
                                        'selected' : ''}>
                                        Reviewed
                                    </option>
                                    <option value="ACCEPTED"
                                        ${app.status == 'ACCEPTED' ?
                                        'selected' : ''}>
                                        Accepted
                                    </option>
                                    <option value="REJECTED"
                                        ${app.status == 'REJECTED' ?
                                        'selected' : ''}>
                                        Rejected
                                    </option>
                                </select>

                                <button type="submit" class="btn-update">
                                    Update
                                </button>
                            </form>
                        </div>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>