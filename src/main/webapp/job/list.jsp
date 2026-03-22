<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Browse Jobs</title>
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

        /* ── SEARCH HEADER ── */
        .search-header {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            padding: 40px 20px;
            text-align: center;
            color: white;
        }

        .search-header h1 {
            font-size: 32px;
            margin-bottom: 20px;
            color: #e94560;
        }

        /* ── SEARCH BAR ── */
        .search-bar {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-bar input {
            padding: 11px 18px;
            width: 260px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            outline: none;
        }

        .search-bar button {
            padding: 11px 28px;
            background: #e94560;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .search-bar button:hover { background: #c73652; }

        .search-bar .btn-clear {
            padding: 11px 20px;
            background: transparent;
            color: #ccc;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s;
        }

        .search-bar .btn-clear:hover {
            background: #ccc;
            color: #1a1a2e;
        }

        /* ── MAIN CONTAINER ── */
        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* ── RESULTS INFO ── */
        .results-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .results-info p {
            font-size: 14px;
            color: #888;
        }

        .results-info strong {
            color: #1a1a2e;
        }

        /* ── ACTIVE FILTERS ── */
        .active-filters {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-tag {
            background: #e94560;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
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

        /* ── JOBS GRID ── */
        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(330px, 1fr));
            gap: 20px;
        }

        .job-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            border-top: 3px solid #e94560;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }

        .job-card h3 {
            font-size: 18px;
            margin-bottom: 6px;
            color: #1a1a2e;
        }

        .job-card .company {
            color: #e94560;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .job-card .meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            font-size: 13px;
            color: #666;
            margin-bottom: 16px;
        }

        .job-card .description-preview {
            font-size: 13px;
            color: #888;
            line-height: 1.5;
            margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .btn {
            display: inline-block;
            padding: 9px 22px;
            background: #e94560;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            transition: background 0.3s;
            text-align: center;
        }

        .btn:hover { background: #c73652; }

        /* ── NO JOBS ── */
        .no-jobs {
            text-align: center;
            padding: 80px 20px;
            color: #888;
        }

        .no-jobs h3 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #1a1a2e;
        }

        .no-jobs p { margin-bottom: 20px; }

        .no-jobs a {
            color: #e94560;
            text-decoration: none;
            font-weight: 600;
        }

        /* ── FOOTER ── */
        .footer {
            background: #1a1a2e;
            color: #aaa;
            text-align: center;
            padding: 20px;
            margin-top: 60px;
            font-size: 13px;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <%-- Search Header --%>
    <div class="search-header">
        <h1>Browse All Jobs</h1>

        <form class="search-bar" action="/jobs" method="get">
            <input type="text"
                   name="keyword"
                   placeholder="Job title or keyword"
                   value="${keyword}"/>
            <input type="text"
                   name="location"
                   placeholder="Location"
                   value="${location}"/>
            <button type="submit">🔍 Search</button>
            <c:if test="${not empty keyword or not empty location}">
                <a href="/jobs" class="btn-clear">✕ Clear</a>
            </c:if>
        </form>
    </div>

    <div class="container">

        <%-- Flash Messages --%>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <%-- Results Info --%>
        <div class="results-info">
            <p>
                Showing <strong>${jobs.size()}</strong> job(s)
                <c:if test="${not empty keyword or not empty location}">
                    for your search
                </c:if>
            </p>

            <%-- Active Filter Tags --%>
            <div class="active-filters">
                <c:if test="${not empty keyword}">
                    <span class="filter-tag">🔍 ${keyword}</span>
                </c:if>
                <c:if test="${not empty location}">
                    <span class="filter-tag">📍 ${location}</span>
                </c:if>
            </div>
        </div>

        <%-- Jobs Grid --%>
        <c:choose>
            <c:when test="${empty jobs}">
                <div class="no-jobs">
                    <h3>No jobs found</h3>
                    <c:choose>
                        <c:when test="${not empty keyword or not empty location}">
                            <p>
                                No jobs match your search criteria.
                                Try different keywords or location.
                            </p>
                            <a href="/jobs">View all jobs</a>
                        </c:when>
                        <c:otherwise>
                            <p>No jobs are available at the moment.</p>
                            <p>Check back soon!</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="jobs-grid">
                    <c:forEach var="job" items="${jobs}">
                        <div class="job-card">
                            <div>
                                <h3>${job.title}</h3>
                                <div class="company">
                                    🏢 ${job.employer.company}
                                </div>
                                <div class="meta">
                                    <c:if test="${not empty job.location}">
                                        <span>📍 ${job.location}</span>
                                    </c:if>
                                    <c:if test="${not empty job.jobType}">
                                        <span>💼 ${job.jobType}</span>
                                    </c:if>
                                    <c:if test="${not empty job.salaryRange}">
                                        <span>💰 ${job.salaryRange}</span>
                                    </c:if>
                                </div>
                                <c:if test="${not empty job.description}">
                                    <div class="description-preview">
                                        ${job.description}
                                    </div>
                                </c:if>
                            </div>
                            <a href="/jobs/${job.id}" class="btn">
                                View Details →
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <div class="footer">
        <p>&copy; 2026 Job Portal — IEM UEM Capgemini Training Project</p>
    </div>

</body>
</html>