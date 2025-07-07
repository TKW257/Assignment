<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.ExamCategoriesDTO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam Categories</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-info text-white">
            <h4 class="mb-0">📚 Exam Categories</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered table-striped">
                <thead class="table-light">
                    <tr>
                        <th>Category Name</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ExamCategoriesDTO> list = (List<ExamCategoriesDTO>) request.getAttribute("categoryList");
                        if (list != null && !list.isEmpty()) {
                            for (ExamCategoriesDTO cat : list) {
                    %>
                    <tr>
                        <td><%= cat.getCategoryName() %></td>
                        <td><%= cat.getDescription() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="2" class="text-center text-muted">No categories found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="text-center mt-3">
                <a href="welcome.jsp" class="btn btn-outline-secondary">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>