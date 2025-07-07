package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "MainController", urlPatterns = {"/MainController", "/", ""})
public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";

    private boolean isUserAction(String action) {
        return action != null && action.equals("login");
    }

    private boolean isExamAction(String action) {
        return action != null && (
            action.equals("list") || 
            action.equals("edit") || 
            action.equals("delete") || 
            action.equals("create")
        );
    }

    private boolean isQuestionAction(String action) {
        return action != null && action.equals("addQuestion");
    }

    private boolean isCategoryAction(String action) {
        return action != null && action.equals("viewCategories");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = LOGIN_PAGE;

        try {
            if (action == null || action.trim().isEmpty()) {
                url = LOGIN_PAGE;

            } else if (isUserAction(action)) {
                url = "UserController";
            } else if (isExamAction(action)) {
                url = "ExamController";
            } else if (isQuestionAction(action)) {
                url = "QuestionController";
            } else if (isCategoryAction(action)) {
                url = "CategoryController";
            } else {
                request.setAttribute("message", "Unknown action: " + action);
                url = LOGIN_PAGE;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "MainController Error: " + e.getMessage());
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
