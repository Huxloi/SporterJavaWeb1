<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Bình Luận</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .card-header { background-color: #fff; border-bottom: 2px solid #e9ecef; }
        .table thead { background-color: #e9ecef; }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header p-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="fa-solid fa-comments me-2"></i> QUẢN LÝ BÌNH LUẬN</h4>
            <a href="index" class="btn btn-secondary btn-sm"><i class="fa-solid fa-house me-1"></i> Về Admin</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-4">ID</th>
                    <th>Người gửi</th>
                    <th>Nội dung Bình luận</th>
                    <th>Sản phẩm</th>
                    <th>Thời gian</th>
                    <th>Thao Tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listComments}" var="c">
                    <tr>
                        <td class="ps-4 fw-bold">${c.id}</td>
                        <td><i class="fa-solid fa-user-circle me-1"></i> ${c.username}</td>
                        <td>${c.commentText}</td>
                        <td>
                            <a href="#" class="text-decoration-none">${c.productName}</a>
                        </td>
                        <td><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/comments?action=delete&id=${c.id}"
                               onclick="return confirm('Bạn chắc chắn muốn xóa?');"
                               class="btn btn-danger btn-sm">
                                <i class="fa-solid fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>