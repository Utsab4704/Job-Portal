<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Registration</title>
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
            max-width: 500px;
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

        .form-group input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border 0.3s;
        }

        .form-group input:focus {
            border-color: #e94560;
        }

        .form-group .hint {
            font-size: 12px;
            color: #aaa;
            margin-top: 4px;
        }

        /* ── VALIDATION ERRORS ── */
        .error {
            color: #e94560;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }

        /* ── SUBMIT BUTTON ── */
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: #e94560;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .btn-submit:hover { background: #c73652; }

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

        /* ── BOTTOM LINKS ── */
        .bottom-links {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #888;
        }

        .bottom-links a {
            color: #e94560;
            text-decoration: none;
            font-weight: 600;
        }

        .bottom-links a:hover { text-decoration: underline; }

        .divider {
            margin: 0 8px;
            color: #ddd;
        }

        /* ── SECTION DIVIDER ── */
        .section-label {
            font-size: 11px;
            font-weight: 600;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 15px;
            margin-top: 5px;
            border-top: 1px solid #f0f0f0;
            padding-top: 20px;
        }
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">
        <div class="card">
            <h2>Job Seeker Registration</h2>
            <p>Create your account to start applying for jobs</p>

            <%-- Flash Messages --%>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form:form action="/seekers/register"
                       method="post"
                       modelAttribute="jobSeeker">

                <%-- Required Fields --%>
                <div class="section-label">Account Details</div>

                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <form:input path="fullName" id="fullName"
                                placeholder="e.g. Utsab Chatterjee"/>
                    <form:errors path="fullName" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <form:input path="email" id="email"
                                type="email"
                                placeholder="utsab@example.com"/>
                    <form:errors path="email" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="password">Password *</label>
                    <form:password path="password" id="password"
                                   placeholder="Minimum 6 characters"/>
                    <form:errors path="password" cssClass="error"/>
                </div>

                <%-- Optional Fields --%>
                <div class="section-label">Profile Details (Optional)</div>

                <div class="form-group">
                    <label for="skills">Skills</label>
                    <form:input path="skills" id="skills"
                                placeholder="e.g. Java, Spring Boot, MySQL"/>
                    <span class="hint">
                        Separate multiple skills with commas
                    </span>
                    <form:errors path="skills" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="location">Location</label>
                    <form:input path="location" id="location"
                                placeholder="e.g. Kolkata, West Bengal"/>
                    <form:errors path="location" cssClass="error"/>
                </div>

                <div class="form-group">
                    <label for="resumeLink">Resume Link</label>
                    <form:input path="resumeLink" id="resumeLink"
                                placeholder="e.g. https://drive.google.com/..."/>
                    <span class="hint">
                        Paste a link to your resume on Google Drive or similar
                    </span>
                    <form:errors path="resumeLink" cssClass="error"/>
                </div>

                <button type="submit" class="btn-submit">
                    Create Account
                </button>

            </form:form>

            <div class="bottom-links">
                Already have an account?
                <a href="/seekers/login">Log in here</a>
                <span class="divider">|</span>
                <a href="/employers/register">Register as Employer</a>
            </div>
        </div>
    </div>

</body>
</html>