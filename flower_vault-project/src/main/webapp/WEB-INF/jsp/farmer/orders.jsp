<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Orders - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/farmer/dashboard">Farmer Dashboard</a>
        <div class="ms-auto">
            <span class="text-white me-3">${loggedInUser.name}</span>
            <a href="/farmer/dashboard" class="btn btn-outline-light btn-sm me-2">My Flowers</a>
            <a href="/logout" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4">Customer Orders</h2>

    <c:if test="${empty orders}">
        <div class="alert alert-info">You don't have any orders yet. Keep growing those flowers!</div>
    </c:if>

    <c:forEach items="${orders}" var="o">
        <div class="card shadow-sm border-0 mb-4">
            <!-- Order Header -->
            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                <div>
                    <strong>Order #${o.id}</strong> 
                    <span class="text-muted ms-3">${o.createdAt}</span>
                </div>
                <div>
                    <span class="badge 
                        ${o.status eq 'PLACED' ? 'bg-warning text-dark' : ''}
                        ${o.status eq 'SHIPPED' ? 'bg-info text-dark' : ''}
                        ${o.status eq 'DELIVERED' ? 'bg-success' : ''} fs-6">
                        ${o.status}
                    </span>
                </div>
            </div>
            
            <div class="card-body">
                <!-- Delivery Details -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6 class="text-muted text-uppercase small fw-bold">Deliver To</h6>
                        <p class="mb-0"><strong>${o.deliveryName}</strong></p>
                        <p class="mb-0">${o.deliveryPhone}</p>
                        <p class="mb-0">${o.deliveryAddress}</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h6 class="text-muted text-uppercase small fw-bold">Update Status</h6>
                        <form action="/farmer/orders/${o.id}/status" method="post" class="d-inline-block">
                            <div class="input-group input-group-sm">
                                <select name="status" class="form-select">
                                    <option value="PLACED" ${o.status eq 'PLACED' ? 'selected' : ''}>Placed</option>
                                    <option value="SHIPPED" ${o.status eq 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                    <option value="DELIVERED" ${o.status eq 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                </select>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Items Table (Filtered for this Farmer) -->
                <h6 class="text-muted text-uppercase small fw-bold mb-2">Your Items in this Order</h6>
                <table class="table table-sm table-bordered align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Flower</th>
                            <th class="text-center">Qty</th>
                            <th class="text-end">Your Revenue</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="farmerTotal" value="${0}" />
                        <c:forEach items="${o.items}" var="i">
                            <!-- Only display items belonging to the logged-in farmer -->
                            <c:if test="${i.flower.farmer.id eq loggedInUser.id}">
                                <tr>
                                    <td>${i.flower.name}</td>
                                    <td class="text-center">${i.quantity}</td>
                                    <td class="text-end fw-bold text-success">Rs${i.subtotal}</td>
                                </tr>
                                <!-- Add to farmer's specific total -->
                                <c:set var="farmerTotal" value="${farmerTotal + i.subtotal}" />
                            </c:if>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr class="table-light">
                            <td colspan="2" class="text-end fw-bold">Total Earned from this Order:</td>
                            <td class="text-end fw-bold text-success fs-5">Rs${farmerTotal}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>