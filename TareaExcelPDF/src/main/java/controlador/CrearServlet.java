package controlador;

import config.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/crear")
public class CrearServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CrearServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CrearServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String cat = request.getParameter("categoria");
        String nom = request.getParameter("nombre");
        double pre = Double.parseDouble(request.getParameter("precio"));
        int sto = Integer.parseInt(request.getParameter("stock"));

        try {
            Connection cn = Conexion.getConexion();
            String sql = "INSERT INTO producto(categoria, nombre, precio, stock) VALUES(?,?,?,?)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, cat);
            ps.setString(2, nom);
            ps.setDouble(3, pre);
            ps.setInt(4, sto);
            ps.executeUpdate();
            response.sendRedirect("gestion.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("gestion.jsp?error=1");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
