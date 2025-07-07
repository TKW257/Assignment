<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ExamDTO, model.ExamCategoriesDTO, java.util.List" %>

<%
    ExamDTO exam = (ExamDTO) request.getAttribute("exam");
    List<ExamCategoriesDTO> categoryList = (List<ExamCategoriesDTO>) request.getAttribute("categoryList");

    if (exam == null) {
%>
    <div class="alert alert-danger text-center mt-5">Exam not found.</div>
    <%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Exam</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4 class="mb-0">✏️ Edit Exam</h4>
        </div>
        <div class="card-body">
            <form action="exam" method="post">
                <input type="hidden" name="examId" value="<%= exam.getExamId() %>"/>

                <div class="mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="examTitle" class="form-control" value="<%= exam.getExamTitle() %>" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Subject</label>
                    <input type="text" name="subject" class="form-control" value="<%= exam.getSubject() %>" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select name="categoryId" class="form-select" required>
                        <% for (ExamCategoriesDTO cat : categoryList) { %>
                            <option value="<%= cat.getCategoryId() %>" <%= cat.getCategoryId() == exam.getCategoryId() ? "selected" : "" %>>
                                <%= cat.getCategoryName() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Total Marks</label>
                    <input type="number" name="totalMarks" class="form-control" value="<%= exam.getTotalMarks() %>" required/>
                </div>

                <div class="mb-3">
                    <label class="form-label">Duration (minutes)</label>
                    <input type="number" name="duration" class="form-control" value="<%= exam.getDuration() %>" required/>
                </div>

                <button type="submit" name="update" class="btn btn-primary w-100">Update Exam</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>