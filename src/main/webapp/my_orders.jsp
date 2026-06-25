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
        .nav-link { font-weight: 500; color: #555 !important; font-size: 0.95rem; }
        .nav-link:hover { color: #0d6efd !important; }
        footer { background-color: #2b3035; color: #adb5bd; padding: 25px 0; margin-top: 80px; text-align: center; }

        /* Layout hộp đơn hàng song song */
        .page-title { color: #0d6efd; font-weight: 700; font-size: 2.2rem; display: flex; align-items: center; gap: 10px; }
        .order-card-box { background-color: #fff; border-radius: 6px; border: 1px solid #e2e8f0; border-top: 4px solid #0d6efd; padding: 24px; transition: 0.25s; height: 100%; box-shadow: 0 4px 10px rgba(0,0,0,0.02); }
        .order-card-box:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.06); transform: translateY(-2px); }
        .order-title { font-size: 1.3rem; font-weight: 700; color: #212529; }
        .status-badge-yellow { background-color: #ffc107; color: #000; padding: 6px 14px; border-radius: 50px; font-weight: 600; font-size: 0.85rem; }
        .btn-outline-sports { border: 1px solid #0d6efd; color: #0d6efd; font-weight: 600; width: 100%; border-radius: 4px; padding: 8px 0; background-color: #fff; text-align: center; display: block; text-decoration: none; transition: 0.2s;}
        .btn-outline-sports:hover { background-color: #0d6efd; color: white !important; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center me-4" href="${pageContext.request.contextPath}/index">
            <i class="fa-solid fa-hurricane logo-icon"></i><span class="logo-text">SPORTS</span>
        </a>
    </div>
</nav>

<div class="container my-5" style="min-height: 500px;">
    <div class="mb-5">
        <h2 class="page-title text-uppercase"><i class="fa-solid fa-clock-rotate-left me-2"></i> Lịch sử mua hàng</h2>
        <a href="${pageContext.request.contextPath}/index" class="btn btn-sm btn-outline-secondary mt-2" style="border-radius: 4px;"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại Trang chủ</a>
    </div>

    <c:if test="${param.message == 'cancel_success'}"><div class="alert alert-success text-center fw-bold">✅ Đã thực hiện hủy đơn hàng thành công!</div></c:if>
    <c:if test="${param.message == 'cancel_fail'}"><div class="alert alert-danger text-center fw-bold">❌ Không thể hủy đơn do đơn hàng đang được xử lý!</div></c:if>

    <div class="row g-4">
        <c:choose>
            <c:when test="${not empty listO}">
                <c:forEach items="${listO}" var="o">
                    <div class="col-md-6">
                        <div class="order-card-box d-flex flex-column justify-content-between">
                            <div>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="order-title">Đơn hàng #${o.id}</span>
                                    <span class="status-badge-yellow">${o.status}</span>
                                </div>
                                <p class="mb-2 text-secondary small"><i class="fa-regular fa-calendar-alt me-1"></i> Ngày đặt: <strong><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></strong></p>
                                <p class="mb-4 text-secondary small"><i class="fa-solid fa-money-bill-wave me-1"></i> Tổng tiền: <span class="text-danger fw-bold fs-5"><fmt:formatNumber value="${o.totalAmount}" type="number"/> VNĐ</span></p>
                            </div>
                            <a href="my_orders?action=view&id=${o.id}" class="btn-outline-sports">
                                <i class="fa-solid fa-eye me-1"></i> Xem chi tiết
                            </a>
                        </div>
                    </div>
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
    <div class="container text-center small text-secondary">&copy; 2026 SPORT SHOP. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>