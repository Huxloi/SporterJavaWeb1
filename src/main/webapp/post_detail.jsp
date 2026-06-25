<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${post.title} - Sporter News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* Đồng bộ Header SPORTS */
        .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
        .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
        .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }
        .nav-link { font-weight: 500; color: #555 !important; font-size: 0.95rem; }
        .nav-link:hover { color: #0d6efd !important; }
        footer { background-color: #2b3035; color: #adb5bd; padding: 25px 0; margin-top: 80px; text-align: center; }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center me-4" href="${pageContext.request.contextPath}/index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
    </div>
</nav>

<div class="container my-5" style="max-width: 900px;">
    <p><a href="news" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại Tin tức</a></p>

    <div class="card p-4 p-md-5 shadow-sm border-0 bg-white mt-3">
        <h1 class="text-dark fw-bold mb-3">${post.title}</h1>
        <p class="text-secondary small mb-4">
            <i class="fa-regular fa-clock me-1"></i> Đăng ngày:
            <strong><fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/></strong>
        </p>

        <c:if test="${not empty post.imageUrl}">
            <img src="${post.imageUrl}" class="hero-img mb-5 shadow-sm" alt="Ảnh minh họa">
        </c:if>

        <div class="post-content text-dark mb-4">${post.content}</div>

        <hr class="my-4">
        <div class="text-center">
            <h5 class="fw-bold mb-3">Chia sẻ bài viết này</h5>
            <button class="btn btn-primary rounded-circle me-2" style="width:40px; height:40px;"><i class="fa-brands fa-facebook-f"></i></button>
            <button class="btn btn-info rounded-circle me-2 text-white" style="width:40px; height:40px;"><i class="fa-brands fa-twitter"></i></button>
            <button class="btn btn-danger rounded-circle" style="width:40px; height:40px;"><i class="fa-brands fa-pinterest-p"></i></button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>