<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar">
    <div class="navbar-brand">
        <a href="/">💼 Job Portal</a>
    </div>

    <div class="navbar-links">

        <!-- Always visible -->
        <a href="/jobs">Browse Jobs</a>

        <!-- Logged in as EMPLOYER -->
        <c:if test="${sessionScope.userType == 'EMPLOYER'}">
            <a href="/employers/dashboard">Dashboard</a>
            <a href="/jobs/post">Post a Job</a>
            <a href="/employers/edit">Edit Profile</a>
            <a href="/employers/logout">Logout</a>
        </c:if>

        <!-- Logged in as SEEKER -->
        <c:if test="${sessionScope.userType == 'SEEKER'}">
            <a href="/seekers/dashboard">Dashboard</a>
            <a href="/seekers/edit">Edit Profile</a>
            <a href="/seekers/logout">Logout</a>
        </c:if>

        <!-- Not logged in -->
        <c:if test="${empty sessionScope.userType}">
            <a href="/employers/register">Employer Register</a>
            <a href="/employers/login">Employer Login</a>
            <a href="/seekers/register">Seeker Register</a>
            <a href="/seekers/login">Seeker Login</a>
        </c:if>

    </div>
</nav>