<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Phản hồi Tin nhắn - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; }
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500; }
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
        .content { padding: 30px; background-color: #f8f9fa; }
        .form-control:disabled { background-color: #e9ecef; opacity: 1; }
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
            <h2 class="fw-bold mb-4">Chi tiết và Phản hồi Yêu cầu Hỗ trợ</h2>

            <div class="card shadow-sm border-0 p-4 mb-4">
                <h5 class="fw-bold text-primary border-bottom pb-2 mb-3"><i class="fa-solid fa-circle-info me-2"></i> Thông tin khách hàng gửi</h5>
                <div class="row mb-2">
                    <div class="col-md-3 fw-bold">Họ tên khách hàng:</div>
                    <div class="col-md-9"><input type="text" class="form-control-plaintext fw-bold text-dark" value="${c.name}" readonly></div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-3 fw-bold">Số điện thoại:</div>
                    <div class="col-md-9"><input type="text" class="form-control-plaintext" value="${c.phone}" readonly></div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-3 fw-bold">Chủ đề:</div>
                    <div class="col-md-9"><input type="text" class="form-control-plaintext fw-bold" value="${c.subject}" readonly></div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-3 fw-bold">Nội dung tin nhắn:</div>
                    <div class="col-md-9">
                        <textarea class="form-control bg-light" rows="4" readonly>${c.messageContent}</textarea>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md-3 fw-bold">Thời gian gửi:</div>
                    <div class="col-md-9"><input type="text" class="form-control-plaintext" value="<fmt:formatDate value="${c.sentAt}" pattern="dd/MM/yyyy HH:mm"/>" readonly></div>
                </div>
            </div>

            <div class="card shadow-sm border-0 p-4">
                <h5 class="fw-bold text-success border-bottom pb-2 mb-3"><i class="fa-solid fa-feather me-2"></i> Soạn nội dung phản hồi / Xử lý</h5>
                <form action="${pageContext.request.contextPath}/admin/reply-message" method="POST">
                    <input type="hidden" name="id" value="${c.id}">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Nội dung trả lời (*)</label>
                        <textarea class="form-control" name="adminReply" rows="5" required placeholder="Nhập nội dung phản hồi/xử lý cho khách hàng tại đây..."></textarea>
                    </div>
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/messages" class="btn btn-secondary"><i class="fa-solid fa-arrow-left me-2"></i> Hủy, quay lại</a>
                        <button type="submit" class="btn btn-success"><i class="fa-solid fa-paper-plane me-2"></i> Gửi phản hồi & Đánh dấu đã xử lý</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>