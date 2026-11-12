<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <a href="/register" class="btn btn-success btn-sm">Register</a>
        </div>
    </div>
</nav>

<div class="container mt-5" style="max-width:450px">
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <h2 class="text-center mb-4">Login</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${param.registered eq 'true'}">
                <div class="alert alert-success">Account created. Please log in.</div>
            </c:if>

            <form action="/login" method="post">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required autofocus>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 btn-lg">Login</button>
            </form>

            <p class="text-center mt-3 mb-0 small">
                New here? <a href="/register">Create an account</a>
            </p>
        </div>
    </div>

    <div class="card border-0 bg-white shadow-sm mt-3">
        <div class="card-body small">
            <strong>Demo accounts:</strong><br>
            Farmer &mdash; <code>farmer@vault.com</code> / <code>farmer123</code><br>
            Customer &mdash; <code>customer@vault.com</code> / <code>customer123</code>
        </div>
    </div>
</div>
</body>
</html>