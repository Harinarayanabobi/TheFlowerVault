<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <span class="text-white me-3">Hi, ${loggedInUser.name}</span>
            <a href="/cart/view" class="btn btn-outline-light btn-sm me-2">Cart</a>
            <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4">My Orders</h2>

    <c:if test="${empty orders}">
        <div class="alert alert-info">
            You haven't placed any orders yet. <a href="/" class="alert-link">Browse flowers</a>.
        </div>
    </c:if>

    <c:forEach items="${orders}" var="o">
        <div class="card shadow-sm border-0 mb-3">
            <div class="card-header d-flex justify-content-between align-items-center bg-white">
                <span>
                    <strong>Order #${o.id}</strong>
                    <span class="text-muted ms-3">${o.createdAt}</span>
                </span>
                <span class="badge bg-success">${o.status}</span>
            </div>
            <div class="card-body">
                <c:forEach items="${o.items}" var="i" varStatus="loop">
                    <div class="d-flex justify-content-between py-1
                                ${not loop.last ? 'border-bottom' : ''}">
                        <span>${i.flower.name} <span class="text-muted">x ${i.quantity}</span></span>
                        <span class="fw-bold">Rs${i.subtotal}</span>
                    </div>
                </c:forEach>
            </div>
            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                <span class="text-muted small">
                    Deliver to: ${o.deliveryName}, ${o.deliveryPhone}
                </span>
                <span class="fs-5">
                    Total: <strong class="text-success">Rs${o.totalAmount}</strong>
                </span>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>