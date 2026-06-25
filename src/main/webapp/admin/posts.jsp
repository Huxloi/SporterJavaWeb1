<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý Bài viết - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    .sidebar { min-height: 100vh; background-color: #343a40; color: white; padding-top: 20px;}
    .sidebar a { color: #adb5bd; text-decoration: none; display: block; padding: 15px 20px; font-weight: 500;}
    .sidebar a:hover, .sidebar a.active { background-color: #495057; color: white; border-left: 4px solid #0d6efd;}
    .content { padding: 30px; background-color: #f8f9fa; min-height: 100vh;}
    .img-thumb { width: 70px; height: 50px; object-fit: cover; border-radius: 4px; }
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
      <a href="${pageContext.request.contextPath}/admin/posts" class="active"><i class="fa-solid fa-newspaper me-2"></i> Bài viết</a>
      <a href="${pageContext.request.contextPath}/admin/comments"><i class="fa-solid fa-comments me-2"></i> Quản lý Bình luận</a>
      <a href="${pageContext.request.contextPath}/admin/reports"><i class="fa-solid fa-chart-line me-2"></i> Thống kê & Báo cáo</a>
      <hr class="text-secondary mx-3">
      <a href="${pageContext.request.contextPath}/index" target="_blank"><i class="fa-solid fa-shop me-2"></i> Xem Cửa hàng</a>
      <a href="${pageContext.request.contextPath}/logout" class="text-danger"><i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất</a>
    </div>

    <div class="col-md-10 content">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><i class="fa-solid fa-newspaper text-primary me-2"></i> Quản lý Bài viết / Tin tức</h2>
        <button class="btn btn-primary fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#postModal" onclick="openAddModal()">
          <i class="fa-solid fa-plus me-1"></i> Viết Bài Mới
        </button>
      </div>

      <c:if test="${param.message == 'success'}"><div class="alert alert-success">✅ Đã cập nhật dữ liệu bài viết thành công!</div></c:if>
      <c:if test="${param.message == 'deleted'}"><div class="alert alert-success">✅ Đã xóa bài viết thành công!</div></c:if>

      <div class="card shadow-sm border-0">
        <div class="card-body p-0">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
            <tr>
              <th class="ps-3" style="width: 7%;">ID</th>
              <th style="width: 12%;">Ảnh Bìa</th>
              <th style="width: 45%;">Tiêu Đề Bài Viết</th>
              <th style="width: 18%;">Ngày Đăng</th>
              <th style="width: 18%;">Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listPosts}" var="post">
              <tr>
                <td class="ps-3 text-secondary">#${post.id}</td>
                <td><img src="${pageContext.request.contextPath}/${post.imageUrl}" class="img-thumb border" alt=""></td>
                <td class="fw-bold text-dark">${post.title}</td>
                <td class="small text-muted"><fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td>
                  <button class="btn btn-sm btn-outline-info me-1"
                          data-id="${post.id}"
                          data-title="<c:out value='${post.title}'/>"
                          data-summary="<c:out value='${post.summary}'/>"
                          data-content="<c:out value='${post.content}'/>"
                          data-img="${post.imageUrl}"
                          onclick="openEditModal(this)">
                    <i class="fa-solid fa-marker"></i> Sửa
                  </button>
                  <a href="posts?action=delete&id=${post.id}" onclick="return confirm('Bạn có chắc muốn xóa bài viết này?');" class="btn btn-sm btn-danger">
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

<div class="modal fade" id="postModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="posts" method="POST" enctype="multipart/form-data">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title fw-bold" id="modalTitle">Viết Bài Mới</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="action" id="formAction" value="add">
          <input type="hidden" name="id" id="postId">
          <input type="hidden" name="oldImage" id="oldImage">

          <div class="mb-3">
            <label class="form-label fw-bold">Tiêu đề bài viết *</label>
            <input type="text" name="title" id="postTitle" class="form-control" required placeholder="Nhập tiêu đề hấp dẫn...">
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Tóm tắt ngắn gọn *</label>
            <textarea name="summary" id="postSummary" class="form-control" rows="2" required placeholder="Hiển thị ở trang danh sách tin tức..."></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Ảnh bìa bài viết</label>
            <input type="file" name="image" class="form-control" accept="image/*">
            <small class="text-muted" id="imageHint">Chọn ảnh mới để thay đổi ảnh hiện tại.</small>
          </div>

          <div class="mb-3">
            <label class="form-label fw-bold">Nội dung bài viết *</label>
            <textarea name="content" id="postContent" class="form-control" rows="8" required placeholder="Viết nội dung chi tiết tại đây..."></textarea>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-primary fw-bold"><i class="fa-solid fa-paper-plane me-1"></i> Xuất Bản Bài Viết</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function openAddModal() {
    document.getElementById('modalTitle').innerText = "Viết Bài Mới";
    document.getElementById('formAction').value = "add";
    document.getElementById('postId').value = "";
    document.getElementById('postTitle').value = "";
    document.getElementById('postSummary').value = "";
    document.getElementById('postContent').value = "";
    document.getElementById('oldImage').value = "";
    document.getElementById('imageHint').style.display = "none";
  }

  function openEditModal(btn) {
    document.getElementById('modalTitle').innerText = "Cập nhật Bài Viết";
    document.getElementById('formAction').value = "edit";

    document.getElementById('postId').value = btn.getAttribute('data-id');
    document.getElementById('postTitle').value = btn.getAttribute('data-title');
    document.getElementById('postSummary').value = btn.getAttribute('data-summary');
    document.getElementById('postContent').value = btn.getAttribute('data-content');
    document.getElementById('oldImage').value = btn.getAttribute('data-img');

    document.getElementById('imageHint').style.display = "block";

    new bootstrap.Modal(document.getElementById('postModal')).show();
  }
</script>
</body>
</html>