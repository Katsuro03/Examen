<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pesebre Universitario - Universidad Politécnica Salesiana</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
</head>

<body>
    <header>
        <img src="imagenes/ups.png" alt="Logo Universidad Politécnica Salesiana" class="logo">
        <h1 class="header-title">Pesebre Universitario</h1>
        <h2 class="header-subtitle">Universidad Politécnica Salesiana</h2>
    </header>

    <div class="main-container">
        <!-- MENÚ LATERAL IZQUIERDO -->
        <div class="sidebar">
            <!-- SECCIÓN DE USUARIO -->
            <div class="user-section">
                <%
                    String usuario = (String) session.getAttribute("usuario");
                    if (usuario != null) {
                %>
                    <div class="welcome-msg">👋 Bienvenido, <%= usuario %>!</div>
                    <form action="cerrarSesion.jsp" method="post" style="display:inline;">
                        <button type="submit" class="logout-btn">Cerrar Sesión</button>
                    </form>
                <% } else { %>
                    <a href="login.jsp" class="login-btn">Iniciar Sesión</a>
                <% } %>
            </div>

            <div class="sidebar-section">
    <h4>Navegación</h4>
    <ul class="sidebar-links">
        <li><a href="index.jsp" class="active"><i class="fas fa-home"></i> Inicio</a></li>

        <% 
            if (usuario != null) {  // si el usuario está logueado, mostrar estas opciones
        %>
            <li><a href="juego.jsp"><i class="fas fa-puzzle-piece"></i> Juego</a></li>
            <li><a href="galeria.jsp"><i class="fas fa-users"></i> Personajes</a></li>
            <li><a href="calendario.jsp"><i class="fas fa-calendar-alt"></i> Calendario</a></li>
        <% 
            } 
        %>

        <li><a href="#mapa"><i class="fas fa-map-marker-alt"></i> Ubicación</a></li>
    </ul>
</div>

            <div class="sidebar-section">
                <h4>Universidad</h4>
                <ul class="sidebar-links">
                    <li><a href="https://www.ups.edu.ec" target="_blank"><i class="fas fa-globe"></i> Sitio Web UPS</a></li>
                    <li><a href="https://www.ups.edu.ec/oferta-academica?35610=#" target="_blank"><i class="fas fa-graduation-cap"></i> Carreras</a></li>
                    <li><a href="https://www.ups.edu.ec/noticias-listado?pg=0" target="_blank"><i class="fas fa-newspaper"></i> Noticias UPS</a></li>
                </ul>
            </div>

            <div class="sidebar-section">
                <h4>Redes Sociales</h4>
                <ul class="sidebar-links">
                    <li><a href="https://www.facebook.com/UPSalesianaEc/" target="_blank"><i class="fab fa-facebook"></i> Facebook</a></li>
                    <li><a href="https://x.com/upsalesianaec" target="_blank"><i class="fab fa-twitter"></i> X</a></li>
                    <li><a href="https://www.instagram.com/upsalesianaec/" target="_blank"><i class="fab fa-instagram"></i> Instagram</a></li>
                    <li><a href="https://www.youtube.com/@upsalesianaec" target="_blank"><i class="fab fa-youtube"></i> Youtube</a></li>
                    <li><a href="https://www.linkedin.com/school/universidad-politecnica-salesiana/" target="_blank"><i class="fab fa-linkedin"></i> Linkedin</a></li>
                    <li><a href="https://www.tiktok.com/@upsalesianaec" target="_blank"><i class="fab fa-tiktok"></i> TikTok</a></li>
                </ul>
            </div>
        </div>

        <div class="content">
            <!-- SECCIÓN PRINCIPAL -->
            <section class="main-section">
                <div class="main-text">
                    <h3>Nuestro Pesebre</h3>
                    <p>El pesebre universitario es una tradición que representa el nacimiento de Jesús en el contexto de nuestra comunidad académica, uniendo fe, cultura y educación.</p>
                </div>

                <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                  <div class="carousel-inner">
                    <div class="carousel-item active">
                      <img src="imagenes/pesebre1.png" class="d-block w-100" alt="Pesebre 1">
                    </div>
                    <div class="carousel-item">
                      <img src="imagenes/pesebre2.png" class="d-block w-100" alt="Pesebre 2">
                    </div>
                    <div class="carousel-item">
                      <img src="imagenes/pesebre3.png" class="d-block w-100" alt="Pesebre 3">
                    </div>
                  </div>
                  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Anterior</span>
                  </button>
                  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Siguiente</span>
                  </button>
                </div>
            </section>

            <!-- BANNER MOTIVACIONAL -->
            <section class="banner-frase">
                <h2>"La Navidad no es un momento ni una temporada, sino un estado de la mente"</h2>
            </section>

            <!-- SECCIÓN DE VALORES -->
            <section class="valores">
                <h3>Nuestros Valores</h3>
                <div class="tarjetas-valores">
                    <div class="tarjeta">
                        <h4><i class="fas fa-heart"></i> Solidaridad</h4>
                        <p>Promovemos el espíritu de ayuda mutua y compromiso con los más necesitados, especialmente en esta época navideña.</p>
                    </div>
                    <div class="tarjeta">
                        <h4><i class="fas fa-users"></i> Comunidad</h4>
                        <p>Fomentamos la unión y el trabajo en equipo entre estudiantes, docentes y personal administrativo.</p>
                    </div>
                    <div class="tarjeta">
                        <h4><i class="fas fa-pray"></i> Espiritualidad</h4>
                        <p>Mantenemos viva la tradición del pesebre como expresión de nuestra fe y valores cristianos.</p>
                    </div>
                </div>
            </section>

            <!-- MAPA -->
            <section class="mapa-section" id="mapa">
                <h3>Somos el Campus Quito Sur</h3>
                <div class="mapa-container">
                    <iframe src="https://www.google.com/maps/d/embed?mid=1j5E50-WAbkM8MAO8ml3vywPi0WKjXDw&ehbc=2E312F"></iframe>
                </div>
            </section>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Pesebre Universitario</p>
    </footer>
</body>
</html>