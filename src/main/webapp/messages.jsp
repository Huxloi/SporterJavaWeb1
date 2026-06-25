<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hộp thư Liên hệ - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; }
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500; }
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd; }
        .content { padding: 30px; background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container-fluid p-0">
    <div class="row g-0">
        <div class="col-md-2 sidebar shadow-lg">
            <div class="text-center pt-4 pb-3">
                <img src="${pageContext.request.contextPath}/images/logo_chinh.png" style="width: 100px; height: 100px; border-radius: 50%; border: 3px solid #fff; object-fit: cover;" alt="logo">
            </div>
            <a href="${pageContext.request.contextPath}/admin/index"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/messages" class="active"><i class="fa-solid fa-envelope me-2"></i> Hộp thư</a>
        </div>
        <div class="col-md-10 content">
            <h2 class="fw-bold mb-4">Danh sách tin nhắn khách hàng</h2>
            <div class="card shadow-sm border-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr><th>ID</th><th>Người gửi</th><th>SĐT</th><th>Chủ đề</th><th>Nội dung</th><th>Thời gian</th><th>Trạng thái</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listContacts}" var="c">
                        <tr>
                            <td>#${c.id}</td>
                            <td class="fw-bold">${c.name}</td>
                            <td>${c.phone}</td>
                            <td>${c.subject}</td>
                            <td>${c.messageContent}</td>
                            <td><fmt:formatDate value="${c.sentAt}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <span class="badge ${c.isReplied == 0 ? 'bg-warning text-dark' : 'bg-success'}">
                                    ${c.isReplied == 0 ? 'Chưa' : 'Đã'} xử lý
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>