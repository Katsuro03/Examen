<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Juego del Pesebre - Universidad Politécnica Salesiana</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
    
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }
        
        .trivia-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            overflow: hidden;
            margin: 20px auto;
            max-width: 900px;
        }
        
        .header-section {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            color: #1e3c72;
            padding: 30px;
            text-align: center;
        }
        
        .pregunta-section {
            padding: 40px;
            background: #f8f9fa;
        }
        
        .opciones-container {
            display: grid;
            gap: 15px;
            margin: 30px 0;
        }
        
        .opcion-btn {
            padding: 20px;
            border: 3px solid #e9ecef;
            border-radius: 15px;
            background: white;
            text-align: left;
            font-size: 1.1em;
            transition: all 0.3s ease;
            cursor: pointer;
            width: 100%;
        }
        
        .opcion-btn:hover {
            border-color: #007bff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,123,255,0.2);
        }
        
        .opcion-btn.correcta {
            border-color: #28a745;
            background: #d4edda;
            color: #155724;
        }
        
        .opcion-btn.incorrecta {
            border-color: #dc3545;
            background: #f8d7da;
            color: #721c24;
        }
        
        .progreso-bar {
            height: 10px;
            background: #e9ecef;
            border-radius: 5px;
            overflow: hidden;
            margin: 20px 0;
        }
        
        .progreso-fill {
            height: 100%;
            background: linear-gradient(45deg, #28a745, #20c997);
            width: 0%;
            transition: width 0.5s ease;
        }
        
        .puntuacion-display {
            font-size: 1.5em;
            font-weight: bold;
            color: #d4af37;
            text-align: center;
            margin: 20px 0;
        }
        
        .pesebre-imagen {
            max-width: 300px;
            margin: 0 auto;
            display: block;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .btn-custom {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            border: none;
            color: #1e3c72;
            font-weight: bold;
            padding: 15px 30px;
            border-radius: 25px;
            font-size: 1.1em;
            transition: all 0.3s ease;
        }
        
        .btn-custom:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }
        
        .feedback {
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            text-align: center;
            font-weight: bold;
            display: none;
        }
        
        .feedback.correcto {
            background: #d4edda;
            color: #155724;
            border: 2px solid #28a745;
        }
        
        .feedback.incorrecto {
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #dc3545;
        }
        
        .numero-pregunta {
            background: #d4af37;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin: 0 auto 20px;
        }

        .imagen-placeholder {
            width: 300px;
            height: 200px;
            background: linear-gradient(45deg, #d4af37, #ffd700);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1e3c72;
            font-weight: bold;
            margin: 0 auto;
            font-size: 1.2em;
        }
        
        .content {
            padding: 20px;
            text-align: center;
        }
        
        .nav-buttons {
            margin: 20px 0;
        }
        
        .nav-buttons a {
            margin: 0 10px;
            text-decoration: none;
        }
    </style>
</head>

<body>
<%@ page import="seguridad.Usuario" %>
<%
    // Verificar si hay usuario en sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario_obj");
    
    // Si no hay usuario, redirigir al login
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Verificar acceso según el perfil
    String paginaActual = request.getServletPath().replace(".jsp", "").replace("/", "");
    
    // Definir qué páginas pueden acceder cada perfil
    boolean tieneAcceso = false;
    
    switch(usuario.getPerfil()) {
        case 1: // Admin - acceso a todo
            tieneAcceso = true;
            break;
            
        case 2: // Alumno - acceso a juego, galeria, calendario
        case 3: // Invitado - acceso a juego, galeria, calendario
            if (paginaActual.equals("juego") || 
                paginaActual.equals("galeria") || 
                paginaActual.equals("calendario") ||
                paginaActual.equals("index")) {
                tieneAcceso = true;
            }
            break;
    }
    
    if (!tieneAcceso) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
    <!-- HEADER IDÉNTICO AL INDEX -->
    <header>
        <img src="imagenes/ups.png" alt="Logo Universidad Politécnica Salesiana" class="logo">
        <h1 class="header-title">Pesebre Universitario</h1>
        <h2 class="header-subtitle">Universidad Politécnica Salesiana</h2>
    </header>
    <!-- CONTENIDO PRINCIPAL DEL JUEGO -->
    <div class="content">
        <div class="trivia-container">
            <!-- Header del Juego -->
            <div class="header-section">
                <h1 class="display-4 fw-bold">🎄 Trivia del Pesebre</h1>
                <p class="lead">Pon a prueba tu conocimiento sobre la Navidad</p>
            </div>
            
            <!-- Pantalla de Inicio -->
            <div id="pantalla-inicio" class="pregunta-section text-center">
                <img src="imagenes/pesebre.png" alt="Pesebre" class="pesebre-imagen mb-4" onerror="this.style.display='none'; document.getElementById('placeholder-inicio').style.display='flex';">
                <div id="placeholder-inicio" class="imagen-placeholder" style="display: none;">
                    🎄 Pregunta del Pesebre 🎄
                </div>
                <h3>¡Bienvenido al Juego del Pesebre!</h3>
                <p>Responde correctamente las preguntas sobre el nacimiento de Jesús y construye tu pesebre virtual.</p>
                <button id="btn-empezar" class="btn btn-custom mt-3">Comenzar Juego</button>
            </div>
            
            <!-- Pantalla de Juego -->
            <div id="pantalla-juego" class="pregunta-section" style="display: none;">
                <div class="numero-pregunta">
                    <span id="numero-actual">1</span>/<span id="total-preguntas">8</span>
                </div>
                
                <div class="progreso-bar">
                    <div id="progreso-fill" class="progreso-fill"></div>
                </div>
                
                <h3 id="texto-pregunta" class="text-center mb-4">¿Quiénes fueron los primeros en visitar a Jesús?</h3>
                
                <!-- Imagen de la pregunta con placeholder -->
                <img id="imagen-pregunta" src="" alt="Pregunta" class="pesebre-imagen mb-4" onerror="this.style.display='none'; document.getElementById('placeholder-pregunta').style.display='flex';">
                <div id="placeholder-pregunta" class="imagen-placeholder">
                    🎄 Pregunta del Pesebre 🎄
                </div>
                
                <div class="opciones-container" id="opciones-container">
                    <!-- Las opciones se generan dinámicamente -->
                </div>
                
                <div id="feedback" class="feedback"></div>
                
                <div class="text-center">
                    <button id="btn-siguiente" class="btn btn-custom" style="display: none;">Siguiente Pregunta</button>
                </div>
            </div>
            
            <!-- Pantalla de Resultados -->
            <div id="pantalla-resultados" class="pregunta-section text-center" style="display: none;">
                <h2>🎉 ¡Felicidades! 🎉</h2>
                <div class="puntuacion-display">
                    Puntuación Final: <span id="puntuacion-final">0</span>/80
                </div>
                
                <img src="imagenes/pesebre.png" alt="Pesebre Completo" class="pesebre-imagen mb-4" onerror="this.style.display='none'; document.getElementById('placeholder-final').style.display='flex';">
                <div id="placeholder-final" class="imagen-placeholder" style="display: none;">
                    🎄 ¡Pesebre Completo! 🎄
                </div>
                
                <div id="mensaje-resultado" class="mb-4">
                    <p>¡Excelente trabajo! Has demostrado un gran conocimiento sobre el pesebre.</p>
                </div>
                
                <div class="d-flex justify-content-center gap-3">
                    <button id="btn-reiniciar" class="btn btn-custom">Jugar de Nuevo</button>
                    <a href="index.jsp" class="btn btn-outline-primary">Volver al Inicio</a>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER IDÉNTICO AL INDEX -->
    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Pesebre Universitario</p>
    </footer>

    <script>
        // Base de datos de preguntas - USANDO LA MISMA IMAGEN PARA TODAS
        const preguntas = [
            {
                pregunta: "¿Quiénes fueron los primeros en visitar a Jesús según la Biblia?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "Los Reyes Magos",
                    "Los Pastores", 
                    "Los Ángeles",
                    "Los Sacerdotes"
                ],
                correcta: 1
            },
            {
                pregunta: "¿En qué ciudad nació Jesús?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "Jerusalén",
                    "Belén",
                    "Nazaret",
                    "Galilea"
                ],
                correcta: 1
            },
            {
                pregunta: "¿Cuántos Reyes Magos visitaron a Jesús?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "2",
                    "3", 
                    "4",
                    "La Biblia no especifica"
                ],
                correcta: 3
            },
            {
                pregunta: "¿Qué animal NO se menciona tradicionalmente en el pesebre?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "Buey",
                    "Burro",
                    "Oveja", 
                    "Camello"
                ],
                correcta: 3
            },
            {
                pregunta: "¿Cómo se llamaba el esposo de María?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "José",
                    "Juan",
                    "Jacob",
                    "Judas"
                ],
                correcta: 0
            },
            {
                pregunta: "¿Qué llevaron los Reyes Magos como regalos?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "Oro, incienso y mirra",
                    "Joyas, perfumes y telas",
                    "Frutas, pan y vino",
                    "Monedas, especias y aceites"
                ],
                correcta: 0
            },
            {
                pregunta: "¿Dónde fue colocado Jesús al nacer?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "En una cuna de madera",
                    "En un pesebre",
                    "En los brazos de María",
                    "En una canasta"
                ],
                correcta: 1
            },
            {
                pregunta: "¿Qué anunció el ángel a los pastores?",
                imagen: "imagenes/pesebre.png",
                opciones: [
                    "El nacimiento del Salvador",
                    "La llegada de los Reyes", 
                    "Un eclipse lunar",
                    "Una gran fiesta"
                ],
                correcta: 0
            }
        ];

        // Variables del juego
        let preguntaActual = 0;
        let puntuacion = 0;
        let juegoTerminado = false;

        // Elementos DOM
        const pantallaInicio = document.getElementById('pantalla-inicio');
        const pantallaJuego = document.getElementById('pantalla-juego');
        const pantallaResultados = document.getElementById('pantalla-resultados');
        const textoPregunta = document.getElementById('texto-pregunta');
        const imagenPregunta = document.getElementById('imagen-pregunta');
        const placeholderPregunta = document.getElementById('placeholder-pregunta');
        const opcionesContainer = document.getElementById('opciones-container');
        const btnSiguiente = document.getElementById('btn-siguiente');
        const feedback = document.getElementById('feedback');
        const progresoFill = document.getElementById('progreso-fill');
        const numeroActual = document.getElementById('numero-actual');
        const totalPreguntas = document.getElementById('total-preguntas');
        const puntuacionFinal = document.getElementById('puntuacion-final');
        const mensajeResultado = document.getElementById('mensaje-resultado');

        // Inicializar juego
        function inicializarJuego() {
            totalPreguntas.textContent = preguntas.length;
            actualizarProgreso();
        }

        // Mostrar pregunta actual
        function mostrarPregunta() {
            const pregunta = preguntas[preguntaActual];
            textoPregunta.textContent = pregunta.pregunta;
            
            // Configurar imagen
            imagenPregunta.src = pregunta.imagen;
            imagenPregunta.alt = `Pregunta ${preguntaActual + 1}`;
            
            // Mostrar imagen y ocultar placeholder
            imagenPregunta.style.display = 'block';
            placeholderPregunta.style.display = 'none';
            
            // Verificar si la imagen carga
            imagenPregunta.onload = function() {
                imagenPregunta.style.display = 'block';
                placeholderPregunta.style.display = 'none';
            };
            
            imagenPregunta.onerror = function() {
                imagenPregunta.style.display = 'none';
                placeholderPregunta.style.display = 'flex';
            };
            
            numeroActual.textContent = preguntaActual + 1;
            
            // Generar opciones
            opcionesContainer.innerHTML = '';
            pregunta.opciones.forEach((opcion, index) => {
                const boton = document.createElement('button');
                boton.className = 'opcion-btn';
                boton.textContent = opcion;
                boton.onclick = () => seleccionarOpcion(index);
                opcionesContainer.appendChild(boton);
            });
            
            // Resetear estado
            btnSiguiente.style.display = 'none';
            feedback.style.display = 'none';
        }

        // Seleccionar opción
        function seleccionarOpcion(indice) {
            if (juegoTerminado) return;
            
            const pregunta = preguntas[preguntaActual];
            const botones = document.querySelectorAll('.opcion-btn');
            
            // Deshabilitar todos los botones
            botones.forEach(boton => {
                boton.style.pointerEvents = 'none';
            });
            
            // Mostrar resultado
            if (indice === pregunta.correcta) {
                botones[indice].classList.add('correcta');
                feedback.textContent = '¡Correcto! +10 puntos';
                feedback.className = 'feedback correcto';
                puntuacion += 10;
            } else {
                botones[indice].classList.add('incorrecta');
                botones[pregunta.correcta].classList.add('correcta');
                feedback.textContent = `Incorrecto. La respuesta correcta es: ${pregunta.opciones[pregunta.correcta]}`;
                feedback.className = 'feedback incorrecto';
            }
            
            feedback.style.display = 'block';
            btnSiguiente.style.display = 'inline-block';
        }

        // Siguiente pregunta
        function siguientePregunta() {
            preguntaActual++;
            
            if (preguntaActual < preguntas.length) {
                mostrarPregunta();
                actualizarProgreso();
            } else {
                terminarJuego();
            }
        }

        // Actualizar barra de progreso
        function actualizarProgreso() {
            const porcentaje = ((preguntaActual) / preguntas.length) * 100;
            progresoFill.style.width = `${porcentaje}%`;
        }

        // Terminar juego
        function terminarJuego() {
            juegoTerminado = true;
            pantallaJuego.style.display = 'none';
            pantallaResultados.style.display = 'block';
            
            puntuacionFinal.textContent = puntuacion;
            
            // Mensaje personalizado según puntuación
            let mensaje = '';
            if (puntuacion >= 70) {
                mensaje = '¡Excelente! Eres un experto en el pesebre. 🎓';
            } else if (puntuacion >= 50) {
                mensaje = '¡Muy bien! Tienes buen conocimiento navideño. 👍';
            } else {
                mensaje = '¡Buen intento! Sigue aprendiendo sobre la Navidad. 📚';
            }
            
            mensajeResultado.innerHTML = `<p>${mensaje}</p>`;
        }

        // Reiniciar juego
        function reiniciarJuego() {
            preguntaActual = 0;
            puntuacion = 0;
            juegoTerminado = false;
            
            pantallaResultados.style.display = 'none';
            pantallaJuego.style.display = 'block';
            
            mostrarPregunta();
            actualizarProgreso();
        }

        // Event Listeners
        document.getElementById('btn-empezar').addEventListener('click', function() {
            pantallaInicio.style.display = 'none';
            pantallaJuego.style.display = 'block';
            mostrarPregunta();
        });

        document.getElementById('btn-siguiente').addEventListener('click', siguientePregunta);
        document.getElementById('btn-reiniciar').addEventListener('click', reiniciarJuego);

        // Inicializar
        inicializarJuego();
    </script>
</body>
</html>