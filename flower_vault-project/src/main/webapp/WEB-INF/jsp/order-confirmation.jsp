<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmed - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <span class="text-white me-3">Hi, ${loggedInUser.name}</span>
            <a href="/orders" class="btn btn-outline-light btn-sm me-2">My Orders</a>
            <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5" style="max-width:760px">

    <div class="text-center mb-4">
        <div class="display-1"></div>   // emoji for celebration
        <h2 class="text-success">Order Placed Successfully!</h2>
        <p class="text-muted">Thank you for shopping with TheFlowerVault.</p>
    </div>

    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-success text-white d-flex justify-content-between">
            <span><strong>Order #${order.id}</strong></span>
            <span class="badge bg-light text-dark">${order.status}</span>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-sm-6">
                    <strong>Deliver to:</strong><br>
                    ${order.deliveryName}<br>
                    ${order.deliveryPhone}<br>
                    ${order.deliveryAddress}
                </div>
                <div class="col-sm-6 text-sm-end">
                    <strong>Placed on:</strong><br>
                    ${order.createdAt}
                </div>
            </div>

            <table class="table table-bordered align-middle mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>Flower</th>
                        <th class="text-center">Qty</th>
                        <th class="text-end">Unit Price</th>
                        <th class="text-end">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${order.items}" var="i">
                    <tr>
                        <td>${i.flower.name}</td>
                        <td class="text-center">${i.quantity}</td>
                        <td class="text-end">Rs${i.unitPrice}</td>
                        <td class="text-end fw-bold">Rs${i.subtotal}</td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot class="table-light">
                    <tr>
                        <td colspan="3" class="text-end fw-bold fs-5">Total Paid:</td>
                        <td class="text-end fw-bold fs-5 text-success">Rs${order.totalAmount}</td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    <div class="d-flex gap-2 justify-content-center">
        <a href="/" class="btn btn-outline-secondary btn-lg">Continue Shopping</a>
        <a href="/orders" class="btn btn-primary btn-lg">View My Orders</a>
    </div>
</div>
</body>
</html>