<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TheFlowerVault - Fresh Flowers, Direct from Farmers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <c:choose>
                <c:when test="${not empty loggedInUser}">
                    <span class="text-white me-3">Hi, ${loggedInUser.name}</span>
                    <c:choose>
                        <c:when test="${loggedInUser.role eq 'CUSTOMER'}">
                            <a href="/cart/view" class="btn btn-outline-light btn-sm me-2">Cart</a>
                            <a href="/orders" class="btn btn-outline-light btn-sm me-2">My Orders</a>
                        </c:when>
                        <c:when test="${loggedInUser.role eq 'FARMER'}">
                            <a href="/farmer/dashboard" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                        </c:when>
                    </c:choose>
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
    <div class="text-center mb-5">
        <h1 class="display-5 fw-bold">Fresh Flowers, Direct from Farmers</h1>
        <p class="lead text-muted">Browse and order farm-fresh blooms, delivered to your door.</p>
    </div>

    <c:if test="${empty flowers}">
        <div class="alert alert-info text-center">No flowers listed yet. Please check back soon.</div>
    </c:if>

    <div class="row g-4">
        <c:forEach items="${flowers}" var="f">
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="${f.imageUrl}" class="card-img-top"
                         style="height:220px;object-fit:cover" alt="${f.name}"
                         onerror="this.src='https://via.placeholder.com/600x400?text=Flower'">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${f.name}</h5>
                        <p class="card-text text-muted small flex-grow-1">${f.description}</p>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="fs-5 text-success fw-bold">Rs${f.price}</span>
                            <c:choose>
                                <c:when test="${f.stockQuantity > 0}">
                                    <span class="badge bg-success">In Stock: ${f.stockQuantity}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Out of Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <a href="/flower/${f.id}" class="btn btn-primary w-100">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<footer class="text-center text-muted py-5 mt-5">
    <small>&copy; 2026 TheFlowerVault - Connecting farmers and flower lovers.</small>
</footer>
</body>
</html>