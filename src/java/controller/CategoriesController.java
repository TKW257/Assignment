package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.ExamCategoriesDAO;
import model.ExamCategoriesDTO;

@WebServlet("/category")
public class CategoriesController extends HttpServlet {
    private ExamCategoriesDAO dao = new ExamCategoriesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ExamCategoriesDTO> list = dao.getAllCategories();
        request.setAttribute("categoryList", list);
        request.getRequestDispatcher("categories.jsp").forward(request, response);
    }
}
