<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Khách hàng - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
    .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
    .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
    .content { padding: 30px; background-color: #f8f9fa; min-height: 100vh;}
  </style>
</head>
<body>
<div class="container-fluid p-0">
  <div class="row g-0">
    <div class="col-md-2 sidebar shadow-lg">
      <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN SPORTER</h4>
      <a href="${pageContext.request.contextPath}/admin/index"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
      <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
      <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box-open me-2"></i> Sản phẩm</a>
      <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-cart-arrow-down me-2"></i> Đơn hàng</a>
      <a href="${pageContext.request.contextPath}/admin/users" class="active"><i class="fa-solid fa-users me-2"></i> Khách hàng</a>
      <a href="${pageContext.request.contextPath}/admin/posts"><i class="fa-solid fa-newspaper me-2"></i> Bài viết</a>
      <a href="${pageContext.request.contextPath}/admin/comments"><i class="fa-solid fa-comments me-2"></i> Quản lý Bình luận</a>
      <a href="${pageContext.request.contextPath}/admin/reports"><i class="fa-solid fa-chart-line me-2"></i> Thống kê & Báo cáo</a>
      <hr class="text-secondary mx-3">
      <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="fa-solid fa-shop me-2"></i> Xem Cửa hàng</a>
      <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
    </div>

    <div class="col-md-10 content">
      <h2 class="fw-bold mb-4"><i class="fa-solid fa-users text-primary me-2"></i> Quản lý Thành viên</h2>

      <c:if test="${not empty message}"><div class="alert alert-success fw-bold">${message}</div></c:if>
      <c:if test="${not empty error}"><div class="alert alert-danger fw-bold">${error}</div></c:if>

      <div class="card shadow-sm border-0">
        <div class="card-body p-0">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
            <tr>
              <th class="ps-4">ID</th>
              <th>Tên Đăng Nhập</th>
              <th>Địa chỉ Email</th>
              <th>Vai trò (Role)</th>
              <th class="text-center">Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listUsers}" var="u">
              <tr>
                <td class="ps-4 fw-bold text-secondary">#${u.id}</td>
                <td class="fw-bold text-dark">
                  <i class="fa-solid fa-user-circle text-secondary me-2"></i>${u.username}
                </td>
                <td>${u.email}</td>
                <td>
                  <span class="badge ${u.role == 'admin' ? 'bg-danger' : 'bg-primary'} px-3 py-2">
                      ${u.role == 'admin' ? 'Quản trị viên' : 'Khách hàng'}
                  </span>
                </td>
                <td class="text-center">
                  <c:choose>
                    <c:when test="${u.id == sessionScope.acc.id}">
                      <button class="btn btn-sm btn-secondary disabled" title="Đang đăng nhập">
                        <i class="fa-solid fa-ban"></i> Đang Online
                      </button>
                    </c:when>
                    <c:otherwise>
                      <a href="users?action=delete&id=${u.id}"
                         onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này không?');"
                         class="btn btn-sm btn-outline-danger">
                        <i class="fa-solid fa-trash-can"></i> Xóa
                      </a>
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
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>