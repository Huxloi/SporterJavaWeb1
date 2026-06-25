<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dao.ContactDAO" %>
<%
    ContactDAO daoCount = new ContactDAO();
    int newMessagesCount = daoCount.countUnrepliedMessages();
    request.setAttribute("newMessagesCount", newMessagesCount);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển - Admin Sporter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
        .content { padding: 30px; background-color: #f4f7f6; min-height: 100vh;}
        .card-stat { border: none; border-radius: 8px; color: white; padding: 25px; position: relative; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .card-stat .icon { position: absolute; right: 20px; top: 50%; transform: translateY(-50%); font-size: 40px; opacity: 0.25; }
        .card-chart { border: none; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); background-color: white; padding: 25px; }
        .dropdown-menu-messages { width: 320px; right: 0; left: auto; }
    </style>
</head>
<body>
<div class="container-fluid p-0">
    <div class="row g-0">
        <div class="col-md-2 sidebar shadow-lg">
            <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN SPORTER</h4>
            <a href="${pageContext.request.contextPath}/admin/index" class="active"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box-open me-2"></i> Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-cart-arrow-down me-2"></i> Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-2"></i> Khách hàng</a>
            <a href="${pageContext.request.contextPath}/admin/posts"><i class="fa-solid fa-newspaper me-2"></i> Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/comments"><i class="fa-solid fa-comments me-2"></i> Quản lý Bình luận</a>
            <a href="${pageContext.request.contextPath}/admin/reports"><i class="fa-solid fa-chart-line me-2"></i> Thống kê & Báo cáo</a>
            <hr class="text-secondary mx-3">
            <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="fa-solid fa-shop me-2"></i> Xem Cửa hàng</a>
            <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
        </div>

        <div class="col-md-10 content">
            <div class="d-flex justify-content-between align-items-center mb-4 bg-white px-4 py-3 shadow-sm rounded">
                <h2 class="fw-bold mb-0">Bảng Điều Khiển (Dashboard)</h2>

                <div class="d-flex align-items-center gap-3">
                    <div class="dropdown">
                        <button class="btn btn-light dropdown-toggle position-relative border" type="button" id="dropdownMessages" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-envelope me-1"></i> Tin nhắn
                            <c:if test="${newMessagesCount > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${newMessagesCount}</span>
                            </c:if>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-messages shadow-lg py-0" aria-labelledby="dropdownMessages">
                            <li class="dropdown-item-text bg-dark text-white py-2 fw-bold rounded-top m-0">Hộp thư mới nhận</li>
                            <%
                                ContactDAO dropDao = new ContactDAO();
                                request.setAttribute("dropMessages", dropDao.getTopUnrepliedMessages());
                            %>
                            <c:choose>
                                <c:when test="${empty dropMessages}">
                                    <li class="dropdown-item text-muted py-3 text-center small">Không có tin nhắn mới</li>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${dropMessages}" var="dm">
                                        <li class="p-0 m-0">
                                            <a class="dropdown-item border-bottom py-2 text-wrap" href="${pageContext.request.contextPath}/admin/reply-message?id=${dm.id}">
                                                <div class="fw-bold text-primary small text-truncate">Từ: ${dm.name}</div>
                                                <div class="text-dark fw-500 text-truncate" style="max-width: 260px;">Chủ đề: ${dm.subject}</div>
                                                <div class="text-muted small"><fmt:formatDate value="${dm.sentAt}" pattern="dd/MM HH:mm"/></div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                    <li class="p-0 m-0">
                                        <a class="dropdown-item text-center fw-bold text-primary py-2 rounded-bottom small" href="${pageContext.request.contextPath}/admin/messages">
                                            Xem tất cả tin nhắn
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>

                    <span class="text-muted border-start ps-3">Xin chào quản trị viên, <strong class="text-primary">${sessionScope.acc.username != null ? sessionScope.acc.username : 'huuloi'}</strong></span>
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="card-stat bg-primary">
                        <div class="small fw-bold text-uppercase opacity-75">Doanh thu hôm nay</div>
                        <div class="fs-3 fw-bold mt-2"><fmt:formatNumber value="${todayRevenue}" type="number"/>đ</div>
                        <div class="icon"><i class="fa-solid fa-money-bill-wave"></i></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-stat bg-warning text-dark">
                        <div class="small fw-bold text-uppercase opacity-75">Đơn hàng chờ duyệt</div>
                        <div class="fs-3 fw-bold mt-2">${pendingOrders}</div>
                        <div class="icon"><i class="fa-solid fa-truck-ramp-box"></i></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-stat bg-success">
                        <div class="small fw-bold text-uppercase opacity-75">Sản phẩm trong kho</div>
                        <div class="fs-3 fw-bold mt-2">${totalProducts}</div>
                        <div class="icon"><i class="fa-solid fa-box"></i></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card-stat bg-danger">
                        <div class="small fw-bold text-uppercase opacity-75">Tổng số khách hàng</div>
                        <div class="fs-3 fw-bold mt-2">${totalUsers}</div>
                        <div class="icon"><i class="fa-solid fa-users"></i></div>
                    </div>
                </div>
            </div>

            <div class="card-chart mb-4">
                <h5 class="fw-bold mb-4 text-dark"><i class="fa-solid fa-arrow-trend-up text-primary me-2"></i> Xu hướng Doanh thu 7 ngày gần nhất</h5>
                <div style="height: 320px; width: 100%;">
                    <canvas id="dashboardLineChart"></canvas>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    const labelsTrend = [<c:forEach items="${trend7Days}" var="day">'${day.key}',</c:forEach>];
    const dataTrend = [<c:forEach items="${trend7Days}" var="day">${day.value},</c:forEach>];

    new Chart(document.getElementById('dashboardLineChart').getContext('2d'), {
        type: 'line',
        data: {
            labels: labelsTrend,
            datasets: [{
                label: 'Doanh thu ngày (VNĐ)',
                data: dataTrend,
                borderColor: '#0d6efd',
                backgroundColor: 'rgba(13, 110, 253, 0.08)',
                borderWidth: 3,
                fill: true,
                tension: 0.25,
                pointBackgroundColor: '#0d6efd',
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { callback: function(value) { return value.toLocaleString() + 'đ'; } }
                }
            },
            plugins: {
                legend: { display: false }
            }
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>