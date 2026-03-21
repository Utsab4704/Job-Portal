<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar">
    <div class="navbar__inner">
        <a href="/" class="navbar__brand">JobPortal</a>
        <ul class="navbar__links">
            <li><a href="/jobs">Browse Jobs</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInEmployer}">
                    <li><a href="/employers/dashboard">Dashboard</a></li>
                    <li><a href="/jobs/post">Post a Job</a></li>
                    <li><a href="/employers/logout">Logout</a></li>
                </c:when>
                <c:when test="${not empty sessionScope.loggedInSeeker}">
                    <li><a href="/seekers/dashboard">Dashboard</a></li>
                    <li><a href="/seekers/logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/employers/login">Employer Login</a></li>
                    <li><a href="/seekers/login">Seeker Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>