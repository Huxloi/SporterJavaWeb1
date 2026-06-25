<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Sản phẩm - Sporter</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #fff; }

    /* Logo & Navbar Styling */
    .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; }
    .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
    .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }
    .nav-link { font-weight: 500; color: #555 !important; font-size: 0.95rem; }
    .nav-link:hover { color: #0d6efd !important; }

    /* Search & Utilities */
    .search-box { border-radius: 6px 0 0 6px; }
    .btn-search { border-radius: 0 6px 6px 0; padding: 0 20px; }
    .util-link { color: #555; text-decoration: none; font-weight: 500; font-size: 0.95rem; transition: 0.2s; }
    .util-link:hover { color: #0d6efd; }

    /* Category Sidebar Styling */
    .list-group-item a { color: #333; font-weight: 500; }
    .list-group-item a:hover, .list-group-item a.active-cat { color: #0d6efd; font-weight: bold; }

    /* Product Card */
    .product-card { border: 1px solid #f0f0f0; border-radius: 12px; transition: 0.3s; overflow: hidden; }
    .product-card:hover { box-shadow: 0 12px 25px rgba(0,0,0,0.08); transform: translateY(-5px); }
    .product-img { height: 200px; object-fit: contain; background-color: #f8f9fa; padding: 15px; }
    .product-title { font-size: 1.05rem; font-weight: 600; color: #333; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 45px;}
    .product-price { color: #e53935; font-weight: 700; font-size: 1.15rem; }
    .btn-xem { background-color: #2e7d32; border: none; font-weight: 600; border-radius: 4px; padding: 8px 20px;}
    .btn-xem:hover { background-color: #1b5e20; }

    /* Footer */
    footer { background-color: #2b3035; color: #adb5bd; padding: 60px 0 30px; margin-top: 60px; }
    footer h5 { color: white; font-weight: 700; margin-bottom: 20px; }
    .footer-logo { font-size: 2rem; }

    /* Pagination Custom */
    .pagination .page-link { color: #0d6efd; border-radius: 6px; margin: 0 4px; }
    .pagination .page-item.active .page-link { background-color: #0d6efd; border-color: #0d6efd; color: #fff; }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white sticky-top shadow-sm">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center me-4" href="index">
      <i class="fa-solid fa-hurricane logo-icon"></i>
      <span class="logo-text">SPORTS</span>
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-2">
        <li class="nav-item"><a class="nav-link" href="index">Trang Chủ</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Danh mục Sản phẩm</a>
          <ul class="dropdown-menu shadow border-0">
            <c:forEach items="${listCC}" var="cat">
              <li><a class="dropdown-item py-2" href="index?catId=${cat.id}">${cat.name}</a></li>
            </c:forEach>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="news">Bài viết</a></li>
        <li class="nav-item"><a class="nav-link" href="contact">Liên hệ & Phản hồi</a></li>
      </ul>

      <form class="d-flex me-4" action="index" method="get">
        <input class="form-control search-box" type="search" name="search" placeholder="Tìm kiếm sản phẩm..." required>
        <button class="btn btn-outline-primary btn-search" type="submit">Tìm</button>
      </form>

      <div class="d-flex align-items-center gap-4">
        <div class="dropdown">
          <a href="#" class="util-link d-flex align-items-center" data-bs-toggle="dropdown">
            <i class="fa-solid fa-cart-shopping fs-5 me-2 text-secondary"></i>
            Giỏ hàng
            <c:if test="${sessionScope.cart != null && sessionScope.cart.items.size() > 0}">
              <span class="badge bg-danger rounded-pill ms-1">${sessionScope.cart.items.size()}</span>
            </c:if>
          </a>
          <div class="dropdown-menu dropdown-menu-end p-3 shadow-lg border-0" style="width: 320px;">
            <c:choose>
              <c:when test="${sessionScope.cart != null && sessionScope.cart.items.size() > 0}">
                <h6 class="fw-bold border-bottom pb-2">Giỏ hàng của bạn</h6>
                <c:forEach items="${sessionScope.cart.items}" var="i">
                  <div class="d-flex align-items-center mb-3">
                    <img src="${i.product.imageUrl}" style="width: 50px; height: 50px; object-fit: cover;" class="rounded border me-2">
                    <div class="flex-grow-1">
                      <div class="text-truncate" style="max-width: 180px; font-size: 0.85rem; font-weight: 600;">${i.product.name}</div>
                      <small class="text-danger fw-bold">${i.quantity} x <fmt:formatNumber value="${i.price}" type="number"/>đ</small>
                    </div>
                  </div>
                </c:forEach>
                <div class="border-top pt-2 mt-2">
                  <div class="d-flex justify-content-between fw-bold mb-3">
                    <span>Tổng:</span> <span class="text-danger"><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number"/>đ</span>
                  </div>
                  <a href="cart" class="btn btn-primary btn-sm w-100 mb-2">Xem Giỏ Hàng</a>
                </div>
              </c:when>
              <c:otherwise>
                <div class="text-center text-muted py-3">
                  <i class="fa-solid fa-cart-arrow-down fs-3 mb-2"></i><br>Giỏ hàng trống
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="dropdown">
          <c:choose>
            <c:when test="${sessionScope.acc != null}">
              <a href="#" class="util-link d-flex align-items-center" data-bs-toggle="dropdown">
                Tài khoản (${sessionScope.acc.username}) <i class="fa-solid fa-caret-down ms-1"></i>
              </a>
              <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                <c:if test="${sessionScope.acc.isAdmin()}">
                  <li><a class="dropdown-item" href="admin/index"><i class="fa-solid fa-gauge me-2 text-secondary"></i>Trang quản trị</a></li>
                </c:if>
                <li><a class="dropdown-item" href="my_orders"><i class="fa-solid fa-box me-2 text-secondary"></i>Đơn hàng</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a></li>
              </ul>
            </c:when>
            <c:otherwise>
              <a href="login" class="util-link">Đăng nhập</a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </div>
</nav>

<div class="container my-5">
  <div class="row">
    <div class="col-md-3 mb-4">
      <div class="card border-0 shadow-sm p-3 h-100">
        <h5 class="fw-bold border-bottom pb-2 mb-3"><i class="fa-solid fa-list me-2"></i> Danh mục</h5>
        <ul class="list-group list-group-flush">
          <li class="list-group-item border-0 px-0">
            <a href="products" class="text-decoration-none active-cat text-primary">Tất cả sản phẩm</a>
          </li>
          <c:forEach items="${listCC}" var="cat">
            <li class="list-group-item border-0 px-0">
              <a href="index?catId=${cat.id}" class="text-decoration-none text-dark">${cat.name}</a>
            </li>
          </c:forEach>
        </ul>
      </div>
    </div>

    <div class="col-md-9">
      <h3 class="fw-bold mb-4" style="color: #1a237e;">TẤT CẢ SẢN PHẨM</h3>

      <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:choose>
          <c:when test="${not empty listP}">
            <c:forEach items="${listP}" var="p">
              <div class="col">
                <div class="card product-card h-100 d-flex flex-column">
                  <img src="${p.imageUrl}" class="card-img-top product-img" alt="${p.name}">
                  <div class="card-body d-flex flex-column">
                    <h6 class="product-title" title="${p.name}">${p.name}</h6>
                    <p class="product-price mt-2 mb-3">
                      <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/> VNĐ
                    </p>
                    <a href="product_detail?id=${p.id}" class="btn btn-xem text-white mt-auto align-self-start w-100">Xem Chi tiết</a>
                  </div>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="col-12 text-center my-5 py-5 text-muted">
              <i class="fa-solid fa-box-open fa-4x mb-3 text-light"></i>
              <h4>Không tìm thấy sản phẩm nào!</h4>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <c:if test="${endP > 1}">
        <nav aria-label="Page navigation" class="mt-5">
          <ul class="pagination justify-content-center">
            <c:if test="${tag > 1}">
              <li class="page-item">
                <a class="page-link" href="products?page=${tag - 1}" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
            </c:if>
            <c:forEach begin="1" end="${endP}" var="i">
              <li class="page-item ${tag == i ? 'active' : ''}">
                <a class="page-link" href="products?page=${i}">${i}</a>
              </li>
            </c:forEach>
            <c:if test="${tag < endP}">
              <li class="page-item">
                <a class="page-link" href="products?page=${tag + 1}" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </c:if>
          </ul>
        </nav>
      </c:if>

    </div>
  </div>
</div>

<footer>
  <div class="container">
    <div class="row g-5">
      <div class="col-md-4">
        <div class="mb-3 d-flex align-items-center footer-logo text-success fw-bold">
          <i class="fa-solid fa-hurricane me-2"></i> SPORTS
        </div>
        <p class="small text-secondary mb-4">Cửa hàng đồ thể thao hàng đầu Việt Nam.</p>
        <p class="small text-secondary">Chất lượng - Uy tín - Giá tốt.</p>
      </div>

      <div class="col-md-4">
        <h5>Hỗ trợ Khách hàng</h5>
        <ul class="list-unstyled small text-secondary" style="line-height: 2;">
          <li><a href="#" class="text-secondary text-decoration-none hover-white">Chính sách đổi trả</a></li>
          <li><a href="#" class="text-secondary text-decoration-none hover-white">Chính sách bảo mật</a></li>
          <li><a href="contact" class="text-secondary text-decoration-none hover-white">Liên hệ</a></li>
        </ul>
      </div>

      <div class="col-md-4">
        <h5>Liên hệ</h5>
        <p class="small text-secondary mb-2">Địa chỉ: 123 Đường Thể Thao, Quận 1, TP.HCM</p>
        <p class="small text-secondary mb-2">Email: support@sportshop.vn</p>
        <p class="small text-secondary mb-2">Hotline: 0987.654.321</p>
      </div>
    </div>

    <div class="border-top border-secondary mt-5 pt-4 text-center small text-secondary">
      &copy; 2026 SPORT SHOP. All rights reserved.
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>