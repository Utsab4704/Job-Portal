<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Dashboard</title>
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

        /* ── WELCOME HEADER ── */
        .welcome-header {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 5px solid #e94560;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .welcome-header h1 {
            font-size: 24px;
            color: #1a1a2e;
            margin-bottom: 6px;
        }

        .welcome-header p {
            font-size: 13px;
            color: #888;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        /* ── BUTTONS ── */
        .btn {
            display: inline-block;
            padding: 9px 20px;
            border-radius: 6px;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: background 0.3s;
        }

        .btn-primary {
            background: #e94560;
            color: white;
        }

        .btn-primary:hover { background: #c73652; }

        .btn-secondary {
            background: #1a1a2e;
            color: white;
        }

        .btn-secondary:hover { background: #0f0f1a; }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover { background: #b02a37; }

        .btn-sm {
            padding: 6px 14px;
            font-size: 13px;
        }

        /* ── PROFILE CARD ── */
        .profile-card {
            background: white;
            border-radius: 10px;
            padding: 25px 30px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .profile-card h3 {
            font-size: 16px;
            color: #1a1a2e;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 15px;
        }

        .profile-item label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .profile-item span {
            font-size: 14px;
            color: #333;
        }

        .profile-item a {
            font-size: 14px;
            color: #e94560;
            text-decoration: none;
        }

        .profile-item a:hover {
            text-decoration: underline;
        }

        /* ── STATS ROW ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-top: 3px solid #e94560;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #e94560;
        }

        .stat-card .label {
            font-size: 12px;
            color: #888;
            margin-top: 4px;
        }

        /* ── SECTION HEADER ── */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .section-header h2 {
            font-size: 20px;
            color: #1a1a2e;
            border-left: 4px solid #e94560;
            padding-left: 12px;
        }

        /* ── APPLICATION CARDS ── */
        .application-card {
            background: white;
            border-radius: 10px;
            padding: 20px 25px;
            margin-bottom: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 4px solid #e94560;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
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

        .app-job-title {
            font-size: 16px;
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 4px;
        }

        .app-company {
            font-size: 13px;
            color: #e94560;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .app-meta {
            font-size: 12px;
            color: #aaa;
        }

        /* ── BADGES ── */
        .badge {
            display: inline-block;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-pending {
            background: #fff3cd;
            color: #856404;
        }

        .badge-reviewed {
            background: #cce5ff;
            color: #004085;
        }

        .badge-accepted {
            background: #d4edda;
            color: #155724;
        }

        .badge-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        /* ── WITHDRAW FORM ── */
        .withdraw-form button {
            padding: 6px 14px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .withdraw-form button:hover { background: #b02a37; }

        /* ── NO APPLICATIONS ── */
        .no-applications {
            text-align: center;
            padding: 50px 20px;
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

        .no-applications p {
            margin-bottom: 20px;
        }

        /* ── DANGER ZONE ── */
        .danger-zone {
            background: white;
            border-radius: 10px;
            padding: 25px 30px;
            margin-top: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 5px solid #dc3545;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .danger-zone h3 {
            color: #dc3545;
            margin-bottom: 5px;
        }

        .danger-zone p {
            color: #888;
            font-size: 13px;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">

        <%-- Flash Messages --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <%-- Welcome Header --%>
        <div class="welcome-header">
            <div>
                <h1>Welcome, ${seeker.fullName}!</h1>
                <p>
                    ${seeker.email}
                    <c:if test="${not empty seeker.location}">
                        &nbsp;|&nbsp; 📍 ${seeker.location}
                    </c:if>
                </p>
            </div>
            <div class="header-actions">
                <a href="/jobs" class="btn btn-primary">
                    🔍 Browse Jobs
                </a>
                <a href="/seekers/edit" class="btn btn-secondary">
                    Edit Profile
                </a>
            </div>
        </div>

        <%-- Profile Card --%>
        <div class="profile-card">
            <h3>My Profile</h3>
            <div class="profile-grid">

                <div class="profile-item">
                    <label>Full Name</label>
                    <span>${seeker.fullName}</span>
                </div>

                <div class="profile-item">
                    <label>Email</label>
                    <span>${seeker.email}</span>
                </div>

                <c:if test="${not empty seeker.location}">
                    <div class="profile-item">
                        <label>Location</label>
                        <span>${seeker.location}</span>
                    </div>
                </c:if>

                <c:if test="${not empty seeker.skills}">
                    <div class="profile-item">
                        <label>Skills</label>
                        <span>${seeker.skills}</span>
                    </div>
                </c:if>

                <c:if test="${not empty seeker.resumeLink}">
                    <div class="profile-item">
                        <label>Resume</label>
                        <a href="${seeker.resumeLink}"
                           target="_blank">
                            📄 View Resume
                        </a>
                    </div>
                </c:if>

            </div>
        </div>

        <%-- Stats Row --%>
        <div class="stats-row">

            <div class="stat-card">
                <div class="number">${applications.size()}</div>
                <div class="label">Total Applications</div>
            </div>

            <%-- Count accepted applications --%>
            <div class="stat-card">
                <div class="number">
                    <c:set var="acceptedCount" value="0"/>
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'ACCEPTED'}">
                            <c:set var="acceptedCount"
                                   value="${acceptedCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${acceptedCount}
                </div>
                <div class="label">Accepted</div>
            </div>

            <%-- Count pending applications --%>
            <div class="stat-card">
                <div class="number">
                    <c:set var="pendingCount" value="0"/>
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'PENDING'}">
                            <c:set var="pendingCount"
                                   value="${pendingCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${pendingCount}
                </div>
                <div class="label">Pending</div>
            </div>

        </div>

        <%-- Applications Section --%>
        <div class="section-header">
            <h2>My Applications</h2>
            <a href="/jobs" class="btn btn-primary btn-sm">
                + Apply to More Jobs
            </a>
        </div>

        <c:choose>
            <c:when test="${empty applications}">
                <div class="no-applications">
                    <h3>No applications yet</h3>
                    <p>
                        Start browsing jobs and apply to
                        positions that interest you
                    </p>
                    <a href="/jobs" class="btn btn-primary">
                        Browse Jobs
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="app" items="${applications}">
                    <div class="application-card
                        status-${fn:toLowerCase(app.status)}">

                        <%-- Job Info --%>
                        <div>
                            <div class="app-job-title">
                                <a href="/jobs/${app.job.id}"
                                   style="color:#1a1a2e;
                                   text-decoration:none;">
                                    ${app.job.title}
                                </a>
                            </div>
                            <div class="app-company">
                                🏢 ${app.job.employer.company}
                            </div>
                            <c:if test="${not empty app.job.location}">
                                <div class="app-meta">
                                    📍 ${app.job.location}
                                </div>
                            </c:if>
                            <div class="app-meta">
                                Applied: ${app.appliedAt}
                            </div>
                        </div>

                        <%-- Status and Actions --%>
                        <div style="display:flex;
                                    flex-direction:column;
                                    align-items:flex-end;
                                    gap:10px;">

                            <span class="badge
                                badge-${fn:toLowerCase(app.status)}">
                                ${app.status}
                            </span>

                            <%-- Only show withdraw for PENDING --%>
                            <c:if test="${app.status == 'PENDING'}">
                                <form class="withdraw-form"
                                      action="/seekers/withdraw/${app.job.id}"
                                      method="post"
                                      onsubmit="return confirm(
                                      'Withdraw this application?')">
                                    <button type="submit">
                                        Withdraw
                                    </button>
                                </form>
                            </c:if>

                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <%-- Danger Zone --%>
        <div class="danger-zone">
            <div>
                <h3>⚠ Delete Account</h3>
                <p>
                    This will permanently delete your account
                    and all your applications.
                </p>
            </div>
            <form action="/seekers/delete"
                  method="post"
                  onsubmit="return confirm(
                  'Are you sure? This cannot be undone!')">
                <button type="submit" class="btn btn-danger">
                    Delete My Account
                </button>
            </form>
        </div>

    </div>

</body>
</html>