<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ExamDTO, java.util.List" %>

<%
    List<ExamDTO> examList = (List<ExamDTO>) request.getAttribute("examList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Question</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            <h4 class="mb-0">➕ Add New Question</h4>
        </div>
        <div class="card-body">
            <form action="question" method="post">
                <div class="mb-3">
                    <label class="form-label">Exam</label>
                    <select name="examId" class="form-select" required>
                        <% for (ExamDTO exam : examList) { %>
                            <option value="<%= exam.getExamId() %>"><%= exam.getExamTitle() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Question Text</label>
                    <textarea name="content" rows="4" class="form-control" required></textarea>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option A</label>
                        <input type="text" name="optionA" class="form-control" required/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option B</label>
                        <input type="text" name="optionB" class="form-control" required/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option C</label>
                        <input type="text" name="optionC" class="form-control" required/>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Option D</label>
                        <input type="text" name="optionD" class="form-control" required/>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Correct Answer</label>
                    <select name="correctAnswer" class="form-select" required>
                        <option value="">-- Select --</option>
                        <option value="A">A</option>
                        <option value="B">B</option>
                        <option value="C">C</option>
                        <option value="D">D</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-success w-100">Add Question</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>