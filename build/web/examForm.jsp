<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ExamCategoriesDTO, java.util.List" %>

<%
    List<ExamCategoriesDTO> categoryList = (List<ExamCategoriesDTO>) request.getAttribute("categoryList");
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
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">📝 Create New Exam</h4>
        </div>
        <div class="card-body">
            <form action="exam" method="post">
                <input type="hidden" name="examId" value="0"/>

                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="examTitle" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Subject</label>
                    <input type="text" name="subject" class="form-control" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <% for (ExamCategoriesDTO cat : categoryList) { %>
                            <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryName() %></option>
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

                <button type="submit" class="btn btn-success w-100">Create Exam</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>