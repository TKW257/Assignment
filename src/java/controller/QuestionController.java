package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ExamDAO;
import model.ExamDTO;
import model.QuestionDAO;
import model.QuestionDTO;

@WebServlet("/question")
public class QuestionController extends HttpServlet {
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final ExamDAO examDAO = new ExamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendRedirect("exam?action=list");
            return;
        }

        if ("add".equalsIgnoreCase(action)) {
            try {
                List<ExamDTO> examList = examDAO.getAll();
                request.setAttribute("examList", examList);
                request.getRequestDispatcher("addQuestion.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Error loading exams: " + e.getMessage());
                request.getRequestDispatcher("welcome.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("exam?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int examId = Integer.parseInt(request.getParameter("examId"));
            String content = request.getParameter("content");
            String optionA = request.getParameter("optionA");
            String optionB = request.getParameter("optionB");
            String optionC = request.getParameter("optionC");
            String optionD = request.getParameter("optionD");
            String correctAnswer = request.getParameter("correctAnswer");

            QuestionDTO question = new QuestionDTO(0, examId, content, optionA, optionB, optionC, optionD, correctAnswer);
            questionDAO.create(question);

            response.sendRedirect("exam?action=list");
        } catch (Exception e) {
            Logger.getLogger(QuestionController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("message", "Error adding question: " + e.getMessage());
            doGet(request, response); // Quay lại form nếu lỗi
        }
    }
}