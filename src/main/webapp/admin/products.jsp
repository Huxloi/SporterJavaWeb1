<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Sản phẩm - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
    .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
    .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
    .content { padding: 30px; background-color: #f8f9fa; min-height: 100vh;}
    .img-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 5px; }
  </style>
</head>
<body>

<div class="container-fluid p-0">
  <div class="row g-0">
    <div class="col-md-2 sidebar shadow-lg">
      <h4 class="text-center text-white mb-4 fw-bold"><i class="fa-solid fa-gauge me-2"></i>ADMIN SPORTER</h4>
      <a href="${pageContext.request.contextPath}/admin/index"><i class="fa-solid fa-chart-pie me-2"></i> Tổng quan</a>
      <a href="${pageContext.request.contextPath}/admin/categories"><i class="fa-solid fa-list me-2"></i> Danh mục</a>
      <a href="${pageContext.request.contextPath}/admin/products" class="active"><i class="fa-solid fa-box-open me-2"></i> Sản phẩm</a>
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
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><i class="fa-solid fa-box-open text-primary me-2"></i> Quản lý Sản phẩm</h2>
        <button class="btn btn-primary fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#productModal" onclick="openAddModal()">
          <i class="fa-solid fa-plus me-1"></i> Thêm Sản Phẩm Mới
        </button>
      </div>

      <c:if test="${param.message == 'success'}"><div class="alert alert-success">✅ Đã lưu dữ liệu sản phẩm thành công!</div></c:if>
      <c:if test="${param.message == 'deleted'}"><div class="alert alert-success">✅ Đã xóa sản phẩm thành công!</div></c:if>

      <div class="card shadow-sm border-0">
        <div class="card-body p-0">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
            <tr>
              <th class="ps-3">ID</th>
              <th>Hình Ảnh</th>
              <th>Tên Sản Phẩm</th>
              <th>Giá Bán</th>
              <th>Tồn Kho</th>
              <th>Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listProducts}" var="p">
              <tr>
                <td class="ps-3">${p.id}</td>
                <td><img src="${pageContext.request.contextPath}/${p.imageUrl}" class="img-thumb" alt="Ảnh"></td>
                <td class="fw-bold" style="max-width: 250px;">${p.name}</td>
                <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" type="number"/>đ</td>
                <td>
                  <span class="badge ${p.stockQuantity > 0 ? 'bg-success' : 'bg-danger'}">${p.stockQuantity}</span>
                </td>
                <td>
                  <button class="btn btn-sm btn-info text-white me-1"
                          data-id="${p.id}"
                          data-name="<c:out value='${p.name}'/>"
                          data-cat="${p.categoryId}"
                          data-price="${p.price}"
                          data-stock="${p.stockQuantity}"
                          data-desc="<c:out value='${p.description}'/>"
                          data-img="${p.imageUrl}"
                          onclick="openEditModal(this)">
                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                  </button>
                  <a href="products?action=delete&id=${p.id}" onclick="return confirm('Xóa sản phẩm này?');" class="btn btn-sm btn-danger">
                    <i class="fa-solid fa-trash-alt"></i> Xóa
                  </a>
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

<div class="modal fade" id="productModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="products" method="POST" enctype="multipart/form-data">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title fw-bold" id="modalTitle">Thêm Sản Phẩm Mới</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="action" id="formAction" value="add">
          <input type="hidden" name="id" id="productId">
          <input type="hidden" name="oldImage" id="oldImage">

          <div class="row mb-3">
            <div class="col-md-8">
              <label class="form-label fw-bold">Tên sản phẩm *</label>
              <input type="text" name="name" id="productName" class="form-control" required>
            </div>
            <div class="col-md-4">
              <label class="form-label fw-bold">Danh mục *</label>
              <select name="categoryId" id="productCategory" class="form-select" required>
                <c:forEach items="${listCategories}" var="c">
                  <option value="${c.id}">${c.name}</option>
                </c:forEach>
              </select>
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label fw-bold">Giá bán (VNĐ) *</label>
              <input type="number" name="price" id="productPrice" class="form-control" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold">Số lượng tồn kho *</label>
              <input type="number" name="stockQuantity" id="productStock" class="form-control" required>
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Hình ảnh sản phẩm</label>
            <input type="file" name="image" class="form-control" accept="image/*">
            <small class="text-muted" id="imageHint">Chọn ảnh mới để thay đổi ảnh hiện tại.</small>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Mô tả chi tiết</label>
            <textarea name="description" id="productDesc" class="form-control" rows="4"></textarea>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
          <button type="submit" class="btn btn-primary fw-bold"><i class="fa-solid fa-save me-1"></i> Lưu Dữ Liệu</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function openAddModal() {
    document.getElementById('modalTitle').innerText = "Thêm Sản Phẩm Mới";
    document.getElementById('formAction').value = "add";
    document.getElementById('productId').value = "";
    document.getElementById('productName').value = "";
    document.getElementById('productPrice').value = "";
    document.getElementById('productStock').value = "";
    document.getElementById('productDesc').value = "";
    document.getElementById('oldImage').value = "";
    document.getElementById('imageHint').style.display = "none";
  }

  function openEditModal(btn) {
    document.getElementById('modalTitle').innerText = "Cập nhật Sản Phẩm";
    document.getElementById('formAction').value = "edit";

    document.getElementById('productId').value = btn.getAttribute('data-id');
    document.getElementById('productName').value = btn.getAttribute('data-name');
    document.getElementById('productCategory').value = btn.getAttribute('data-cat');
    document.getElementById('productPrice').value = btn.getAttribute('data-price');
    document.getElementById('productStock').value = btn.getAttribute('data-stock');
    document.getElementById('productDesc').value = btn.getAttribute('data-desc');
    document.getElementById('oldImage').value = btn.getAttribute('data-img');

    document.getElementById('imageHint').style.display = "block";

    new bootstrap.Modal(document.getElementById('productModal')).show();
  }
</script>
</body>
</html>