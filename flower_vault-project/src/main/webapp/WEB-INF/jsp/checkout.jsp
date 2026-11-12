<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - TheFlowerVault</title>
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

<div class="container mt-5" style="max-width:700px">
    <h2 class="mb-1">Checkout</h2>
    <p class="text-muted">Enter your delivery details to place the order.</p>

    <form action="/checkout" method="post" class="card shadow-sm border-0 p-4">
        <div class="mb-3">
            <label class="form-label fw-semibold">Full Name</label>
            <input type="text" name="name" class="form-control form-control-lg"
                   value="${loggedInUser.name}" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Phone Number</label>
            <input type="tel" name="phone" class="form-control form-control-lg"
                   pattern="[0-9]{10}" placeholder="10-digit mobile number" required>
        </div>
        <div class="mb-3">
            <label class="form-label fw-semibold">Delivery Address</label>
            <textarea name="address" class="form-control form-control-lg" rows="4"
                      placeholder="House no, street, city, PIN code" required></textarea>
        </div>

        <div class="alert alert-info d-flex justify-content-between align-items-center fs-5">
            <span>Total Amount</span>
            <strong class="text-success">Rs${cartTotal}</strong>
        </div>

        <div class="alert alert-secondary small mb-3">
             No online payment required - pay cash on delivery.
        </div>

        <div class="d-flex gap-2">
            <a href="/cart/view" class="btn btn-outline-secondary btn-lg">Back to Cart</a>
            <button type="submit" class="btn btn-success btn-lg flex-grow-1">Place Order</button>
        </div>
    </form>
</div>
</body>
</html>