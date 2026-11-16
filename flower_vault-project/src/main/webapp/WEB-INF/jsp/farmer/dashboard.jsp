<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Farmer Dashboard - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/farmer/dashboard">Farmer Dashboard</a>
        <div class="ms-auto">
            <span class="text-white me-3">${loggedInUser.name}</span>
             <a href="/farmer/orders" class="btn btn-warning btn-sm me-2 text-dark fw-bold">View Orders</a>
            <a href="/" class="btn btn-outline-light btn-sm me-2">View Shop</a>
            <a href="/logout" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">

    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"> + Add New Flower</h5>
        </div>
        <div class="card-body">
            <form action="/farmer/flower/add" method="post" class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Flower Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Price (Rs)</label>
                    <input type="number" step="0.01" min="0" name="price" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Stock Quantity</label>
                    <input type="number" min="0" name="stockQuantity" class="form-control" required>
                </div>
                <div class="col-12">
                    <label class="form-label">Image URL</label>
                    <input type="url" name="imageUrl" class="form-control"
                           placeholder="https://example.com/flower.jpg">
                </div>
                <div class="col-12">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="2"></textarea>
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-success">Add Flower</button>
                </div>
            </form>
        </div>
    </div>

    <h4 class="mb-3">Your Listings (${flowers.size()})</h4>

    <c:if test="${empty flowers}">
        <div class="alert alert-info">You haven't added any flowers yet. Use the form above.</div>
    </c:if>

    <c:if test="${not empty flowers}">
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Image</th>
                            <th>Name</th>
                            <th class="text-end">Price</th>
                            <th class="text-center">Stock</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${flowers}" var="f">
                        <tr>
                            <td>
                                <img src="${f.imageUrl}" style="width:60px;height:60px;object-fit:cover"
                                     class="rounded" alt="${f.name}"
                                     onerror="this.src='https://via.placeholder.com/60'">
                            </td>
                            <td>
                                <a href="/flower/${f.id}" class="fw-bold text-decoration-none">${f.name}</a>
                                <div class="small text-muted">${f.description}</div>
                            </td>
                            <td class="text-end">Rs${f.price}</td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${f.stockQuantity > 0}">
                                        <span class="badge bg-success">${f.stockQuantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Out</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end">
                                <a href="/farmer/flower/edit/${f.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/farmer/flower/delete/${f.id}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Delete ${f.name}?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>