<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>LỊCH SỬ MUA HÀNG - SPORTS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }

        /* Đồng bộ Header SPORTS */
        .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
        .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
        .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }
        .nav-link { font-weight: 500; color: #333; }
        .nav-link:hover { color: #0d6efd; }

        .main-title { color: #212529; font-weight: 700; font-size: 2rem; margin-bottom: 30px; }
        .order-card-box { background: #fff; border-radius: 8px; border: 1px solid #eef0f2; padding: 20px; margin-bottom: 20px; box-shadow: 0 .125rem .25rem rgba(0,0,0,.075)!important; }
        .order-title { font-size: 1.15rem; font-weight: 700; color: #0d47a1; }
        .status-badge-yellow { background-color: #fff3cd; color: #856404; padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; border: 1px solid #ffeeba; }
        .btn-outline-sports { border: 1px solid #0d6efd; color: #0d6efd; background: #fff; border-radius: 4px; padding: 6px 16px; font-weight: 600; text-decoration: none; display: inline-block; font-size: 0.9rem; text-align: center; }
        .btn-outline-sports:hover { background: #0d6efd; color: #fff; }

        .product-thumb { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #dee2e6; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav gap-3">
                <li class="nav-item"><a class="nav-link" href="index"><i class="fa-solid fa-house me-1"></i> Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="cart"><i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng</a></li>
                <li class="nav-item"><a class="nav-link active text-primary" href="my_orders"><i class="fa-solid fa-box-archive me-1"></i> Đơn hàng của tôi</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 900px;">
    <h2 class="main-title text-uppercase text-center">LỊCH SỬ MUA HÀNG</h2>

    <c:if test="${param.message == 'cancel_success'}">
        <div class="alert alert-success alert-dismissible fade show fw-bold text-center mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Hủy đơn hàng thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.message == 'cancel_fail'}">
        <div class="alert alert-danger alert-dismissible fade show fw-bold text-center mb-4" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i> Không thể hủy đơn hàng này!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.message == 'review_success'}">
        <div class="alert alert-success alert-dismissible fade show fw-bold text-center mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Gửi đánh giá sản phẩm thành công! Cảm ơn bạn đã phản hồi.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.message == 'review_fail'}">
        <div class="alert alert-danger alert-dismissible fade show fw-bold text-center mb-4" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i> Có lỗi xảy ra trong quá trình lưu đánh giá!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <c:choose>
            <c:when test="${not empty requestScope.listO}">
                <c:forEach items="${requestScope.listO}" var="o">
                    <div class="col-12">
                        <div class="order-card-box d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-3 gap-3">
                                    <span class="order-title">Đơn hàng #${o.id}</span>
                                    <c:choose>
                                        <c:when test="${o.status == 'Đã giao' || o.status == 'Đã hoàn thành'}">
                                            <span class="badge bg-success px-3 py-2" style="font-size: 0.85rem;">${o.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge-yellow">${o.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <p class="mb-2 text-secondary small"><i class="fa-regular fa-calendar-alt me-1"></i> Ngày đặt: <strong><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></strong></p>
                                <p class="mb-0 text-secondary small"><i class="fa-solid fa-money-bill-wave me-1"></i> Tổng tiền: <span class="text-danger fw-bold fs-5"><fmt:formatNumber value="${o.totalAmount}" type="number"/> VNĐ</span></p>
                            </div>

                            <div class="d-flex flex-row flex-md-column gap-2 justify-content-start justify-content-md-end mt-2 mt-md-0">
                                <a href="my_orders?action=view&id=${o.id}" class="btn-outline-sports flex-grow-1 flex-md-grow-0">
                                    <i class="fa-solid fa-eye me-1"></i> Xem chi tiết
                                </a>


                            </div>
                        </div>
                    </div>

                    <c:if test="${o.status.trim() == 'Đã giao' || o.status.trim() == 'Đã hoàn thành'}">
                        <div class="modal fade" id="reviewModal${o.id}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header border-0 pb-0">
                                        <h5 class="modal-title fw-bold text-uppercase text-danger"><i class="fa-solid fa-star me-2"></i> Đánh giá sản phẩm - Đơn hàng #${o.id}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>

                                    <form action="review" method="POST">
                                        <input type="hidden" name="orderId" value="${o.id}">

                                        <div class="modal-body" style="max-height: 60vh; overflow-y: auto;">
                                            <c:choose>
                                                <c:when test="${empty o.items}">
                                                    <div class="alert alert-warning text-center py-3 m-0">Không tìm thấy sản phẩm nào trong đơn hàng này để đánh giá.</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${o.items}" var="item" varStatus="loop">
                                                        <input type="hidden" name="products[${loop.index}].productId" value="${item.productId}">
                                                        <input type="hidden" name="products[${loop.index}].size" value="${item.selectedSize}">
                                                        <input type="hidden" name="products[${loop.index}].color" value="${item.selectedColor}">

                                                        <div class="p-3 border rounded mb-3 bg-light bg-opacity-50">
                                                            <div class="d-flex align-items-center gap-3 border-bottom pb-2 mb-2">
                                                                <img src="${item.productImg}" class="product-thumb" alt="">
                                                                <div>
                                                                    <span class="fw-bold text-dark d-block" style="font-size: 0.95rem;">${item.productName}</span>
                                                                    <small class="text-muted">Size: <b>${item.selectedSize}</b> | Màu: <b>${item.selectedColor}</b></small>
                                                                </div>
                                                            </div>

                                                            <div class="mb-2">
                                                                <label class="form-label small fw-bold text-secondary">Chất lượng sản phẩm:</label>
                                                                <select name="products[${loop.index}].rating" class="form-select form-select-sm" style="max-width: 180px;" required>
                                                                    <option value="5" selected>⭐⭐⭐⭐⭐ (Tuyệt vời)</option>
                                                                    <option value="4">⭐⭐⭐⭐ (Rất tốt)</option>
                                                                    <option value="3">⭐⭐⭐ (Bình thường)</option>
                                                                    <option value="2">⭐⭐ (Kém)</option>
                                                                    <option value="1">⭐ (Rất tệ)</option>
                                                                </select>
                                                            </div>

                                                            <div class="mb-0">
                                                                <label class="form-label small fw-bold text-secondary">Nhận xét của bạn:</label>
                                                                <textarea name="products[${loop.index}].comment" class="form-control form-control-sm" rows="2" placeholder="Hãy chia sẻ cảm nhận của bạn về sản phẩm này nhé..."></textarea>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
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
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5 bg-white border rounded shadow-sm">
                    <p class="text-muted fs-5 m-0">Bạn chưa thực hiện đơn hàng nào trên hệ thống.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer>
    <div class="container text-center small text-secondary py-4">&copy; 2026 SPORT SHOP. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>