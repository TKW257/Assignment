package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.UsersDAO;
import model.UsersDTO;
import model.ExamDAO;
import model.ExamDTO;
import model.ExamCategoriesDAO;
import model.ExamCategoriesDTO;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private static final String WELCOME_PAGE = "welcome.jsp";
    private static final String LOGIN_PAGE = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            if ("login".equalsIgnoreCase(action)) {
                url = handleLogin(request, response);
            } else if ("logout".equalsIgnoreCase(action)) {
                url = handleLogout(request, response);
            } else {
                request.setAttribute("message", "Invalid action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Internal error: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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

    @Override
    public String getServletInfo() {
        return "User login/logout controller";
    }

    private String handleLogin(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
        String url = LOGIN_PAGE;
        HttpSession session = request.getSession();
        String username = request.getParameter("strUsername");
        String password = request.getParameter("strPassword");

        UsersDAO userDAO = new UsersDAO();
        UsersDTO user = userDAO.login(username, password);

        if (user != null) {
            session.setAttribute("user", user);

            // Load exam categories and exams for welcome.jsp
            ExamCategoriesDAO catDao = new ExamCategoriesDAO();
            List<ExamCategoriesDTO> categoryList = catDao.getAllCategories();
            request.setAttribute("categoryList", categoryList);

            ExamDAO examDAO = new ExamDAO();
            List<ExamDTO> examList = examDAO.getAll();
            request.setAttribute("examList", examList);

            url = WELCOME_PAGE;
        } else {
            request.setAttribute("message", "Username or password incorrect!");
        }

        return url;
    }

    private String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return LOGIN_PAGE;
    }
}