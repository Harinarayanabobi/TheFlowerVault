<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit ${flower.name} - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/farmer/dashboard">Farmer Dashboard</a>
        <div class="ms-auto">
            <span class="text-white me-3">${loggedInUser.name}</span>
            <a href="/logout" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5" style="max-width:700px">
    <a href="/farmer/dashboard" class="btn btn-link mb-2">&larr; Back to Dashboard</a>

    <div class="card shadow-sm border-0">
        <div class="card-header bg-warning">
            <h4 class="mb-0">Edit: ${flower.name}</h4>
        </div>
        <div class="card-body p-4">
            <form action="/farmer/flower/edit/${flower.id}" method="post">
                <div class="mb-3">
                    <label class="form-label">Flower Name</label>
                    <input type="text" name="name" class="form-control" value="${flower.name}" required>
                </div>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Price (Rs)</label>
                        <input type="number" step="0.01" min="0" name="price" class="form-control"
                               value="${flower.price}" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Stock Quantity</label>
                        <input type="number" min="0" name="stockQuantity" class="form-control"
                               value="${flower.stockQuantity}" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Image URL</label>
                    <input type="url" name="imageUrl" class="form-control" value="${flower.imageUrl}">
                    <c:if test="${not empty flower.imageUrl}">
                        <img src="${flower.imageUrl}" class="mt-2 rounded" style="height:100px"
                             onerror="this.style.display='none'">
                    </c:if>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${flower.description}</textarea>
                </div>
                <div class="d-flex gap-2">
                    <a href="/farmer/dashboard" class="btn btn-outline-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success flex-grow-1">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>