<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  
  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title><xsl:value-of select="//metadata/titulo"/></title>
        <style>
          /* Estilos integrados (sin archivos externos) */
          * { box-sizing: border-box; margin: 0; padding: 0; }
          :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --success: #27ae60;
            --light: #ecf0f1;
            --dark: #34495e;
          }
          body {
            font-family: 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
          }
          
          /* Encabezado y navegación */
          header {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
          }
          .logo-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 30px;
            max-width: 1200px;
            margin: 0 auto;
          }
          .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--primary);
          }
          .logo span { color: var(--secondary); }
          
          nav ul {
            list-style: none;
            display: flex;
            gap: 10px;
          }
          nav a {
            text-decoration: none;
            padding: 10px 16px;
            border-radius: 6px;
            font-weight: bold;
            transition: all 0.3s;
          }
          nav a:link, nav a:visited {
            color: var(--dark);
            background: #f1f3f5;
          }
          nav a:hover {
            background: var(--secondary);
            color: white;
          }
          nav a.activo {
            background: var(--primary) !important;
            color: white !important;
          }
          
          /* Contenido principal */
          main {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
          }
          
          /* Sección hero */
          #hero {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(120deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 12px;
            margin-bottom: 40px;
          }
          #hero h1 {
            font-size: 3rem;
            margin-bottom: 15px;
          }
          #hero h2 {
            font-size: 1.5rem;
            font-weight: normal;
            margin-bottom: 25px;
            opacity: 0.9;
          }
          #hero p {
            max-width: 700px;
            margin: 0 auto 30px;
            font-size: 1.2rem;
            opacity: 0.95;
          }
          
          .botones {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
          }
          .btn {
            display: inline-block;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
            transition: transform 0.2s, box-shadow 0.2s;
          }
          .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
          }
          .btn-primario {
            background: white;
            color: var(--primary);
            border: 2px solid white;
          }
          .btn-secundario {
            background: transparent;
            color: white;
            border: 2px solid white;
          }
          
          /* Sección cómo funciona */
          #como-funciona {
            margin-bottom: 50px;
          }
          .pasos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 30px;
          }
          .paso {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-align: center;
            transition: transform 0.3s;
          }
          .paso:hover {
            transform: translateY(-5px);
          }
          .numero {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: var(--secondary);
            color: white;
            border-radius: 50%;
            line-height: 40px;
            font-weight: bold;
            margin-bottom: 15px;
          }
          .paso h3 { margin: 15px 0 10px; color: var(--primary); }
          
          /* Estadísticas */
          #estadisticas {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
          }
          .stats {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-top: 30px;
          }
          .stat {
            text-align: center;
          }
          .valor {
            font-size: 2.5rem;
            font-weight: bold;
            color: var(--secondary);
            margin-bottom: 5px;
          }
          .etiqueta {
            color: #6c757d;
            font-size: 1.1rem;
          }
          
          /* Pie de página */
          footer {
            background: var(--dark);
            color: white;
            text-align: center;
            padding: 25px;
            margin-top: 60px;
          }
          footer p {
            margin: 5px 0;
            opacity: 0.8;
          }
          
          /* Responsive */
          @media (max-width: 768px) {
            .logo-bar { flex-direction: column; gap: 15px; }
            nav ul { flex-wrap: wrap; justify-content: center; }
            #hero h1 { font-size: 2.2rem; }
            #hero h2 { font-size: 1.2rem; }
            .botones { flex-direction: column; align-items: center; }
          }
        </style>
      </head>
      
      <body>
        <!-- Encabezado con logo y navegación -->
        <header>
          <div class="logo-bar">
            <div class="logo">Adop<span>Tados</span></div>
            <nav>
              <ul>
                <li><a href="index.xml" class="{if (//metadata/pagina = 'inicio') then 'activo' else ''}">🏠 Inicio</a></li>
                <li><a href="parejas.xml" class="{if (//metadata/pagina = 'parejas') then 'activo' else ''}">👥 Parejas</a></li>
                <li><a href="animales.xml" class="{if (//metadata/pagina = 'animales') then 'activo' else ''}">🐾 Animales</a></li>
                <li><a href="adopciones.xml" class="{if (//metadata/pagina = 'adopciones') then 'activo' else ''}">❤️ Adopciones</a></li>
                <li><a href="contacto.xml" class="{if (//metadata/pagina = 'contacto') then 'activo' else ''}">📧 Contacto</a></li>
              </ul>
            </nav>
          </div>
        </header>

        <!-- Contenido principal -->
        <main>
          <xsl:choose>
            <!-- 🏠 Inicio -->
            <xsl:when test="//metadata/pagina = 'inicio'">
              <section id="hero">
                <h1><xsl:value-of select="//metadata/tituloSeccion"/></h1>
                <h2>Porque el amor se multiplica… ¡y también la responsabilidad!</h2>
                <p>Bienvenido al portal donde las parejas pueden adoptar animales de forma responsable y comprometida.</p>
                <div class="botones">
                  <a href="animales.xml" class="btn btn-primario">Ver Animales Disponibles</a>
                </div>
              </section>
              
              <section id="como-funciona">
                <h2>¿Cómo funciona?</h2>
                <div class="pasos">
                  <div class="paso">
                    <div class="numero">1</div>
                    <h3>Registro</h3>
                    <p>Dos personas se registran como pareja adoptante.</p>
                  </div>
                  <div class="paso">
                    <div class="numero">2</div>
                    <h3>Selección</h3>
                    <p>Exploran y eligen un animal disponible.</p>
                  </div>
                  <div class="paso">
                    <div class="numero">3</div>
                    <h3>Adopción</h3>
                    <p>Formalizan la adopción conjunta.</p>
                  </div>
                  <div class="paso">
                    <div class="numero">4</div>
                    <h3>Seguimiento</h3>
                    <p>Reciben apoyo post-adopción.</p>
                  </div>
                </div>
              </section>
              
              <section id="estadisticas">
                <h2>📊 Estadísticas</h2>
                <div class="stats">
                  <div class="stat">
                    <div class="valor">24</div>
                    <div class="etiqueta">Parejas registradas</div>
                  </div>
                  <div class="stat">
                    <div class="valor">37</div>
                    <div class="etiqueta">Animales adoptados</div>
                  </div>
                  <div class="stat">
                    <div class="valor">12</div>
                    <div class="etiqueta">Adopciones este año</div>
                  </div>
                </div>
              </section>
            </xsl:when>
            
            <!-- 👥 Parejas -->
            <xsl:when test="//metadata/pagina = 'parejas'">
              <h1><xsl:value-of select="//metadata/tituloSeccion"/></h1>
              <section>
                <h2>📋 Parejas Registradas</h2>
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Pareja</th>
                      <th>Registro</th>
                      <th>Estado</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="//parejas/pareja">
                      <tr>
                        <td><xsl:value-of select="@id"/></td>
                        <td><xsl:value-of select="nombres"/></td>
                        <td><xsl:value-of select="registro"/></td>
                        <td><span class="estado-disponible">✅ Activa</span></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </section>
              
              <section>
                <h2>➕ Registrar Nueva Pareja</h2>
                <form>
                  <label>Persona 1: Nombre y Apellidos</label>
                  <input type="text" required="required"/>
                  
                  <label>Persona 1: Email</label>
                  <input type="email" required="required"/>
                  
                  <label>Persona 2: Nombre y Apellidos</label>
                  <input type="text" required="required"/>
                  
                  <label>Persona 2: Email</label>
                  <input type="email" required="required"/>
                  
                  <div class="form-buttons">
                    <button type="submit" class="btn btn-primario">✅ Registrar Pareja</button>
                  </div>
                </form>
              </section>
            </xsl:when>
            
            <!-- 🐾 Animales -->
            <xsl:when test="//metadata/pagina = 'animales'">
              <h1><xsl:value-of select="//metadata/tituloSeccion"/></h1>
              <section>
                <h2>🐶 Animales Disponibles</h2>
                <table>
                  <thead>
                    <tr>
                      <th>Foto</th>
                      <th>Nombre</th>
                      <th>Especie</th>
                      <th>Edad</th>
                      <th>Estado</th>
                      <th>Acción</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="//animales/animal[@estado='disponible']">
                      <tr>
                        <td><xsl:value-of select="foto"/></td>
                        <td><strong><xsl:value-of select="nombre"/></strong></td>
                        <td><xsl:value-of select="especie"/> (<xsl:value-of select="raza"/>)</td>
                        <td><xsl:value-of select="edad"/> años</td>
                        <td><span class="estado-disponible">✅ Disponible</span></td>
                        <td>
                          <a href="adopciones.xml" class="btn btn-secundario">Adoptar</a>
                        </td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </section>
              
              <section>
                <h2>🐾 Animales Adoptados</h2>
                <table>
                  <thead>
                    <tr>
                      <th>Nombre</th>
                      <th>Especie</th>
                      <th>Adoptado por</th>
                      <th>Fecha</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="//animales/animal[@estado='adoptado']">
                      <tr>
                        <td><strong><xsl:value-of select="nombre"/></strong></td>
                        <td><xsl:value-of select="especie"/></td>
                        <td><xsl:value-of select="adoptadoPor"/></td>
                        <td><xsl:value-of select="fechaAdopcion"/></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </section>
            </xsl:when>
            
            <!-- ❤️ Adopciones -->
            <xsl:when test="//metadata/pagina = 'adopciones'">
              <h1><xsl:value-of select="//metadata/tituloSeccion"/></h1>
              <section>
                <h2>✅ Adopciones Realizadas</h2>
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Animal</th>
                      <th>Pareja</th>
                      <th>Fecha</th>
                      <th>Estado</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="//adopciones/adopcion">
                      <tr>
                        <td><xsl:value-of select="@id"/></td>
                        <td><xsl:value-of select="animal"/></td>
                        <td><xsl:value-of select="pareja"/></td>
                        <td><xsl:value-of select="fecha"/></td>
                        <td><span class="estado-disponible">✅ Completada</span></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </section>
              
              <section>
                <h2>📝 Registrar Nueva Adopción</h2>
                <form>
                  <label>Seleccionar pareja</label>
                  <select required="required">
                    <option value="">-- Elija una pareja --</option>
                    <option value="p1">Luis &amp; Ana</option>
                    <option value="p2">Carlos &amp; Marta</option>
                  </select>
                  
                  <label>Seleccionar animal</label>
                  <select required="required">
                    <option value="">-- Elija un animal --</option>
                    <option value="a1">Rocky (Perro, 3 años)</option>
                    <option value="a2">Luna (Gata, 2 años)</option>
                  </select>
                  
                  <label>Observaciones</label>
                  <textarea rows="3"></textarea>
                  
                  <div class="form-buttons">
                    <button type="submit" class="btn btn-primario">✅ Confirmar Adopción</button>
                  </div>
                </form>
              </section>
            </xsl:when>
            
            <!-- 📧 Contacto -->
            <xsl:when test="//metadata/pagina = 'contacto'">
              <h1><xsl:value-of select="//metadata/tituloSeccion"/></h1>
              <section>
                <h2>📧 Contáctanos</h2>
                <p>¿Tienes dudas? Escríbenos y te responderemos lo antes posible.</p>
                
                <form>
                  <label>Nombre</label>
                  <input type="text" required="required"/>
                  
                  <label>Email</label>
                  <input type="email" required="required"/>
                  
                  <label>Asunto</label>
                  <select required="required">
                    <option value="">-- Seleccione --</option>
                    <option value="consulta">Consulta general</option>
                    <option value="adopcion">Proceso de adopción</option>
                    <option value="colaboracion">Colaboración</option>
                  </select>
                  
                  <label>Mensaje</label>
                  <textarea rows="5" required="required"></textarea>
                  
                  <div class="form-buttons">
                    <button type="submit" class="btn btn-primario">📤 Enviar Mensaje</button>
                  </div>
                </form>
              </section>
              
              <section>
                <h2>📍 Información de Contacto</h2>
                <p><strong>Teléfono:</strong> 956 XXX XXX</p>
                <p><strong>Email:</strong> contacto@adoptados.org</p>
                <p><strong>Dirección:</strong> C/ Protección Animal, 123 — Jerez de la Frontera</p>
              </section>
            </xsl:when>
          </xsl:choose>
        </main>

        <!-- Pie de página -->
        <footer>
          <p>© 2025 AdopTados — Protectora de Animales</p>
          <p>Proyecto de Lenguaje de Marcas | IES Padre Luis Coloma</p>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>