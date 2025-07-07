package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.ExamCategoriesDAO;
import model.ExamCategoriesDTO;
import model.ExamDAO;
import model.ExamDTO;
import model.QuestionDAO;
import model.QuestionDTO;

@WebServlet("/exam")
public class ExamController extends HttpServlet {

    private final ExamDAO examDAO = new ExamDAO();
    private final ExamCategoriesDAO catDao = new ExamCategoriesDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    loadCategories(request);
                    List<ExamDTO> exams = examDAO.getAll();
                    request.setAttribute("examList", exams);
                    request.getRequestDispatcher("welcome.jsp").forward(request, response);
                    break;

                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    ExamDTO exam = examDAO.getExamById(editId);
                    loadCategories(request);
                    request.setAttribute("exam", exam);
                    request.getRequestDispatcher("editExam.jsp").forward(request, response);
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    examDAO.delete(deleteId);
                    response.sendRedirect("exam?action=list");
                    break;

                case "create":
                    loadCategories(request);
                    request.getRequestDispatcher("examForm.jsp").forward(request, response);
                    break;

                case "filterByCategory":
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    List<ExamDTO> filteredExams = examDAO.getByCategoryId(categoryId);
                    loadCategories(request);
                    request.setAttribute("examList", filteredExams);
                    request.getRequestDispatcher("welcome.jsp").forward(request, response);
                    break;

                case "take":
                    int examId = Integer.parseInt(request.getParameter("id"));
                    ExamDTO selectedExam = examDAO.getExamById(examId);
                    List<QuestionDTO> questions = questionDAO.getByExamId(examId);
                    request.setAttribute("exam", selectedExam);
                    request.setAttribute("questions", questions);
                    request.getRequestDispatcher("takeExam.jsp").forward(request, response);
                    break;

                default:
                    loadCategories(request);
                    request.setAttribute("message", "Unknown action: " + action);
                    request.getRequestDispatcher("welcome.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("welcome.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            String examTitle = request.getParameter("examTitle");
            String subject = request.getParameter("subject");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));
            int duration = Integer.parseInt(request.getParameter("duration"));
            System.out.println("Creating exam with categoryId = " + categoryId);
            System.out.println("Raw categoryId = " + request.getParameter("categoryId"));
request.getParameterMap().forEach((key, value) -> 
    System.out.println(key + " = " + java.util.Arrays.toString(value))
);
            System.out.println("Parsed categoryId = " + categoryId);
            if (request.getParameter("update") != null) {
                int examId = Integer.parseInt(request.getParameter("examId"));
                ExamDTO exam = new ExamDTO(examId, examTitle, subject, categoryId, totalMarks, duration);
                examDAO.update(exam);
            } else {
                ExamDTO exam = new ExamDTO(0, examTitle, subject, categoryId, totalMarks, duration);
                examDAO.create(exam);
            }

            response.sendRedirect("exam?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error processing form: " + e.getMessage());
            loadCategories(request);
            request.getRequestDispatcher("examForm.jsp").forward(request, response);
        }
    }

    private void loadCategories(HttpServletRequest request) {
        List<ExamCategoriesDTO> categoryList = catDao.getAllCategories();
        request.setAttribute("categoryList", categoryList);
    }
}
