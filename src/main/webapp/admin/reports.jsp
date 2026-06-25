<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê & Báo cáo - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
        .content { padding: 30px; background-color: #f4f7f6; min-height: 100vh;}
        .card { border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<div class="container-fluid p-0">
    <div class="row g-0">

        <div class="col-md-2 sidebar shadow-lg">
            <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN SPORTER</h4>
            <a href="${pageContext.request.contextPath}/admin/index"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/products"><i class="fa-solid fa-box-open me-2"></i> Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/orders"><i class="fa-solid fa-cart-arrow-down me-2"></i> Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/users"><i class="fa-solid fa-users me-2"></i> Khách hàng</a>
            <a href="${pageContext.request.contextPath}/admin/posts"><i class="fa-solid fa-newspaper me-2"></i> Bài viết</a>
            <a href="${pageContext.request.contextPath}/admin/comments"><i class="fa-solid fa-comments me-2"></i> Quản lý Bình luận</a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="active"><i class="fa-solid fa-chart-line me-2"></i> Thống kê & Báo cáo</a>
            <hr class="text-secondary mx-3">
            <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="fa-solid fa-shop me-2"></i> Xem Cửa hàng</a>
            <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
        </div>

        <div class="col-md-10 content">

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="card h-100 border-0 p-3">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fa-solid fa-chart-pie fs-4 me-2"></i>
                            <h5 class="fw-bold mb-0">Tỷ trọng Doanh thu</h5>
                        </div>
                        <p class="text-muted mb-4">Tổng: <strong class="text-success fs-4"><fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/> VNĐ</strong></p>

                        <div class="d-flex justify-content-center" style="height: 250px;">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card h-100 border-0">
                        <div class="card-header bg-primary text-white fw-bold py-3 border-0">
                            <i class="fa-solid fa-medal text-warning me-2"></i> TOP 10 SẢN PHẨM BÁN CHẠY
                        </div>
                        <div class="card-body p-0" style="max-height: 330px; overflow-y: auto;">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th class="ps-3">Tên Sản phẩm</th>
                                    <th>Số lượng đã bán</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${top10Products}" var="p">
                                    <tr>
                                        <td class="ps-3">${p.name}</td>
                                        <td class="text-success fw-bold">${p.total_sold}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0">
                <div class="card-header bg-success text-white fw-bold py-3 border-0">
                    BẢNG CHI TIẾT DOANH THU
                </div>
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead>
                        <tr>
                            <th class="ps-3">Danh Mục</th>
                            <th>Doanh thu</th>
                            <th>Tỷ trọng (%)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${categoryRevenue}" var="item">
                            <tr>
                                <td class="ps-3 fw-bold">${item.name}</td>
                                <td class="fw-bold"><fmt:formatNumber value="${item.total}" type="number" maxFractionDigits="0"/> VNĐ</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${(item.total / totalRevenue) * 100}" type="number" maxFractionDigits="2"/>%
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    const labels = [<c:forEach items="${categoryRevenue}" var="item">'${item.name}',</c:forEach>];
    const data = [<c:forEach items="${categoryRevenue}" var="item">${item.total},</c:forEach>];

    new Chart(document.getElementById('revenueChart').getContext('2d'), {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: ['#28a745', '#007bff', '#ffc107', '#dc3545', '#17a2b8', '#6c757d'],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top' } }
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>