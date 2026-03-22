<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Portal - Home</title>
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

        /* ── HERO ── */
        .hero {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: white;
            text-align: center;
            padding: 80px 20px;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 15px;
            color: #e94560;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 40px;
            color: #ccc;
        }

        /* ── SEARCH BAR ── */
        .search-bar {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-bar input {
            padding: 12px 20px;
            width: 280px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            outline: none;
        }

        .search-bar button {
            padding: 12px 30px;
            background: #e94560;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .search-bar button:hover { background: #c73652; }

        /* ── RECENT JOBS ── */
        .section {
            max-width: 1100px;
            margin: 50px auto;
            padding: 0 20px;
        }

        .section h2 {
            font-size: 28px;
            margin-bottom: 25px;
            color: #1a1a2e;
            border-left: 4px solid #e94560;
            padding-left: 12px;
        }

        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .job-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            border-top: 3px solid #e94560;
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        }

        .job-card h3 {
            font-size: 18px;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .job-card .company {
            color: #e94560;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .job-card .meta {
            display: flex;
            gap: 15px;
            font-size: 13px;
            color: #666;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        .job-card .meta span::before {
            margin-right: 4px;
        }

        .btn {
            display: inline-block;
            padding: 8px 20px;
            background: #e94560;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }

        .btn:hover { background: #c73652; }

        /* ── NO JOBS ── */
        .no-jobs {
            text-align: center;
            color: #888;
            font-size: 16px;
            padding: 40px;
        }

        /* ── FLASH MESSAGES ── */
        .alert {
            max-width: 1100px;
            margin: 20px auto;
            padding: 12px 20px;
            border-radius: 5px;
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

    <%-- Include navbar --%>
    <%@ include file="/common/navbar.jsp" %>

    <%-- Flash Messages --%>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error">${errorMessage}</div>
    </c:if>

    <%-- Hero Section --%>
    <div class="hero">
        <h1>Find Your Dream Job</h1>
        <p>Thousands of jobs from top companies — search, apply, succeed</p>

        <form class="search-bar" action="/jobs" method="get">
            <input type="text" name="keyword"
                   placeholder="Job title or keyword"
                   value="${param.keyword}"/>
            <input type="text" name="location"
                   placeholder="Location"
                   value="${param.location}"/>
            <button type="submit">🔍 Search</button>
        </form>
    </div>

    <%-- Recent Jobs Section --%>
    <div class="section">
        <h2>Recent Job Openings</h2>

        <c:choose>
            <c:when test="${empty recentJobs}">
                <div class="no-jobs">
                    No jobs available at the moment. Check back soon!
                </div>
            </c:when>
            <c:otherwise>
                <div class="jobs-grid">
                    <c:forEach var="job" items="${recentJobs}">
                        <div class="job-card">
                            <h3>${job.title}</h3>
                            <div class="company">${job.employer.company}</div>
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
                            <a href="/jobs/${job.id}" class="btn">View Details</a>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Footer --%>
    <div class="footer">
        <p>&copy; 2026 Job Portal — IEM UEM Capgemini Training Project</p>
    </div>

</body>
</html>