<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trung tâm Hỗ trợ & Liên hệ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .main-container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .card-custom { border: none; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 30px; background: #fff; height: 100%; }
        .header-title { color: #0d6efd; font-weight: 700; margin-bottom: 30px; border-bottom: 2px solid #eef2f7; padding-bottom: 15px; }
    </style>
</head>
<body>

<div class="container main-container">
    <div class="d-flex align-items-center mb-4">
        <h2 class="header-title mb-0 flex-grow-1"><i class="fa-solid fa-headset me-2"></i> TRUNG TÂM HỖ TRỢ & LIÊN HỆ</h2>
        <a href="${pageContext.request.contextPath}/index" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-2"></i> Quay lại Trang chủ</a>
    </div>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        <div class="col-md-6">
            <div class="card card-custom">
                <h4 class="fw-bold mb-4"><i class="fa-solid fa-paper-plane text-primary me-2"></i> Gửi Tin nhắn Mới</h4>
                <form action="${pageContext.request.contextPath}/contact" method="POST" id="contactForm">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Họ tên (*)</label>
                        <input type="text" class="form-control" name="name" required placeholder="Nhập họ tên của bạn">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại (*)</label>
                        <input type="tel" class="form-control" name="phone" required placeholder="Nhập số điện thoại">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Chủ đề</label>
                        <input type="text" class="form-control" name="subject" placeholder="Chủ đề cần hỗ trợ">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Nội dung (*)</label>
                        <textarea class="form-control" name="message" rows="5" required placeholder="Viết nội dung phản hồi tại đây..."></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold" id="submitBtn">
                        <i class="fa-solid fa-location-arrow me-2"></i> GỬI YÊU CẦU
                    </button>
                </form>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card card-custom">
                <h4 class="fw-bold mb-4"><i class="fa-solid fa-history text-secondary me-2"></i> Lịch sử Tin nhắn & Phản hồi</h4>

                <c:choose>
                    <c:when test="${empty sessionScope.acc}">
                        <div class="text-center py-5 text-muted">
                            <i class="fa-solid fa-user-lock fa-3x mb-3"></i>
                            <p class="fw-bold">Vui lòng <a href="${pageContext.request.contextPath}/login">đăng nhập</a> để xem lịch sử gửi tin nhắn.</p>
                        </div>
                    </c:when>
                    <c:when test="${empty contactHistory}">
                        <div class="text-center py-5 text-muted">
                            <i class="fa-solid fa-envelope-open-text fa-3x mb-3"></i>
                            <p>Bạn chưa gửi yêu cầu hỗ trợ nào.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="overflow-auto" style="max-height: 400px;">
                            <c:forEach items="${contactHistory}" var="h">
                                <div class="border-start border-4 border-primary ps-3 mb-3 pb-3 border-bottom">
                                    <div class="d-flex justify-content-between small text-muted">
                                        <span class="fw-bold text-primary">Bạn đã gửi (#${h.id} - ${h.subject})</span>
                                        <span><fmt:formatDate value="${h.sentAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                                    </div>
                                    <div class="mt-1 text-dark"><strong>Nội dung:</strong> ${h.messageContent}</div>

                                    <c:if test="${h.isReplied == 1}">
                                        <div class="mt-2 bg-success bg-opacity-10 p-2 rounded border border-success border-opacity-25 small">
                                            <i class="fa-solid fa-reply text-success me-1"></i> <strong class="text-success">Phản hồi từ Admin:</strong> ${h.replyContent}
                                        </div>
                                    </c:if>

                                    <div class="mt-2">
                                        <c:choose>
                                            <c:when test="${h.isReplied == 1}">
                                                <span class="badge bg-success"><i class="fa-solid fa-check-double me-1"></i> Đã phản hồi</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark"><i class="fa-solid fa-clock me-1"></i> Đang chờ Admin phản hồi...</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="container main-container mb-5">
    <div class="card card-custom">
        <h3 class="fw-bold mb-4"><i class="fa-solid fa-store me-2"></i> Thông tin Cửa hàng</h3>
        <div class="row g-3 mb-4 border-bottom pb-3">
            <div class="col-md-4">
                <div class="d-flex">
                    <div class="text-primary fs-4 me-3"><i class="fa-solid fa-location-dot"></i></div>
                    <div>
                        <span class="d-block text-muted small fw-bold text-uppercase">Địa chỉ</span>
                        <span class="fw-bold text-dark">123 Đường Thể Thao, Quận 1, TP.HCM</span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="d-flex">
                    <div class="text-primary fs-4 me-3"><i class="fa-solid fa-phone"></i></div>
                    <div>
                        <span class="d-block text-muted small fw-bold text-uppercase">Điện thoại</span>
                        <span class="fw-bold text-dark">0987.654.321 (Hỗ trợ 24/7)</span>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="d-flex">
                    <div class="text-primary fs-4 me-3"><i class="fa-solid fa-envelope"></i></div>
                    <div>
                        <span class="d-block text-muted small fw-bold text-uppercase">Email</span>
                        <span class="fw-bold text-dark">support@sportshop.vn</span>
                    </div>
                </div>
            </div>
        </div>
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-map-location-dot me-2"></i> Vị trí trên bản đồ</h5>
        <div class="ratio ratio-21x9 rounded overflow-hidden shadow-sm">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.513753386629!2d106.69085277574878!3d10.77164475927376!2m3!1f0!2f0!3f0!3m2!1i1025!2i320!4f13.1!3m3!1m2!1s0x31752f40a3b4e6d3%3A0x2506e5793e25d082!2sTao%20Dan%20Park!5e0!3m2!1sen!2svn!4v1711728169125!3m2!1sen!2svn" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>
</div>

<script>
    // Chống gửi trùng lặp form
    document.getElementById('contactForm').addEventListener('submit', function() {
        const btn = document.getElementById('submitBtn');
        btn.disabled = true;
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-2"></i> ĐANG GỬI YÊU CẦU...';
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>