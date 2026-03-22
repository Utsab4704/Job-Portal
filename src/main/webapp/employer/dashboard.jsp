<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employer Dashboard</title>
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

        /* ── PAGE LAYOUT ── */
        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* ── WELCOME HEADER ── */
        .welcome-header {
            background: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-left: 5px solid #e94560;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .welcome-header h1 {
            font-size: 26px;
            color: #1a1a2e;
        }

        .welcome-header p {
            color: #888;
            font-size: 14px;
            margin-top: 5px;
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

        /* ── STATS ROW ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            border-top: 3px solid #e94560;
        }

        .stat-card .number {
            font-size: 36px;
            font-weight: bold;
            color: #e94560;
        }

        .stat-card .label {
            font-size: 13px;
            color: #888;
            margin-top: 5px;
        }

        /* ── JOBS SECTION ── */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .section-header h2 {
            font-size: 22px;
            color: #1a1a2e;
            border-left: 4px solid #e94560;
            padding-left: 12px;
        }

        /* ── JOB TABLE ── */
        .table-wrapper {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #1a1a2e;
            color: white;
        }

        thead th {
            padding: 14px 18px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.2s;
        }

        tbody tr:hover { background: #fafafa; }

        tbody td {
            padding: 14px 18px;
            font-size: 14px;
            vertical-align: middle;
        }

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-active {
            background: #d4edda;
            color: #155724;
        }

        .badge-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        /* ── NO JOBS ── */
        .no-jobs {
            text-align: center;
            padding: 50px;
            color: #888;
        }

        .no-jobs p { margin-bottom: 15px; }

        /* ── DANGER ZONE ── */
        .danger-zone {
            background: white;
            border-radius: 10px;
            padding: 25px 30px;
            margin-top: 30px;
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

        /* ── PROFILE INFO ── */
        .profile-info {
            background: white;
            border-radius: 10px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .profile-info h3 {
            font-size: 16px;
            color: #1a1a2e;
            margin-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
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
                <h1>Welcome, ${employer.company}!</h1>
                <p>${employer.email}
                    <c:if test="${not empty employer.location}">
                        &nbsp;|&nbsp; 📍 ${employer.location}
                    </c:if>
                </p>
            </div>
            <div class="header-actions">
                <a href="/jobs/post" class="btn btn-primary">+ Post New Job</a>
                <a href="/employers/edit" class="btn btn-secondary">Edit Profile</a>
            </div>
        </div>

        <%-- Profile Info --%>
        <c:if test="${not empty employer.description}">
            <div class="profile-info">
                <h3>Company Description</h3>
                <p>${employer.description}</p>
            </div>
        </c:if>

        <%-- Stats Row --%>
        <div class="stats-row">
            <div class="stat-card">
                <div class="number">${jobs.size()}</div>
                <div class="label">Total Jobs Posted</div>
            </div>
            <div class="stat-card">
                <div class="number">
                    <c:set var="activeCount" value="0"/>
                    <c:forEach var="job" items="${jobs}">
                        <c:if test="${job.active}">
                            <c:set var="activeCount" value="${activeCount + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${activeCount}
                </div>
                <div class="label">Active Listings</div>
            </div>
        </div>

        <%-- Jobs Table --%>
        <div class="section-header">
            <h2>Your Job Listings</h2>
            <a href="/jobs/post" class="btn btn-primary btn-sm">+ Post New Job</a>
        </div>

        <div class="table-wrapper">
            <c:choose>
                <c:when test="${empty jobs}">
                    <div class="no-jobs">
                        <p>You haven't posted any jobs yet.</p>
                        <a href="/jobs/post" class="btn btn-primary">
                            Post Your First Job
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Job Title</th>
                                <th>Location</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="job" items="${jobs}">
                                <tr>
                                    <td><strong>${job.title}</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty job.location}">
                                                ${job.location}
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty job.jobType}">
                                                ${job.jobType}
                                            </c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.active}">
                                                <span class="badge badge-active">
                                                    Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-inactive">
                                                    Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/jobs/${job.id}/applications"
                                               class="btn btn-secondary btn-sm">
                                               Applications
                                            </a>
                                            <a href="/jobs/${job.id}/edit"
                                               class="btn btn-primary btn-sm">
                                               Edit
                                            </a>
                                            <form action="/jobs/${job.id}/delete"
                                                  method="post"
                                                  style="display:inline"
                                                  onsubmit="return confirm(
                                                  'Remove this job from listings?')">
                                                <button type="submit"
                                                        class="btn btn-danger btn-sm">
                                                    Remove
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Danger Zone --%>
        <div class="danger-zone">
            <div>
                <h3>⚠ Delete Account</h3>
                <p>This will permanently delete your account and all job listings.</p>
            </div>
            <form action="/employers/delete"
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