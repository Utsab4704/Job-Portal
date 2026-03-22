<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
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
            max-width: 600px;
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

        /* ── READ ONLY EMAIL ── */
        .email-display {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #f0f0f0;
            border-radius: 6px;
            font-size: 14px;
            background: #f9f9f9;
            color: #999;
        }

        /* ── VALIDATION ERRORS ── */
        .error {
            color: #e94560;
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }

        /* ── SECTION LABEL ── */
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

        /* ── PASSWORD SECTION ── */
        .password-section {
            border-top: 1px solid #f0f0f0;
            padding-top: 20px;
            margin-top: 10px;
        }

        .password-section h4 {
            font-size: 14px;
            color: #1a1a2e;
            margin-bottom: 15px;
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
    </style>
</head>
<body>

    <%@ include file="/common/navbar.jsp" %>

    <div class="container">
        <div class="card">
            <h2>Edit Profile</h2>
            <p>Update your personal information below</p>

            <%-- Flash Messages --%>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form:form action="/seekers/edit"
                       method="post"
                       modelAttribute="jobSeeker">

                <%-- Account Details Section --%>
                <div class="section-label">Account Details</div>

                <%-- Email read only --%>
                <div class="form-group">
                    <label>Email Address</label>
                    <div class="email-display">
                        ${jobSeeker.email}
                    </div>
                    <span class="hint">
                        Email cannot be changed as it is
                        your login identifier
                    </span>
                </div>

                <%-- Full Name --%>
                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <form:input path="fullName"
                                id="fullName"
                                placeholder="e.g. Utsab Chatterjee"/>
                    <form:errors path="fullName" cssClass="error"/>
                </div>

                <%-- Profile Details Section --%>
                <div class="section-label">Profile Details</div>

                <%-- Skills --%>
                <div class="form-group">
                    <label for="skills">Skills</label>
                    <form:input path="skills"
                                id="skills"
                                placeholder="e.g. Java, Spring Boot, MySQL"/>
                    <span class="hint">
                        Separate multiple skills with commas
                    </span>
                    <form:errors path="skills" cssClass="error"/>
                </div>

                <%-- Location --%>
                <div class="form-group">
                    <label for="location">Location</label>
                    <form:input path="location"
                                id="location"
                                placeholder="e.g. Kolkata, West Bengal"/>
                    <form:errors path="location" cssClass="error"/>
                </div>

                <%-- Resume Link --%>
                <div class="form-group">
                    <label for="resumeLink">Resume Link</label>
                    <form:input path="resumeLink"
                                id="resumeLink"
                                placeholder="https://drive.google.com/..."/>
                    <span class="hint">
                        Paste a link to your resume on
                        Google Drive or similar
                    </span>
                    <form:errors path="resumeLink" cssClass="error"/>
                </div>

                <%-- Password Section --%>
                <div class="password-section">
                    <h4>🔒 Change Password</h4>

                    <div class="form-group">
                        <label for="password">New Password</label>
                        <form:password path="password"
                                       id="password"
                                       placeholder="Leave blank to keep
                                        current password"/>
                        <span class="hint">
                            Leave blank if you do not want
                            to change your password
                        </span>
                        <form:errors path="password" cssClass="error"/>
                    </div>
                </div>

                <%-- Action Buttons --%>
                <div class="btn-row">
                    <a href="/seekers/dashboard"
                       class="btn-cancel">
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