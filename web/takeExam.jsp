<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ExamDTO, model.QuestionDTO, java.util.List" %>

<%
    ExamDTO exam = (ExamDTO) request.getAttribute("exam");
    List<QuestionDTO> questions = (List<QuestionDTO>) request.getAttribute("questions");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Take Exam</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">📝 Exam: <%= exam.getExamTitle() %></h3>
        </div>
        <div class="card-body">

        <% if (questions != null && !questions.isEmpty()) { %>
            <form action="SubmitExamController" method="post">
                <input type="hidden" name="examId" value="<%= exam.getExamId() %>"/>
                <% int index = 1;
                   for (QuestionDTO q : questions) { %>
                    <div class="mb-4">
                        <p><strong>Question <%= index++ %>:</strong> <%= q.getContent() %></p>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="q<%= q.getQuestionId() %>" value="A" id="q<%= q.getQuestionId() %>A">
                            <label class="form-check-label" for="q<%= q.getQuestionId() %>A"><%= q.getOptionA() %></label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="q<%= q.getQuestionId() %>" value="B" id="q<%= q.getQuestionId() %>B">
                            <label class="form-check-label" for="q<%= q.getQuestionId() %>B"><%= q.getOptionB() %></label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="q<%= q.getQuestionId() %>" value="C" id="q<%= q.getQuestionId() %>C">
                            <label class="form-check-label" for="q<%= q.getQuestionId() %>C"><%= q.getOptionC() %></label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="q<%= q.getQuestionId() %>" value="D" id="q<%= q.getQuestionId() %>D">
                            <label class="form-check-label" for="q<%= q.getQuestionId() %>D"><%= q.getOptionD() %></label>
                        </div>
                    </div>
                <% } %>
                <button type="submit" class="btn btn-success">Submit Exam</button>
            </form>
        <% } else { %>
            <div class="alert alert-warning" role="alert">
                No questions available for this exam.
            </div>
        <% } %>

        </div>
    </div>
</div>

</body>
</html>