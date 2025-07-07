<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ExamCategoriesDAO, model.ExamCategoriesDTO, java.util.List" %>
<%
    model.UsersDTO user = (model.UsersDTO) session.getAttribute("user");
    if (user == null || !"Instructor".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    ExamCategoriesDAO catDao = new ExamCategoriesDAO();
    List<ExamCategoriesDTO> categories = catDao.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Exam</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">📝 Create New Exam</h4>
        </div>
        <div class="card-body">
            <form action="exam" method="post">
                <input type="hidden" name="action" value="create"/>

                <div class="mb-3">
                    <label class="form-label">Exam Title</label>
                    <input type="text" name="examTitle" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Subject</label>
                    <input type="text" name="subject" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <% for (ExamCategoriesDTO c : categories) { %>
                            <option value="<%= c.getCategoryId() %>"><%= c.getCategoryName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Total Marks</label>
                    <input type="number" name="totalMarks" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Duration (minutes)</label>
                    <input type="number" name="duration" class="form-control" required/>
                </div>

                <button type="submit" class="btn btn-primary w-100">Create Exam</button>
            </form>

            <div class="mt-3 text-center">
                <a href="welcome.jsp" class="btn btn-outline-secondary">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>