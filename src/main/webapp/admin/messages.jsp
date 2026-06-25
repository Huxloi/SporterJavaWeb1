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
            <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN</h4>
            <a href="${pageContext.request.contextPath}/admin/index" class="active"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box-open me-2"></i> Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-cart-arrow-down me-2"></i> Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-2"></i> Khách hàng</a>
            <a href="${pageContext.request.contextPath}/admin/posts"><i class="fa-newspaper me-2"></i> Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/comments"><i class="fa-solid fa-comments me-2"></i> Quản lý Bình luận</a>
            <a href="${pageContext.request.contextPath}/admin/reports"><i class="fa-solid fa-chart-line me-2"></i> Thống kê & Báo cáo</a>
            <hr class="text-secondary mx-3">
            <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="fa-solid fa-shop me-2"></i> Xem Cửa hàng</a>
            <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
        </div>

        <div class="col-md-10 content">
            <h2 class="fw-bold mb-4">Danh sách tin nhắn khách hàng</h2>

            <c:if test="${param.replySuccess == true}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ✔️ Phản hồi yêu cầu thành công! Trạng thái đã được cập nhật.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card shadow-sm border-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                    <tr><th>ID</th><th>Người gửi</th><th>SĐT</th><th>Chủ đề</th><th>Nội dung</th><th>Thời gian</th><th>Trạng thái</th><th>Chức năng</th></tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listContacts}" var="c">
                        <tr>
                            <td>#${c.id}</td>
                            <td class="fw-bold">${c.name}</td>
                            <td>${c.phone}</td>
                            <td>${c.subject}</td>
                            <td>${c.messageContent}</td>
                            <td><fmt:formatDate value="${c.sentAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <span class="badge ${c.isReplied == 0 ? 'bg-warning text-dark' : 'bg-success'}">
                                    ${c.isReplied == 0 ? 'Chưa' : 'Đã'} xử lý
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.isReplied == 0}">
                                        <a href="${pageContext.request.contextPath}/admin/reply-message?id=${c.id}" class="btn btn-sm btn-primary">
                                            <i class="fa-solid fa-reply me-1"></i> Phản hồi
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success"><i class="fa-solid fa-circle-check me-1"></i> Đã xong</span>
                                        <div class="small text-muted fst-italic mt-1 border-top pt-1">Trả lời: ${c.replyContent}</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>