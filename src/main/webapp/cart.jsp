<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn - SPORTS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }
        .navbar { border-bottom: 1px solid #eaeaea; padding: 15px 0; background-color: #fff;}
        .logo-icon { color: #00d2ff; font-size: 1.8rem; margin-right: 5px; }
        .logo-text { color: #0d47a1; font-weight: 900; font-size: 1.8rem; letter-spacing: -1px; }
        .nav-link { font-weight: 500; color: #555 !important; font-size: 0.95rem; }
        .nav-link:hover { color: #0d6efd !important; }
        .util-link { color: #555; text-decoration: none; font-weight: 500; font-size: 0.95rem; }
        footer { background-color: #2b3035; color: #adb5bd; padding: 60px 0 30px; margin-top: 80px; }
        .page-title { color: #212529; font-weight: 700; font-size: 1.75rem; }
        .cart-container { background-color: #fff; border-radius: 8px; padding: 20px; border: 1px solid #eef0f2; }
        .product-img { width: 65px; height: 65px; object-fit: cover; border-radius: 6px; }
        .summary-box { background-color: #fff; border-radius: 8px; padding: 25px; border: 1px solid #eef0f2; }
        .btn-next-step { background-color: #dc3545; color: white; font-weight: 600; width: 100%; padding: 12px; border: none; border-radius: 6px; text-transform: uppercase; text-decoration: none; display: block; text-align: center; transition: 0.2s;}
        .btn-next-step:hover { background-color: #bd2130; color: white; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center me-4" href="index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-2">
                <li class="nav-item"><a class="nav-link" href="index">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="news">Bài viết</a></li>
                <li class="nav-item"><a class="nav-link" href="contact">Liên hệ & Phản hồi</a></li>
            </ul>
            <div class="d-flex align-items-center gap-3">
                <a href="cart" class="util-link fw-bold text-primary text-decoration-none">
                    <i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng
                    <span class="badge bg-danger rounded-pill">${sessionScope.cart != null ? sessionScope.cart.items.size() : 0}</span>
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5" style="min-height: 450px;">
    <h3 class="page-title mb-4"><i class="fa-solid fa-cart-shopping text-primary me-2"></i>Giỏ hàng của bạn</h3>

    <c:choose>
        <c:when test="${sessionScope.cart != null && sessionScope.cart.items.size() > 0}">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="cart-container shadow-sm">
                        <table class="table align-middle mb-0">
                            <thead class="table-light text-secondary">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th class="text-center">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${sessionScope.cart.items}" var="item">
                                <tr class="border-bottom cart-item-row" data-id="${item.product.id}" data-old-size="${item.size}" data-old-color="${item.color}" data-price="${item.price}">
                                    <td class="py-3">
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="${item.product.imageUrl}" class="product-img border">
                                            <div>
                                                <span class="fw-bold text-dark d-block mb-1" style="font-size: 0.95rem;">${item.product.name}</span>

                                                <div class="row g-2 align-items-center mt-1 select-variant-row">
                                                    <div class="col-auto p-0 pe-1"><small class="text-muted fw-bold">Size:</small></div>
                                                    <div class="col-auto p-0 me-2">
                                                        <select class="form-select form-select-sm select-size" style="width: 70px;">
                                                            <option value="S" ${item.size == 'S' ? 'selected' : ''}>S</option>
                                                            <option value="M" ${item.size == 'M' ? 'selected' : ''}>M</option>
                                                            <option value="L" ${item.size == 'L' ? 'selected' : ''}>L</option>
                                                            <option value="XL" ${item.size == 'XL' ? 'selected' : ''}>XL</option>
                                                            <option value="XXL" ${item.size == 'XXL' ? 'selected' : ''}>XXL</option>
                                                        </select>
                                                    </div>

                                                    <div class="col-auto p-0 pe-1"><small class="text-muted fw-bold">Màu:</small></div>
                                                    <div class="col-auto p-0">
                                                        <select class="form-select form-select-sm select-color" style="width: 100px;">
                                                            <option value="Đỏ" ${item.color == 'Đỏ' ? 'selected' : ''}>Đỏ</option>
                                                            <option value="Xanh" ${item.color == 'Xanh' ? 'selected' : ''}>Xanh</option>
                                                            <option value="Đen" ${item.color == 'Đen' ? 'selected' : ''}>Đen</option>
                                                            <option value="Trắng" ${item.color == 'Trắng' ? 'selected' : ''}>Trắng</option>
                                                            <option value="Vàng" ${item.color == 'Vàng' ? 'selected' : ''}>Vàng</option>
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </td>
                                    <td class="fw-semibold"><fmt:formatNumber value="${item.price}" type="number"/>đ</td>
                                    <td>
                                        <div class="d-flex m-0 align-items-center">
                                            <input type="number" value="${item.quantity}" min="1" class="form-control form-control-sm text-center quantity-input" style="width: 60px;">
                                        </div>
                                    </td>
                                    <td class="fw-bold text-danger total-price-item">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="number"/>đ
                                    </td>
                                    <td class="text-center">
                                        <a href="cart?action=delete&id=${item.product.id}&size=${item.size}&color=${item.color}" class="text-danger fs-5" onclick="return confirm('Xóa sản phẩm này?')">
                                            <i class="fa-regular fa-trash-can"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-3">
                        <a href="index" class="btn btn-sm btn-outline-secondary px-3 py-2"><i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục mua sắm</a>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="summary-box shadow-sm">
                        <h5 class="fw-bold text-dark border-bottom pb-3 mb-3">Tóm tắt đơn hàng</h5>
                        <div class="d-flex justify-content-between mb-2 text-secondary">
                            <span>Tạm tính:</span>
                            <span class="text-dark fw-bold" id="grand-total"><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number"/>đ</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3 text-secondary border-bottom pb-3">
                            <span>Phí giao hàng:</span>
                            <span class="text-success fw-bold">Miễn phí</span>
                        </div>
                        <div class="d-flex justify-content-between mb-4 text-dark">
                            <span class="fw-bold fs-5">Tổng thanh toán:</span>
                            <span class="fw-bold fs-4 text-danger" id="grand-total-final"><fmt:formatNumber value="${sessionScope.cart.totalMoney}" type="number"/> VNĐ</span>
                        </div>
                        <a href="cart?action=checkout" class="btn-next-step">Tiến hành thanh toán <i class="fa-solid fa-arrow-right ms-1"></i></a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card shadow-sm border-0 py-5 text-center bg-white"><div class="card-body"><i class="fa-solid fa-shopping-bag fa-3x text-light mb-3"></i><h5>Giỏ hàng trống!</h5><a href="index" class="btn btn-primary btn-sm mt-2">MUA SẮM NGAY</a></div></div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        function formatCurrency(number) {
            return new Intl.NumberFormat('vi-VN').format(number) + 'đ';
        }

        function formatCurrencyVND(number) {
            return new Intl.NumberFormat('vi-VN').format(number) + ' VNĐ';
        }

        // Cập nhật tính toán tổng tiền giỏ hàng
        function recalculateCart() {
            let grandTotal = 0;
            document.querySelectorAll('.cart-item-row').forEach(cartRow => {
                const rowPrice = parseFloat(cartRow.getAttribute('data-price'));
                const rowQuantity = parseInt(cartRow.querySelector('.quantity-input').value) || 1;
                grandTotal += rowPrice * rowQuantity;
            });

            document.getElementById('grand-total').innerHTML = formatCurrency(grandTotal);
            document.getElementById('grand-total-final').innerHTML = formatCurrencyVND(grandTotal);
        }

        // Lắng nghe sự kiện thay đổi trên các ô nhập số lượng
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function () {
                const row = this.closest('.cart-item-row');
                const price = parseFloat(row.getAttribute('data-price'));
                const newQuantity = parseInt(this.value) || 1;

                if (newQuantity < 1) {
                    this.value = 1;
                    return;
                }

                // Cập nhật thành tiền
                const itemTotal = price * newQuantity;
                row.querySelector('.total-price-item').innerHTML = formatCurrency(itemTotal);

                recalculateCart();
                syncServer(row);
            });
        });

        // Lắng nghe sự kiện thay đổi trên các ô chọn Size & Màu
        document.querySelectorAll('.select-variant-row select').forEach(select => {
            select.addEventListener('change', function () {
                const row = this.closest('.cart-item-row');
                recalculateCart();
                syncServer(row);
            });
        });

        // Đồng bộ ngầm trạng thái xuống Servlet/Session dưới Server thông qua Fetch API
        function syncServer(row) {
            const id = row.getAttribute('data-id');
            const oldSize = row.getAttribute('data-old-size');
            const oldColor = row.getAttribute('data-old-color');

            const newSize = row.querySelector('.select-size').value;
            const newColor = row.querySelector('.select-color').value;
            const quantity = row.querySelector('.quantity-input').value;

            // Gọi ngầm đường dẫn update
            const url = 'cart?action=update&id=' + id +
                        '&oldSize=' + encodeURIComponent(oldSize) +
                        '&oldColor=' + encodeURIComponent(oldColor) +
                        '&newSize=' + encodeURIComponent(newSize) +
                        '&newColor=' + encodeURIComponent(newColor) +
                        '&quantity=' + quantity;

            fetch(url, { method: 'GET' })
            .then(response => {
                if (response.ok) {
                    // Cập nhật lại data attribute để lần thay đổi tiếp theo nhận đúng định dạng cũ
                    row.setAttribute('data-old-size', newSize);
                    row.setAttribute('data-old-color', newColor);
                } else {
                    console.error('Cập nhật giỏ hàng thất bại!');
                }
            })
            .catch(error => console.error('Lỗi kết nối:', error));
        }
    });
</script>
</body>
</html>