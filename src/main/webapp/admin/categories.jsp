<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Danh mục - Admin Sporter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
        .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
        .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
        .content { padding: 30px; background-color: #f8f9fa; min-height: 100vh;}
    </style>
</head>
<body>
<div class="container-fluid p-0">
    <div class="row g-0">
        <div class="col-md-2 sidebar shadow-lg">
            <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN SPORTER</h4>

            <a href="${pageContext.request.contextPath}/admin/index"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
            <a href="${pageContext.request.contextPath}/admin/categories" class="active"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
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
            <h2 class="fw-bold mb-4"><i class="fa-solid fa-list text-primary me-2"></i> Quản lý Danh mục Sản phẩm</h2>

            <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
            <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-header bg-white fw-bold">Thêm Danh mục Mới</div>
                        <div class="card-body">
                            <form action="categories" method="POST">
                                <input type="hidden" name="add_category" value="1">
                                <div class="mb-3">
                                    <label class="form-label">Tên danh mục:</label>
                                    <input type="text" name="name" class="form-control" required placeholder="Ví dụ: Áo bóng đá...">
                                </div>
                                <button type="submit" class="btn btn-primary w-100 fw-bold"><i class="fa-solid fa-plus me-1"></i> THÊM DANH MỤC</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-0">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-dark">
                                <tr>
                                    <th scope="col" class="ps-3" style="width: 10%;">ID</th>
                                    <th scope="col" style="width: 50%;">Tên Danh Mục</th>
                                    <th scope="col" class="text-center" style="width: 40%;">Thao Tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty listCategories}">
                                        <c:forEach items="${listCategories}" var="cat">
                                            <tr>
                                                <td class="ps-3">${cat.id}</td>
                                                <td>
                                                    <form action="categories" method="POST" class="d-flex m-0">
                                                        <input type="hidden" name="edit_category" value="1">
                                                        <input type="hidden" name="id" value="${cat.id}">
                                                        <input type="text" name="name" value="${cat.name}" class="form-control form-control-sm me-2" required>
                                                        <button type="submit" class="btn btn-sm btn-info text-white" title="Lưu thay đổi">
                                                            <i class="fa-solid fa-save"></i> Lưu
                                                        </button>
                                                    </form>
                                                </td>
                                                <td class="text-center">
                                                    <a href="categories?action=delete&id=${cat.id}"
                                                       onclick="return confirm('Bạn có chắc muốn xóa danh mục #${cat.id}?');"
                                                       class="btn btn-sm btn-danger" title="Xóa">
                                                        <i class="fa-solid fa-trash-alt"></i> Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr><td colspan="3" class="text-center py-4 text-muted">Chưa có danh mục nào.</td></tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>