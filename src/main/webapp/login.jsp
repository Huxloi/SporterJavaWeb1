<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập - Sporter</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body { background-color: #f8f9fa; }
    .login-card { max-width: 420px; margin: 80px auto; padding: 25px; border: none; border-radius: 12px; }
  </style>
</head>
<body>

<div class="container">
  <div class="card login-card shadow">
    <div class="card-body">
      <h3 class="card-title text-center mb-4 fw-bold text-primary"><i class="fa-solid fa-user-check me-2"></i>ĐĂNG NHẬP</h3>

      <c:if test="${not empty error}">
        <div class="alert alert-danger p-2 small"><i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}</div>
      </c:if>

      <c:if test="${not empty success}">
        <div class="alert alert-success p-2 small">${success}</div>
      </c:if>

      <form action="login" method="post">
        <div class="mb-3">
          <label class="form-label fw-bold small">Tên đăng nhập</label>
          <input type="text" name="username" class="form-control" placeholder="Nhập username" required autofocus>
        </div>
        <div class="mb-4">
          <label class="form-label fw-bold small">Mật khẩu</label>
          <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
        </div>
        <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm">ĐĂNG NHẬP</button>
      </form>

      <div class="mt-4 text-center small">
        Chưa có tài khoản? <a href="register" class="fw-bold text-decoration-none">Đăng ký ngay</a>
      </div>
      <div class="mt-2 text-center small">
        <a href="index" class="text-secondary"><i class="fa-solid fa-arrow-left me-1"></i> Quay về trang chủ</a>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>