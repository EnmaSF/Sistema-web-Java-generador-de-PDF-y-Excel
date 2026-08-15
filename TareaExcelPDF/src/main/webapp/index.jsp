<%@page import="java.util.List" %>
<%@page import="modelo.Producto" %>
<%@page import="modelo.Admin" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Admin admin = (Admin) session.getAttribute("adminLogueado");
    if(admin == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css"/>
        <title>Vista de Productos</title>
    </head>
    <body>
        <header class="main-header">
            <div class="logo-section">
                <img src="img/logo.png" alt="Logo" class="logo">
                <h1 class="empresa-nombre">COMPRAMIX</h1>
            </div>
            <div class="user-section">
                <a href="logout" class="btn btn-logout">Cerrar Sesión <i class="fas fa-sign-out-alt"></i></a>
            </div>
        </header>

        <main class="container">
            <section class="welcome-card">
                <p>Bienvenido, <strong><%= admin.getNombre() %></strong></p>
                <p class="rol-text">Rol: Administrador</p>
            </section>

            <section class="actions-bar">
                <a href="gestion.jsp" class="btn btn-primary"><i class="fas fa-tasks"></i> Gestionar Productos</a>
                <a href="pdf" class="btn btn-pdf"><i class="fas fa-file-pdf"></i> Generar Reporte PDF</a>
                <a href="excel" class="btn btn-excel"><i class="fas fa-file-excel"></i> Generar Excel</a>
            </section>

            <section class="listado-section">
                <h2>Listado de Productos</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Categoría</th>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Producto> lista = (List<Producto>) request.getAttribute("datos");
                            if (lista != null) {
                                for (Producto p : lista) {
                        %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getCategoria() %></td>
                            <td><%= p.getNombre() %></td>
                            <td>S/. <%= String.format("%.2f", p.getPrecio()) %></td>
                            <td><%= p.getStock() %> unidades</td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        
                        <% } %>
                    </tbody>
                </table>
            </section>
        </main>

        <footer class="main-footer">
            <p>&copy; 2026 COMPRAMIX - Todos los derechos reservados</p>
        </footer>
    </body>
</html>
