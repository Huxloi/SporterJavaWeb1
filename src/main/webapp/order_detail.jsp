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

        .main-title { color: #0d6efd; font-weight: 800; font-size: 2.2rem; display: flex; align-items: center; gap: 12px; }
        .info-card { background-color: #fff; border-radius: 6px; padding: 22px; border: 1px solid #e2e8f0; height: 100%; }
        .info-card-title { font-weight: 700; color: #212529; margin-bottom: 18px; font-size: 1.1rem; }
        .status-pill { background-color: #ffc107; color: #000; padding: 5px 15px; border-radius: 50px; font-weight: 600; font-size: 0.9rem; }
        .product-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 6px; }
        .btn-danger-cancel { background-color: #dc3545; color: white; font-weight: 700; border: none; width: 100%; padding: 12px; border-radius: 6px; font-size: 1.1rem; text-decoration: none; transition: 0.2s; }
        .btn-danger-cancel:hover { background-color: #bd2130; color: white; }
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

<div class="container my-5" style="max-width: 960px; min-height: 480px;">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <h2 class="main-title text-uppercase"><i class="fa-solid fa-receipt"></i> CHI TIẾT ĐƠN HÀNG #${order.id}</h2>

        <a href="my_orders" class="btn btn-sm btn-outline-secondary"><i class="fa-solid fa-reply me-1"></i> Quay lại Lịch sử</a>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="info-card shadow-sm">
                <div class="info-card-title"><i class="fa-solid fa-circle-info me-2 text-secondary"></i> Thông tin Đơn hàng</div>
                <p class="mb-2"><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                <p class="mb-2"><strong>Tổng tiền:</strong> <span class="text-danger fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="number"/> VNĐ</span></p>
                <p class="mb-0"><strong>Trạng thái:</strong> <span class="status-pill">${order.status}</span></p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="info-card shadow-sm">
                <div class="info-card-title"><i class="fa-solid fa-truck me-2 text-secondary"></i> Thông tin Giao hàng</div>
                <p class="mb-2"><strong>Người nhận:</strong> ${sessionScope.acc.username}</p>
                <p class="mb-2"><strong>Số điện thoại:</strong> ${order.phone}</p>
                <p class="mb-0"><strong>Địa chỉ:</strong> ${order.address}</p>
            </div>
        </div>
    </div>

    <c:if test="${order.status == 'Chờ xác nhận'}">
        <div class="mb-4">
            <a href="my_orders?action=cancel&id=${order.id}" class="btn-danger-cancel btn d-flex align-items-center justify-content-center gap-2"
               onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${order.id} này không?');">
                <i class="fa-solid fa-circle-xmark"></i> HỦY ĐƠN HÀNG
            </a>
        </div>
    </c:if>

    <div class="card shadow-sm border rounded-3 overflow-hidden">
        <div class="card-header bg-white fw-bold py-3"><i class="fa-solid fa-cubes text-secondary me-2"></i> Các sản phẩm trong Đơn hàng</div>
        <div class="card-body p-0">
            <table class="table align-middle m-0">
                <thead class="table-light text-secondary">
                <tr>
                    <th class="ps-3">Ảnh</th>
                    <th>Sản Phẩm</th>
                    <th>Size</th>
                    <th>Màu</th>
                    <th>Số Lượng</th>
                    <th class="text-end pe-3">Giá</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${order.items}" var="item">
                    <tr class="border-bottom">
                        <td class="ps-3 py-3"><img src="${item.productImg}" class="product-thumb border"></td>
                        <td class="fw-bold text-dark">${item.productName}</td>
                        <td><span class="fw-bold text-dark">${item.selectedSize}</span></td>
                        <td><span class="text-secondary">${item.selectedColor}</span></td>
                        <td class="fw-bold text-dark ps-4">${item.quantity}</td>
                        <td class="text-danger fw-bold text-end pe-3"><fmt:formatNumber value="${item.priceAtPurchase}" type="number"/> VNĐ</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>