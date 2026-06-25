<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký tài khoản - Sporter</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body { background-color: #f8f9fa; }
    .register-card { max-width: 420px; margin: 60px auto; padding: 25px; border: none; border-radius: 12px; }
  </style>
</head>
<body>

<div class="container">
  <div class="card register-card shadow">
    <div class="card-body">
      <h3 class="card-title text-center mb-4 fw-bold text-success"><i class="fa-solid fa-user-plus me-2"></i>ĐĂNG KÝ</h3>

      <c:if test="${not empty error}">
        <div class="alert alert-danger p-2 small"><i class="fa-solid fa-circle-xmark me-1"></i> ${error}</div>
      </c:if>

      <form action="register" method="post" onsubmit="return validateForm();">
        <div class="mb-3">
          <label class="form-label fw-bold small">Tên đăng nhập (*)</label>
          <input type="text" name="username" class="form-control" placeholder="Tên tài khoản viết liền" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-bold small">Địa chỉ Email (*)</label>
          <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
        </div>
        <div class="mb-3">
          <label class="form-label fw-bold small">Mật khẩu (*)</label>
          <input type="password" id="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" required>
        </div>
        <div class="mb-4">
          <label class="form-label fw-bold small">Xác nhận mật khẩu (*)</label>
          <input type="password" id="re_password" class="form-control" placeholder="Nhập lại mật khẩu" required>
          <div id="pass_error" class="text-danger small mt-1" style="display:none;">❌ Mật khẩu xác nhận không trùng khớp!</div>
        </div>
        <button type="submit" class="btn btn-success w-100 fw-bold py-2 shadow-sm">ĐĂNG KÝ TÀI KHOẢN</button>
      </form>

      <div class="mt-4 text-center small">
        Đã có tài khoản thành viên? <a href="login" class="fw-bold text-decoration-none">Đăng nhập</a>
      </div>
    </div>
  </div>
</div>

<script>
  // Kiểm tra tính trùng khớp mật khẩu ở phía Client trước khi gửi form đi
  function validateForm() {
    const pass = document.getElementById("password").value;
    const rePass = document.getElementById("re_password").value;
    const errDiv = document.getElementById("pass_error");

    if (pass !== rePass) {
      errDiv.style.display = "block";
      return false;
    }
    errDiv.style.display = "none";
    return true;
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>