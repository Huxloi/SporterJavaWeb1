<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>THANH TOÁN ĐƠN HÀNG - SPORTS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }
    .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
    .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
    .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }

    .page-header-title { color: #212529; font-weight: 400; text-align: center; font-size: 2.2rem; letter-spacing: 1px; margin-bottom: 30px; }
    .checkout-card { background-color: #fff; border-radius: 8px; padding: 30px; border: 1px solid #eef0f2; }
    .summary-card { background-color: #fff; border-radius: 8px; padding: 25px; border: 1px solid #eef0f2; }
    .card-inner-title { font-size: 1.2rem; font-weight: 700; color: #212529; margin-bottom: 25px; }
    .btn-complete-order { background-color: #dc3545; color: white; font-weight: 700; border: none; width: 100%; padding: 14px; border-radius: 6px; font-size: 1.1rem; text-transform: uppercase; letter-spacing: 0.5px;}
    .btn-complete-order:hover { background-color: #bd2130; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-5">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/index">
      <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
    </a>
  </div>
</nav>

<div class="container my-5" style="max-width: 1140px;">
  <h2 class="page-header-title text-uppercase">THANH TOÁN ĐƠN HÀNG</h2>

  <div class="text-end mb-4">
    <a href="cart" class="btn btn-sm btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại Giỏ hàng</a>
  </div>

  <form action="checkout" method="post" class="m-0">
    <div class="row g-4">
      <div class="col-lg-7">
        <div class="checkout-card shadow-sm">
          <div class="card-inner-title"><i class="fa-solid fa-location-dot text-primary me-2"></i> 1. Thông tin Giao hàng</div>

          <div class="mb-3">
            <label class="form-label small fw-bold text-secondary">Họ và Tên</label>
            <input type="text" name="name" class="form-control py-2" value="${sessionScope.acc.username}" required>
          </div>

          <div class="mb-3">
            <label class="form-label small fw-bold text-secondary">Địa chỉ chi tiết (*)</label>
            <input type="text" name="address" class="form-control py-2" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố" required>
          </div>

          <div class="mb-4">
            <label class="form-label small fw-bold text-secondary">Số điện thoại (*)</label>
            <input type="tel" name="phone" class="form-control py-2" placeholder="Nhập số điện thoại nhận hàng..." required>
          </div>

          <div class="card-inner-title pt-3 border-top"><i class="fa-solid fa-wallet text-primary me-2"></i> 2. Phương thức Thanh toán</div>
          <div class="form-check p-3 border rounded mb-2 bg-light bg-opacity-50">
            <input class="form-check-input ms-1 me-2" type="radio" name="paymentMethod" id="codPayment" value="COD" checked>
            <label class="form-check-label fw-bold text-dark" for="codPayment">Thanh toán khi nhận hàng (COD)</label>
          </div>
          <div class="form-check p-3 border rounded">
            <input class="form-check-input ms-1 me-2" type="radio" name="paymentMethod" id="bankingPayment" value="BANKING">
            <label class="form-check-label fw-semibold text-dark" for="bankingPayment">Chuyển khoản ngân hàng (Sẽ liên hệ sau khi đặt hàng)</label>
          </div>
        </div>
      </div>

      <div class="col-lg-5">
        <div class="summary-card shadow-sm">
          <div class="card-inner-title"><i class="fa-solid fa-list-check text-secondary me-2"></i> Tóm tắt Đơn hàng</div>

          <div class="mb-4" style="max-height: 240px; overflow-y: auto;">
            <c:forEach items="${sessionScope.cart.items}" var="item">
              <div class="d-flex justify-content-between align-items-center border-bottom py-2">
                <div style="max-width: 70%;">
                  <span class="fw-bold text-dark d-block text-truncate" style="font-size: 0.9rem;">${item.product.name}</span>
                  <small class="text-muted">Màu: ${item.color} | Size: ${item.size} x ${item.quantity}</small>
                </div>
                <span class="fw-bold text-secondary"><fmt:formatNumber value="${item.price * item.quantity}" type="number"/> đ</span>
              </div>
            </c:forEach>
          </div>

          <div class="d-flex justify-content-between mb-2 text-secondary" style="font-size: 0.95rem;">
            <span>Phí vận chuyển:</span>
            <span class="text-success fw-bold">MIỄN PHÍ</span>
          </div>
          <div class="d-flex justify-content-between mb-4 border-top pt-3 text-dark">
            <span class="fw-bold fs-5">TỔNG THANH TOÁN:</span>
            <span class="fw-bold fs-4 text-danger"><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number"/> VNĐ</span>
          </div>

          <button type="submit" class="btn-complete-order shadow-sm">HOÀN TẤT ĐẶT HÀNG</button>
          <div class="text-center text-muted small mt-3"><i class="fa-solid fa-lock text-success me-1"></i> Giao dịch được bảo mật 100%</div>
        </div>
      </div>
    </div>
  </form>
</div>
</body>
</html>