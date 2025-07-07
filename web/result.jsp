<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    double score = (double) request.getAttribute("score");
    int correct = (int) request.getAttribute("correct");
    int total = (int) request.getAttribute("total");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exam Result</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow text-center">
        <div class="card-header bg-success text-white">
            <h3 class="mb-0">🎉 Exam Result</h3>
        </div>
        <div class="card-body">
            <h4 class="mb-3">Correct Answers</h4>
            <p class="fs-4"><strong><%= correct %></strong> out of <strong><%= total %></strong></p>

            <h4 class="mb-3">Score</h4>
            <p class="fs-3 text-primary"><strong><%= String.format("%.2f", score) %>%</strong></p>

            <a href="exam?action=list" class="btn btn-outline-secondary mt-3">⬅ Back to Dashboard</a>
        </div>
    </div>
</div>

</body>
</html>