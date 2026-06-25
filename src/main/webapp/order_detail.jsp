<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng #${order.id} - SPORTS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }
        .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
        .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
        .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }

        .main-title { color: #0d47a1; font-weight: 700; }
        .product-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; }
        .order-info-card { background: #fff; border-radius: 8px; border: 1px solid #eef0f2; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075)!important; }
    </style>
</head>
<body>

<%
    // Lấy thông tin user đăng nhập từ session để kiểm tra đánh giá
    model.User acc = (model.User) session.getAttribute("acc");
    if (acc == null) { acc = (model.User) session.getAttribute("user"); }
    request.setAttribute("loggedUser", acc);

    // Khởi tạo DAO kiểm tra đánh giá
    dao.CommentDAO cDao = new dao.CommentDAO();
    request.setAttribute("cDao", cDao);
%>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav gap-3">
                <li class="nav-item"><a class="nav-link" href="index"><i class="fa-solid fa-house me-1"></i> Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="cart"><i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng</a></li>
                <li class="nav-item"><a class="nav-link active text-primary" href="my_orders"><i class="fa-solid fa-box-archive me-1"></i> Đơn hàng của tôi</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 950px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="main-title mb-0 text-uppercase">Chi tiết đơn hàng #${order.id}</h3>
        <a href="my_orders" class="btn btn-outline-secondary fw-bold"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại lịch sử</a>
    </div>

    <div class="order-info-card p-4 mb-4">
        <div class="row g-3">
            <div class="col-md-4">
                <span class="text-muted small d-block">Trạng thái đơn hàng</span>
                <c:choose>
                    <c:when test="${order.status == 'Đã giao' || order.status == 'Đã hoàn thành'}">
                        <span class="badge bg-success px-3 py-2 fs-6 mt-1">${order.status}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-warning text-dark px-3 py-2 fs-6 mt-1">${order.status}</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-md-4">
                <span class="text-muted small d-block">Ngày đặt hàng</span>
                <strong class="fs-6 text-dark d-block mt-1"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></strong>
            </div>
            <div class="col-md-4">
                <span class="text-muted small d-block">Tổng tiền thanh toán</span>
                <strong class="text-danger fs-4 d-block mt-1"><fmt:formatNumber value="${order.totalAmount}" type="number"/> VNĐ</strong>
            </div>
        </div>
    </div>

    <div class="order-info-card card border-0 mb-4">
        <div class="card-header bg-white fw-bold py-3 border-bottom"><i class="fa-solid fa-cubes text-secondary me-2"></i> Các sản phẩm trong đơn hàng</div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table align-middle m-0">
                    <thead class="table-light text-secondary">
                    <tr>
                        <th class="ps-3">Ảnh</th>
                        <th>Sản Phẩm</th>
                        <th>Size</th>
                        <th>Màu</th>
                        <th>Số Lượng</th>
                        <th>Giá</th>
                        <c:if test="${order.status.trim() == 'Đã giao' || order.status.trim() == 'Đã hoàn thành'}">
                            <th class="text-center pe-3">Thao tác</th>
                        </c:if>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${order.items}" var="item" varStatus="loop">
                        <%-- Kiểm tra xem sản phẩm, size, màu trong đơn hàng này đã được đánh giá chưa --%>
                        <c:set var="isReviewed" value="${cDao.hasUserReviewedProduct(loggedUser.id, item.productId, order.id, item.selectedSize, item.selectedColor)}" />

                        <tr class="border-bottom">
                            <td class="ps-3 py-3"><img src="${item.productImg}" class="product-thumb border" alt=""></td>
                            <td class="fw-bold text-dark">${item.productName}</td>
                            <td><span class="fw-bold text-dark">${item.selectedSize}</span></td>
                            <td><span class="text-secondary">${item.selectedColor}</span></td>
                            <td class="fw-bold text-dark ps-2">${item.quantity}</td>
                            <td class="text-danger fw-bold"><fmt:formatNumber value="${item.priceAtPurchase}" type="number"/> VNĐ</td>

                            <c:if test="${order.status.trim() == 'Đã giao' || order.status.trim() == 'Đã hoàn thành'}">
                                <td class="text-center pe-3">
                                    <c:choose>
                                        <c:when test="${isReviewed}">
                                            <%-- Đã đánh giá -> Nút mờ xám, chặn bấm --%>
                                            <button type="button" class="btn btn-sm btn-secondary disabled py-2 px-3" style="opacity: 0.65; cursor: not-allowed; font-size: 0.85rem;">
                                                <i class="fa-solid fa-check me-1"></i> Đã đánh giá
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- Chưa đánh giá -> Nút bình thường, mở popup --%>
                                            <button type="button" class="btn btn-sm btn-warning text-dark fw-bold py-2 px-3" data-bs-toggle="modal" data-bs-target="#reviewItemModal${loop.index}" style="font-size: 0.85rem;">
                                                <i class="fa-solid fa-star me-1"></i> Đánh giá
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<c:if test="${order.status.trim() == 'Đã giao' || order.status.trim() == 'Đã hoàn thành'}">
    <c:forEach items="${order.items}" var="item" varStatus="loop">
        <c:set var="isReviewedModal" value="${cDao.hasUserReviewedProduct(loggedUser.id, item.productId, order.id, item.selectedSize, item.selectedColor)}" />
        <c:if test="${not isReviewedModal}">
            <div class="modal fade" id="reviewItemModal${loop.index}" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header border-0 pb-0">
                            <h5 class="modal-title fw-bold text-danger"><i class="fa-solid fa-star me-2"></i> ĐÁNH GIÁ SẢN PHẨM</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <form action="review" method="POST">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <input type="hidden" name="products[0].productId" value="${item.productId}">
                            <input type="hidden" name="products[0].size" value="${item.selectedSize}">
                            <input type="hidden" name="products[0].color" value="${item.selectedColor}">

                             <div class="modal-body">
                                <div class="d-flex align-items-center gap-3 border-bottom pb-3 mb-3">
                                    <img src="${item.productImg}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;" class="border" alt="">
                                    <div>
                                        <span class="fw-bold text-dark d-block">${item.productName}</span>
                                        <small class="text-muted">Size: <b>${item.selectedSize}</b> | Màu: <b>${item.selectedColor}</b></small>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">Chất lượng sản phẩm:</label>
                                    <select name="products[0].rating" class="form-select" required>
                                        <option value="5" selected>⭐⭐⭐⭐⭐</option>
                                        <option value="4">⭐⭐⭐⭐</option>
                                        <option value="3">⭐⭐⭐</option>
                                        <option value="2">⭐⭐</option>
                                        <option value="1">⭐ </option>
                                    </select>
                                </div>

                                <div class="mb-0">
                                    <label class="form-label fw-bold text-secondary">Nhận xét của bạn:</label>
                                    <textarea name="products[0].comment" class="form-control" rows="3" placeholder="Hãy chia sẻ cảm nhận của bạn về sản phẩm này nhé..." required></textarea>
                                </div>
                            </div>

                            <div class="modal-footer border-0 pt-0">
                                <button type="button" class="btn btn-outline-secondary fw-bold" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-danger fw-bold text-uppercase"><i class="fa-solid fa-paper-plane me-1"></i> Gửi đánh giá</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
</c:if>

<footer>
    <div class="container text-center small text-secondary py-4">&copy; 2026 SPORT SHOP. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>