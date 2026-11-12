<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - TheFlowerVault</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">TheFlowerVault</a>
        <div class="ms-auto">
            <a href="/login" class="btn btn-outline-light btn-sm">Login</a>
        </div>
    </div>
</nav>

<div class="container mt-5" style="max-width:480px">
    <div class="card shadow-sm border-0">
        <div class="card-body p-4">
            <h2 class="text-center mb-4">Create Account</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="/register" method="post">
                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" minlength="6" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">I am a</label>
                    <select name="role" class="form-select" required>
                        <option value="CUSTOMER">Customer - I want to buy flowers</option>
                        <option value="FARMER">Farmer - I want to sell flowers</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success w-100 btn-lg">Create Account</button>
            </form>

            <p class="text-center mt-3 mb-0 small">
                Already registered? <a href="/login">Login here</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>