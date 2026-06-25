<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đơn hàng #${order.id}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .product-thumb { width: 60px; height: 60px; object-fit: cover; border-radius: 5px; }
    </style>
</head>
<body>

<div class="container my-5" style="max-width: 900px;">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="orders" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách</a>
        <h3 class="fw-bold m-0">Chi tiết Đơn hàng: #${order.id}</h3>
    </div>

    <c:if test="${param.message == 'updated'}">
        <div class="alert alert-success fw-bold">✅ Đã cập nhật trạng thái đơn hàng thành công!</div>
    </c:if>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-white fw-bold py-3">Thông tin Vận chuyển</div>
                <div class="card-body">
                    <p><strong>Khách hàng ID:</strong> ${order.userId}</p>
                    <p><strong>Điện thoại:</strong> ${order.phone}</p>
                    <p><strong>Địa chỉ:</strong> ${order.address}</p>
                    <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                    <p class="mb-0 mt-2"><strong>Trạng thái hiện tại:</strong>
                        <span class="badge bg-primary">${order.status}</span>
                    </p>
                </div>
            </div>

            <div class="card shadow-sm border-0 bg-warning bg-opacity-10">
                <div class="card-header bg-white fw-bold py-3 text-dark">Cập nhật Trạng thái</div>
                <div class="card-body">
                    <form action="orders" method="POST">
                        <input type="hidden" name="action" value="update_status">
                        <input type="hidden" name="orderId" value="${order.id}">

                        <div class="mb-3">
                            <%-- ĐÃ BỎ onchange="this.form.submit()" ĐỂ BẮT BUỘC PHẢI NHẤN NÚT LƯU BÊN DƯỚI --%>
                            <select name="status" class="form-select border-warning shadow-sm" required>
                                <option value="" disabled selected>-- Chọn bước tiếp theo --</option>
                                <c:set var="stt" value="${order.status.trim()}" />

                                <c:if test="${stt == 'Chờ xác nhận'}">
                                    <option value="Đang xử lý">Đang xử lý</option>
                                    <option value="Đang giao hàng">Đang giao hàng</option>
                                    <option value="Đã hoàn thành">Đã hoàn thành</option>
                                    <option value="Đã hủy">Đã hủy</option>
                                </c:if>

                                <c:if test="${stt == 'Đang xử lý'}">
                                    <option value="Đang giao hàng">Đang giao hàng</option>
                                    <option value="Đã hoàn thành">Đã hoàn thành</option>
                                    <option value="Đã hủy">Đã hủy</option>
                                </c:if>

                                <c:if test="${stt == 'Đang giao hàng'}">
                                    <option value="Đã hoàn thành">Đã hoàn thành</option>
                                    <option value="Đã hủy">Đã hủy</option>
                                </c:if>

                                <c:if test="${stt == 'Đã hoàn thành' || stt == 'Đã hủy'}">
                                    <option value="" disabled selected>Đơn hàng đã kết thúc</option>
                                </c:if>
                            </select>
                        </div>
                        <%-- Chỉ khi nhấn nút này form mới được gửi đi --%>
                        <button type="submit" class="btn btn-warning w-100 fw-bold"><i class="fa-solid fa-arrows-rotate me-1"></i> LƯU TRẠNG THÁI</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white fw-bold py-3">Sản phẩm trong đơn hàng</div>
                <div class="card-body p-0">
                    <table class="table align-middle m-0">
                        <thead class="table-light">
                        <tr>
                            <th class="ps-3">Sản phẩm</th>
                            <th>Phân loại</th>
                            <th>SL</th>
                            <th>Đơn giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${order.items}" var="item">
                            <tr>
                                <td class="ps-3 d-flex align-items-center py-3">
                                    <img src="${pageContext.request.contextPath}/${item.productImg}" class="product-thumb me-3" alt="">
                                    <span class="fw-bold">${item.productName}</span>
                                </td>
                                <td>Size: ${item.selectedSize} | ${item.selectedColor}</td>
                                <td class="fw-bold">${item.quantity}</td>
                                <td class="text-danger fw-bold"><fmt:formatNumber value="${item.priceAtPurchase}" type="number"/>đ</td>
                            </tr>
                        </c:forEach>
                        <tr class="table-light">
                            <td colspan="3" class="text-end fw-bold fs-5">TỔNG THANH TOÁN:</td>
                            <td class="text-danger fw-bold fs-5"><fmt:formatNumber value="${order.totalAmount}" type="number"/>đ</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>