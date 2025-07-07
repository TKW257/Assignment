<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UsersDTO, model.ExamDTO, model.ExamCategoriesDTO, java.util.List" %>

<%
    UsersDTO user = (UsersDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = user.getRole();
    List<ExamCategoriesDTO> categoryList = (List<ExamCategoriesDTO>) request.getAttribute("categoryList");
    List<ExamDTO> examList = (List<ExamDTO>) request.getAttribute("examList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam Dashboard</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Exam System</a>
        <div class="d-flex">
            <span class="navbar-text text-white me-3">Welcome, <%= user.getName() %> (<%= role %>)</span>
            <a href="UserController?action=logout" class="btn btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<div class="container">
    <% if ("Instructor".equalsIgnoreCase(role)) { %>
        <div class="mb-3 d-flex gap-2">
            <form action="exam" method="get">
                <input type="hidden" name="action" value="create"/>
                <button type="submit" class="btn btn-primary">+ Create New Exam</button>
            </form>
            <form action="question" method="get">
                <input type="hidden" name="action" value="add"/>
                <button type="submit" class="btn btn-secondary">+ Add Question</button>
            </form>
        </div>
    <% } %>

    <h3 class="mt-4">📚 Exam Categories</h3>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Category Name</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
        <% if (categoryList != null && !categoryList.isEmpty()) {
               for (ExamCategoriesDTO cat : categoryList) { %>
            <tr>
                <td><%= cat.getCategoryName() %></td>
                <td><%= cat.getDescription() %></td>
            </tr>
        <% } } else { %>
            <tr><td colspan="2">No categories found.</td></tr>
        <% } %>
        </tbody>
    </table>

    <h3 class="mt-4">🔍 Filter Exams by Category</h3>
    <form action="exam" method="get" class="row g-3 align-items-center mb-4">
        <input type="hidden" name="action" value="filterByCategory"/>
        <div class="col-auto">
            <select name="categoryId" class="form-select">
                <% if (categoryList != null) {
                       for (ExamCategoriesDTO cat : categoryList) { %>
                    <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
                <% } } %>
            </select>
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-outline-primary">Filter</button>
        </div>
    </form>

    <h3>📝 Available Exams</h3>
    <table class="table table-hover table-bordered">
        <thead class="table-secondary">
            <tr>
                <th>Title</th>
                <th>Subject</th>
                <th>Total Marks</th>
                <th>Duration</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% if (examList != null && !examList.isEmpty()) {
               for (ExamDTO exam : examList) { %>
            <tr>
                <td><%= exam.getExamTitle() %></td>
                <td><%= exam.getSubject() %></td>
                <td><%= exam.getTotalMarks() %></td>
                <td><%= exam.getDuration() %> mins</td>
                <td>
                    <% if ("Instructor".equalsIgnoreCase(role)) { %>
                        <a href="exam?action=edit&id=<%= exam.getExamId() %>" class="btn btn-sm btn-warning">Edit</a>
                        <a href="exam?action=delete&id=<%= exam.getExamId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                    <% } else { %>
                        <a href="exam?action=take&id=<%= exam.getExamId() %>" class="btn btn-sm btn-success">Take Exam</a>
                    <% } %>
                </td>
            </tr>
        <% } } else { %>
            <tr><td colspan="5">No exams available.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>