<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${flower.name} — TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/"> TheFlowerVault</a>
        <div class="ms-auto">
            <c:choose>
                <c:when test="${not empty loggedInUser}">
                    <span class="text-white me-3">Hi, ${loggedInUser.name}</span>
                    <c:if test="${loggedInUser.role eq 'CUSTOMER'}">
                        <a href="/cart/view" class="btn btn-outline-light btn-sm me-2">Cart</a>
                        <a href="/orders" class="btn btn-outline-light btn-sm me-2">My Orders</a>
                    </c:if>
                    <c:if test="${loggedInUser.role eq 'FARMER'}">
                        <a href="/farmer/dashboard" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                    </c:if>
                    <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/login" class="btn btn-outline-light btn-sm me-2">Login</a>
                    <a href="/register" class="btn btn-success btn-sm">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <a href="/" class="btn btn-link mb-3">&larr; Back to all flowers</a>

    <c:if test="${param.error != null}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <div class="row g-4">
        <div class="col-md-6">
            <img src="${flower.imageUrl}" class="img-fluid rounded shadow w-100"
                 style="max-height:480px;object-fit:cover" alt="${flower.name}"
                 onerror="this.src='https://via.placeholder.com/600x400?text=Flower'">
        </div>
        <div class="col-md-6">
            <h2>${flower.name}</h2>
            <p class="text-muted">${flower.description}</p>

            <h3 class="text-success my-4">Rs${flower.price}</h3>

            <ul class="list-group list-group-flush mb-4">
                <li class="list-group-item d-flex justify-content-between">
                    <span>Sold by</span><strong>${flower.farmer.name}</strong>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Availability</span>
                    <c:choose>
                        <c:when test="${flower.stockQuantity > 0}">
                            <strong class="text-success">${flower.stockQuantity} in stock</strong>
                        </c:when>
                        <c:otherwise>
                            <strong class="text-danger">Out of stock</strong>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>

            <c:choose>
                <c:when test="${empty loggedInUser}">
                    <div class="alert alert-warning">
                        <a href="/login" class="alert-link">Login</a> to add this flower to your cart.
                    </div>
                    <a href="/login" class="btn btn-primary btn-lg">Login to Buy</a>
                </c:when>
                <c:when test="${loggedInUser.role eq 'FARMER'}">
                    <div class="alert alert-info">You are logged in as a farmer. Switch to a customer account to buy.</div>
                </c:when>
                <c:when test="${flower.stockQuantity <= 0}">
                    <button class="btn btn-secondary btn-lg" disabled>Out of Stock</button>
                </c:when>
                <c:otherwise>
                    <form action="/cart/add" method="post" class="d-flex gap-2 flex-wrap">
                        <input type="hidden" name="flowerId" value="${flower.id}">
                        <div class="input-group" style="max-width:180px">
                            <span class="input-group-text">Qty</span>
                            <input type="number" name="quantity" value="1" min="1"
                                   max="${flower.stockQuantity}" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success btn-lg">Add to Cart</button>
                        <a href="/" class="btn btn-outline-secondary btn-lg">Continue Shopping</a>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>