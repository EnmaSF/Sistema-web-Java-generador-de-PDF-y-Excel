<%@page import="java.sql.*"%>
<%@page import="config.Conexion"%>
<%@page import="modelo.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificación de sesión
    HttpSession sesion = request.getSession();
    Admin admin = (Admin) sesion.getAttribute("adminLogueado");
    if(admin == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Productos - SUAREZ TECH</title>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    
    <header class="main-header">
        <div class="header-left">
            <img src="img/logo.png" alt="Logo" class="logo">
            <span class="company-name">COMPRAMIX</span>
        </div>
        
        <div class="header-right">
            <a href="logout" class="btn-logout">Cerrar sesión</a>
        </div>
    </header>
    
    <main class="container">
        <h3>Bienvenido: <%= admin.getNombre() %></h3>
        
        <div class="section-title">
            <h2>Gestión de productos</h2>
            <div>
                <button onclick="abrirModalCrear()" class="btn-save">
                    Registrar Producto
                </button>
                <a href="listar" class="btn-back" style="text-decoration:none; background-color: #6c757d;">Volver</a>
            </div>
        </div>
        
        <table class="table-clientes">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Categoría</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            
            <tbody>
                <% 
                    try {
                        Connection cn = Conexion.getConexion();
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM producto");
                        while(rs.next()){
                %>    
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("categoria") %></td>
                    <td><%= rs.getString("nombre") %></td>
                    <td>S/. <%= String.format("%.2f", rs.getDouble("precio")) %></td>
                    <td><%= rs.getInt("stock") %></td>
                    <td>
                        <button onclick="abrirModalEditar('<%= rs.getInt("id") %>', '<%= rs.getDouble("precio") %>', '<%= rs.getInt("stock") %>')"
                                class="btn-edit">
                            Editar
                        </button>
                                    
                        <a href="eliminar?id=<%= rs.getInt("id") %>"
                           class="btn-delete" 
                           onclick="return confirm('¿Está seguro de eliminar este producto?')">
                            Eliminar
                        </a>
                    </td>
                </tr>
                <% 
                        }
                        cn.close();
                    } catch(Exception e) {
                        out.print("<tr><td colspan='6'>Error al cargar datos: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </main>

    <div id="modalCrear" class="modal-overlay" style="display:none;">
        <div class="modal-window">
            <div class="modal-header">
                <h4>Registrar Nuevo Producto</h4>
                <button type="button" class="btn-close-x" onclick="cerrarModal('modalCrear')">&times;</button>
            </div>
            <div class="modal-body">
                <form action="crear" method="POST">
                    <div class="form-group">
                        <label>Categoría:</label>
                        <input type="text" name="categoria" required class="input-modal">
                    </div>
                    <div class="form-group">
                        <label>Nombre:</label>
                        <input type="text" name="nombre" required class="input-modal">
                    </div>
                    <div class="form-group">
                        <label>Precio:</label>
                        <input type="number" step="0.01" name="precio" required class="input-modal">
                    </div>
                    <div class="form-group">
                        <label>Stock:</label>
                        <input type="number" name="stock" required class="input-modal">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-cancel" onclick="cerrarModal('modalCrear')">Cancelar</button>
                        <button type="submit" class="btn-save">Guardar Producto</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="modalEdit" class="modal-overlay" style="display:none;">
        <div class="modal-window">
            <div class="modal-header">
                <h4>Modificar Producto</h4>
                <button type="button" class="btn-close-x" onclick="cerrarModal('modalEdit')">&times;</button>
            </div>
            
            <div class="modal-body">
                <form action="editar" method="POST">
                    <input type="hidden" name="id" id="edit_id">
                    
                    <div class="form-group">
                        <label for="edit_precio">Nuevo precio:</label>
                        <input type="number" step="0.01" name="precio" id="edit_precio" 
                               required class="input-modal">
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_stock">Nuevo stock:</label>
                        <input type="number" name="stock" id="edit_stock" 
                               required class="input-modal">
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn-cancel" onclick="cerrarModal('modalEdit')">Cancelar</button>
                        <button type="submit" class="btn-save">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2026 COMPRAMIX - Todos los derechos reservados</p>
    </footer>

    <script>
        function abrirModalCrear() {
            document.getElementById("modalCrear").style.display = 'flex';
        }

        function abrirModalEditar(id, precio, stock) {
            document.getElementById("edit_id").value = id;
            document.getElementById("edit_precio").value = precio;
            document.getElementById("edit_stock").value = stock;
            document.getElementById("modalEdit").style.display = 'flex';
        }

        function cerrarModal(id) {
            document.getElementById(id).style.display = 'none';
        }

        // Cerrar al hacer clic fuera del modal
        window.onclick = function(event) {
            const modalEdit = document.getElementById('modalEdit');
            const modalCrear = document.getElementById('modalCrear');
            if (event.target === modalEdit) cerrarModal('modalEdit');
            if (event.target === modalCrear) cerrarModal('modalCrear');
        };
    </script>
</body>
</html>