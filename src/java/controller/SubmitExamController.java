package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.QuestionDAO;
import model.QuestionDTO;

import java.io.IOException;
import java.util.List;

@WebServlet("/SubmitExamController")
public class SubmitExamController extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int examId = Integer.parseInt(request.getParameter("examId"));
        List<QuestionDTO> questions = questionDAO.getByExamId(examId);

        int total = questions.size();
        int correct = 0;

        for (QuestionDTO q : questions) {
            String userAnswer = request.getParameter("q" + q.getQuestionId());
            if (userAnswer != null && userAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {
                correct++;
            }
        }

        double score = ((double) correct / total) * 100;

        request.setAttribute("score", score);
        request.setAttribute("correct", correct);
        request.setAttribute("total", total);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}