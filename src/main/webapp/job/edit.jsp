<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Job</title>
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
            max-width: 650px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            border-top: 4px solid #e94560;
        }

        .card h2 {
            font-size: 26px;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .card p {
            color: #888;
            margin-bottom: 30px;
            font-size: 14px;
        }

        /* ── FORM FIELDS ── */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #555;
            margin-bottom: 6px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border 0.3s;
            background: white;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #e94560;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        /* ── TWO COLUMN ROW ── */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        /* ── VALIDATION ERRORS ── */
        .error {
            color: #e94560;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }

        /* ── BUTTONS ── */
        .btn-row {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-submit {
            flex: 1;
            padding: 12px;
            background: #e94560;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-submit:hover { background: #c73652; }

        .btn-cancel {
            flex: 1;
            padding: 12px;
            background: #f0f0f0;
            color: #555;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background 0.3s;
        }

        .btn-cancel:hover { background: #e0e0e0; }

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

        /* ── JOB META INFO ── */
        .job-meta {
            background: #f9f9f9;
            border-radius: 6px;
            padding: 12px 16px;
            margin-bottom: 25px;
            font-size: 13px;
            color: #888;
            border-left: 3px solid #e94560;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">
        <div class="card">
            <h2>Edit Job Listing</h2>
            <p>Update the details of your job posting below</p>

            <%-- Flash Messages --%>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <%-- Job Meta Info --%>
            <div class="job-meta">
                ✏️ Editing: <strong>${job.title}</strong>
                &nbsp;|&nbsp;
                Posted by: <strong>${job.employer.company}</strong>
            </div>

            <%-- Edit Form --%>
            <form:form action="/jobs/${job.id}/edit"
                       method="post"
                       modelAttribute="job">

                <%-- Job Title --%>
                <div class="form-group">
                    <label for="title">Job Title *</label>
                    <form:input path="title" id="title"
                                placeholder="e.g. Senior Java Developer"/>
                    <form:errors path="title" cssClass="error"/>
                </div>

                <%-- Description --%>
                <div class="form-group">
                    <label for="description">Job Description</label>
                    <form:textarea path="description" id="description"
                                   placeholder="Describe the role, responsibilities,
                                    requirements..."/>
                    <form:errors path="description" cssClass="error"/>
                </div>

                <%-- Location and Job Type side by side --%>
                <div class="form-row">
                    <div class="form-group">
                        <label for="location">Location</label>
                        <form:input path="location" id="location"
                                    placeholder="e.g. Kolkata"/>
                        <form:errors path="location" cssClass="error"/>
                    </div>

                    <div class="form-group">
                        <label for="jobType">Job Type</label>
                        <form:select path="jobType" id="jobType">
                            <form:option value="">-- Select Type --</form:option>
                            <form:option value="Full-Time">Full-Time</form:option>
                            <form:option value="Part-Time">Part-Time</form:option>
                            <form:option value="Contract">Contract</form:option>
                            <form:option value="Internship">Internship</form:option>
                            <form:option value="Remote">Remote</form:option>
                        </form:select>
                        <form:errors path="jobType" cssClass="error"/>
                    </div>
                </div>

                <%-- Salary Range --%>
                <div class="form-group">
                    <label for="salaryRange">Salary Range</label>
                    <form:input path="salaryRange" id="salaryRange"
                                placeholder="e.g. ₹8 LPA - ₹12 LPA"/>
                    <form:errors path="salaryRange" cssClass="error"/>
                </div>

                <%-- Action Buttons --%>
                <div class="btn-row">
                    <a href="/employers/dashboard" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-submit">
                        Save Changes
                    </button>
                </div>

            </form:form>
        </div>
    </div>

</body>
</html>