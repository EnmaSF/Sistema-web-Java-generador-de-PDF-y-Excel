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
import java.sql.ResultSet;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet("/excel")
public class ExcelServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExcelServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExcelServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Workbook wb = new XSSFWorkbook();
        Sheet hoja = wb.createSheet("Reporte de productos");
        
        Row cabecera = hoja.createRow(0);
        cabecera.createCell(0).setCellValue("Id");
        cabecera.createCell(1).setCellValue("Categoria");
        cabecera.createCell(2).setCellValue("Nombre");
        cabecera.createCell(3).setCellValue("Precio");
        cabecera.createCell(4).setCellValue("Stock");
        
        try{
            Connection cn = Conexion.getConexion();
            PreparedStatement ps = cn.prepareStatement("SELECT * FROM producto");
            ResultSet rs = ps.executeQuery();
            
            int fila = 1;
            
            while(rs.next()){
                Row row = hoja.createRow(fila++);
                
                row.createCell(0).setCellValue(rs.getInt("id"));
                row.createCell(1).setCellValue(rs.getString("categoria"));
                row.createCell(2).setCellValue(rs.getString("nombre"));
                row.createCell(3).setCellValue(rs.getDouble("precio"));
                row.createCell(4).setCellValue(rs.getInt("stock"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        response.setContentType(
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        
        response.setHeader(
                "Content-Disposition",
                "attachment; filename=producto.xlsx");
        
        wb.write(response.getOutputStream());
        wb.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
