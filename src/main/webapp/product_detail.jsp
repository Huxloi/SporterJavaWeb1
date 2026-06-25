<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - SPORTS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }

        /* Đồng bộ Header & Footer */
        .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
        .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
        .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }
        .nav-link { font-weight: 500; color: #555 !important; font-size: 0.95rem; }
        .nav-link:hover { color: #0d6efd !important; }
        .search-box { border-radius: 6px 0 0 6px; }
        .btn-search { border-radius: 0 6px 6px 0; padding: 0 20px; }
        .util-link { color: #555; text-decoration: none; font-weight: 500; font-size: 0.95rem; transition: 0.2s; }
        .util-link:hover { color: #0d6efd; }
        footer { background-color: #2b3035; color: #adb5bd; padding: 60px 0 30px; margin-top: 60px; }
        footer h5 { color: white; font-weight: 700; margin-bottom: 20px; }
        .footer-logo { font-size: 2rem; color: #28a745; font-weight: 900; letter-spacing: -1px; }

        /* Trang Product Detail */
        .product-image-box { border: 1px solid #eaeaea; border-radius: 12px; overflow: hidden; background: #fff; padding: 15px;}
        .product-img { width: 100%; height: auto; object-fit: contain; max-height: 450px; }
        .product-price { color: #e53935; font-size: 2rem; font-weight: 800; }
        .comment-box { border-left: 4px solid #00d2ff; background-color: #fff; border-radius: 8px;}
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center me-4" href="index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-2">
                <li class="nav-item"><a class="nav-link" href="index">Trang Chủ</a></li>
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
                        <i class="fa-solid fa-cart-shopping fs-5 me-2 text-secondary"></i> Giỏ hàng
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
                                <div class="border-top pt-2 mt-2 text-center">
                                    <a href="cart" class="btn btn-primary btn-sm w-100 mb-2">Xem Giỏ Hàng</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-3"><i class="fa-solid fa-cart-arrow-down fs-3 mb-2"></i><br>Giỏ hàng trống</div>
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
                        <c:otherwise><a href="login" class="util-link">Đăng nhập</a></c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="mb-4">
        <a href="index" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại cửa hàng</a>
    </div>

    <div class="row g-4 bg-white p-4 rounded shadow-sm">
        <div class="col-md-5">
            <div class="product-image-box text-center">
                <img src="${product.imageUrl}" class="product-img" alt="${product.name}">
            </div>
        </div>

        <div class="col-md-7">
            <h2 class="fw-bold text-dark mb-2">${product.name}</h2>
            <p class="text-muted mb-3">Danh mục: <span class="badge bg-secondary">${product.categoryName}</span></p>

            <p class="product-price mb-4">
                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> VNĐ
            </p>

            <p class="mb-4 text-secondary">
                Trạng thái:
                <c:choose>
                    <c:when test="${product.stockQuantity > 0}">
                        <span class="text-success fw-bold"><i class="fa-solid fa-check-circle me-1"></i>Còn hàng (${product.stockQuantity} sản phẩm)</span>
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger fw-bold"><i class="fa-solid fa-times-circle me-1"></i>Hết hàng</span>
                    </c:otherwise>
                </c:choose>
            </p>
            <hr>

            <c:if test="${product.stockQuantity > 0}">
                <form method="POST" action="cart" class="mt-4">
                    <input type="hidden" name="productId" value="${product.id}">
                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="form-label fw-bold">Chọn Kích Thước (Size):</label>
                            <select name="size" class="form-select" required>
                                <option value="">-- Chọn Size --</option>
                                <option value="S">Size S</option>
                                <option value="M">Size M</option>
                                <option value="L">Size L</option>
                                <option value="XL">Size XL</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label fw-bold">Chọn Màu Sắc:</label>
                            <select name="color" class="form-select" required>
                                <option value="">-- Chọn Màu --</option>
                                <option value="Đỏ">Màu Đỏ</option>
                                <option value="Xanh">Màu Xanh</option>
                                <option value="Đen">Màu Đen</option>
                                <option value="Trắng">Màu Trắng</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label fw-bold">Số Lượng Mua:</label>
                        <input type="number" name="quantity" value="1" min="1" max="${product.stockQuantity}" class="form-control" style="width: 120px;" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold py-3 text-uppercase rounded shadow-sm" style="background-color: #e53935; border:none;">
                        <i class="fa-solid fa-cart-plus me-2"></i> Thêm vào giỏ hàng
                    </button>
                </form>
            </c:if>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col-12 bg-white p-4 rounded shadow-sm">
            <h4 class="fw-bold text-dark border-bottom pb-2 mb-3"><i class="fa-solid fa-file-lines me-2 text-primary"></i>Mô tả sản phẩm</h4>
            <div class="text-dark mb-5" style="white-space: pre-wrap; line-height: 1.6;">${product.description}</div>

            <h4 class="fw-bold text-dark border-bottom pb-2 mb-4"><i class="fa-solid fa-comments me-2 text-primary"></i>Khách hàng đánh giá (${comments.size()})</h4>
            <c:if test="${not empty comment_message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">${comment_message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>




            <div class="comment-list">
                <c:choose>
                    <c:when test="${not empty comments}">
                        <c:forEach items="${comments}" var="c">
                            <div class="p-4 mb-3 rounded comment-box shadow-sm border">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="fw-bold text-dark"><i class="fa-solid fa-circle-user me-2 text-secondary fs-5"></i>${c.username}</span>
                                    <span class="small text-secondary"><i class="fa-regular fa-clock me-1"></i><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </div>
                                <p class="mb-0 text-dark ms-4" style="white-space: pre-wrap;">${c.commentText}</p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center text-muted py-4"><i class="fa-solid fa-comment-slash me-2"></i>Chưa có bình luận nào cho sản phẩm này.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <div class="row g-5">
            <div class="col-md-4">
                <div class="mb-3 d-flex align-items-center footer-logo"><i class="fa-solid fa-hurricane me-2"></i> SPORTS</div>
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
        <div class="border-top border-secondary mt-5 pt-4 text-center small text-secondary">&copy; 2026 SPORT SHOP. All rights reserved.</div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>