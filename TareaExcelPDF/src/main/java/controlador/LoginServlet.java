package controlador;

import config.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import modelo.Admin;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        String user = request.getParameter("txtuser");
        String pass = request.getParameter("txtpass");
        
        try(Connection cn = Conexion.getConexion()){
            //Buscar usuario existente
            String sql = "SELECT * FROM admin WHERE username =?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                //Verificar contraseña
                if(rs.getString("PASSWORD").equals(pass)){
                    Admin admin = new Admin(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("username"),
                        rs.getString("PASSWORD")
                    );
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("adminLogueado", admin);
                    response.sendRedirect("listar");
                    
                }else{
                    request.setAttribute("error", "Contraseña incorrecta");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
                
            }else{
                request.setAttribute("error", "El nombre de usuario no existe");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
