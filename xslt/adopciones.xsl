<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>📊 Adopciones — Informe Completo</title>
        <style>
          body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f7fa;
            color: #333;
          }
          header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #3498db;
          }
          h1 {
            color: #2c3e50;
            font-size: 2.2rem;
          }
          h2 {
            color: #2980b9;
            margin: 1.5rem 0 0.8rem;
            padding-left: 0.5rem;
            border-left: 4px solid #3498db;
          }
          .resumen {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
            text-align: center;
          }
          .card {
            background: white;
            padding: 1.2rem;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            min-width: 150px;
          }
          .card h3 {
            margin: 0 0 0.5rem;
            font-size: 1.1rem;
            color: #7f8c8d;
          }
          .card .numero {
            font-size: 2rem;
            font-weight: bold;
            color: #27ae60;
          }

          table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
            border-radius: 6px;
            overflow: hidden;
          }
          th {
            background: #3498db;
            color: white;
            text-align: left;
            padding: 12px 14px;
            font-weight: bold;
          }
          tr:nth-child(even) {
            background-color: #f8f9fa;
          }
          td {
            padding: 10px 14px;
            border-bottom: 1px solid #eee;
          }
          .estado-disponible { color: #27ae60; font-weight: bold; }
          .estado-adoptado { color: #e74c3c; font-weight: bold; }
          .nota {
            font-size: 0.9rem;
            color: #7f8c8d;
            font-style: italic;
            margin-top: -0.5rem;
          }

          footer {
            text-align: center;
            margin-top: 3rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            color: #7f8c8d;
          }

          @media (max-width: 600px) {
            .resumen { flex-direction: column; }
            table, thead, tbody, th, td, tr {
              display: block;
            }
            thead tr { position: absolute; top: -9999px; left: -9999px; }
            tr {
              border: 1px solid #ccc;
              margin-bottom: 1rem;
              border-radius: 6px;
            }
            td {
              border: none;
              position: relative;
              padding-left: 50%;
              text-align: right;
            }
            td:before {
              content: attr(data-label) ": ";
              position: absolute;
              left: 10px;
              width: 45%;
              padding-right: 10px;
              white-space: nowrap;
              font-weight: bold;
              text-align: left;
            }
          }
        </style>
      </head>
      <body>
        <header>
          <h1>📊 Informe Completo de Adopciones</h1>
          <p>Generado dinámicamente desde <code>adopciones.xml</code></p>
        </header>

        <!-- Resumen -->
        <div class="resumen">
          <div class="card">
            <h3>Usuarios</h3>
            <div class="numero"><xsl:value-of select="count(adopciones/usuarios/usuario)"/></div>
          </div>
          <div class="card">
            <h3>Animales</h3>
            <div class="numero"><xsl:value-of select="count(adopciones/animales/animal)"/></div>
          </div>
          <div class="card">
            <h3>Adopciones</h3>
            <div class="numero"><xsl:value-of select="count(adopciones/adopciones-realizadas/adopcion)"/></div>
          </div>
        </div>

        <!-- Usuarios -->
        <h2>👥 Usuarios registrados</h2>
        <xsl:choose>
          <xsl:when test="count(adopciones/usuarios/usuario) = 0">
            <p class="nota">No hay usuarios registrados aún.</p>
          </xsl:when>
          <xsl:otherwise>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Apellidos</th>
                  <th>Email</th>
                  <th>Teléfono</th>
                  <th>Dirección</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="adopciones/usuarios/usuario">
                  <tr>
                    <td><xsl:value-of select="@id"/></td>
                    <td><xsl:value-of select="nombre"/></td>
                    <td><xsl:value-of select="apellido"/></td>
                    <td><xsl:value-of select="email"/></td>
                    <td><xsl:value-of select="telefono"/></td>
                    <td><xsl:value-of select="direccion"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:otherwise>
        </xsl:choose>

        <!-- Animales -->
        <h2>🐾 Animales registrados</h2>
        <xsl:choose>
          <xsl:when test="count(adopciones/animales/animal) = 0">
            <p class="nota">No hay animales registrados aún.</p>
          </xsl:when>
          <xsl:otherwise>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Especie</th>
                  <th>Raza</th>
                  <th>Edad</th>
                  <th>Estado</th>
                  <th>Descripción</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="adopciones/animales/animal">
                  <tr>
                    <td><xsl:value-of select="@id"/></td>
                    <td><xsl:value-of select="nombre"/></td>
                    <td><xsl:value-of select="especie"/></td>
                    <td><xsl:value-of select="raza"/></td>
                    <td><xsl:value-of select="edad"/> años</td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="@estado = 'disponible'">
                          <span class="estado-disponible">✅ Disponible</span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="estado-adoptado">❌ Adoptado</span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                    <td><xsl:value-of select="descripcion"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:otherwise>
        </xsl:choose>

        <!-- Adopciones -->
        <h2>❤️ Adopciones realizadas</h2>
        <xsl:choose>
          <xsl:when test="count(adopciones/adopciones-realizadas/adopcion) = 0">
            <p class="nota">No hay adopciones registradas aún.</p>
          </xsl:when>
          <xsl:otherwise>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Animal</th>
                  <th>Pareja (Adoptantes)</th>
                  <th>Fecha</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="adopciones/adopciones-realizadas/adopcion">
                  <xsl:variable name="idA" select="idAnimal"/>
                  <xsl:variable name="idU1" select="pareja/idUsuario[1]"/>
                  <xsl:variable name="idU2" select="pareja/idUsuario[2]"/>

                  <xsl:variable name="animal" select="//animales/animal[@id=$idA]"/>
                  <xsl:variable name="u1" select="//usuarios/usuario[@id=$idU1]"/>
                  <xsl:variable name="u2" select="//usuarios/usuario[@id=$idU2]"/>

                  <tr>
                    <td><xsl:value-of select="@id"/></td>
                    <td>
                      <strong><xsl:value-of select="$animal/nombre"/></strong>
                      (<xsl:value-of select="$animal/especie"/>, <xsl:value-of select="$animal/edad"/> años)
                    </td>
                    <td>
                      <xsl:value-of select="$u1/nombre"/> <xsl:value-of select="$u1/apellido"/>
                      <br/>
                      &amp;
                      <br/>
                      <xsl:value-of select="$u2/nombre"/> <xsl:value-of select="$u2/apellido"/>
                    </td>
                    <td><xsl:value-of select="fecha"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </xsl:otherwise>
        </xsl:choose>

        <footer>
          <p>© 2025 Adopta en Pareja — Datos generados desde XML + XSLT</p>
          <p>Archivo fuente: <code>data/adopciones.xml</code></p>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>