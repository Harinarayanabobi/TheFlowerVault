<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <span class="text-white me-3">Hi, ${loggedInUser.name}</span>
            <a href="/cart/view" class="btn btn-outline-light btn-sm me-2">Cart</a>
            <a href="/orders" class="btn btn-outline-light btn-sm me-2">My Orders</a>
            <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4">Your Cart</h2>

    <c:if test="${empty cartItems}">
        <div class="alert alert-info">
            Your cart is empty. <a href="/" class="alert-link">Browse flowers</a> to start shopping.
        </div>
    </c:if>

    <c:if test="${not empty cartItems}">
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Flower</th>
                            <th class="text-end">Price</th>
                            <th class="text-center">Qty</th>
                            <th class="text-end">Subtotal</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr>
                            <td>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="${item.flower.imageUrl}"
                                         style="width:60px;height:60px;object-fit:cover"
                                         class="rounded" alt="${item.flower.name}">
                                    <div>
                                        <a href="/flower/${item.flower.id}" class="fw-bold text-decoration-none">
                                            ${item.flower.name}
                                        </a>
                                        <div class="small text-muted">by ${item.flower.farmer.name}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="text-end">Rs${item.flower.price}</td>
                            <td class="text-center">${item.quantity}</td>
                            <td class="text-end fw-bold">Rs${item.subtotal}</td>
                            <td class="text-end">
                                <a href="/cart/remove/${item.id}"
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Remove this item?')">Remove</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot class="table-light">
                        <tr>
                            <td colspan="3" class="text-end fw-bold fs-5">Total:</td>
                            <td class="text-end fw-bold fs-5 text-success">Rs${cartTotal}</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <div class="d-flex justify-content-between mt-4">
            <a href="/" class="btn btn-outline-secondary btn-lg">Continue Shopping</a>
            <a href="/checkout" class="btn btn-primary btn-lg">Proceed to Checkout &rarr;</a>
        </div>
    </c:if>
</div>
</body>
</html>