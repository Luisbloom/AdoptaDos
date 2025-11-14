<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  
  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>🐾 AdoptaDos — Protectora de Animales</title>
        <style>
          * { box-sizing: border-box; margin: 0; padding: 0; }
          body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
            padding: 20px;
          }
          header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 3px solid #3498db;
          }
          h1 {
            color: #2c3e50;
            font-size: 2.2rem;
          }
          h2 {
            color: #2980b9;
            margin: 1.5rem 0 0.8rem;
            padding-left: 10px;
            border-left: 4px solid #3498db;
          }
          .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
          }
          .section {
            margin-bottom: 2rem;
          }
          table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
          }
          th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
          }
          th {
            background-color: #3498db;
            color: white;
          }
          tr:nth-child(even) { background-color: #f2f2f2; }
          .estado-disponible { color: #27ae60; font-weight: bold; }
          .estado-adoptado { color: #e74c3c; font-weight: bold; }
          footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #ddd;
            color: #7f8c8d;
            font-size: 0.9rem;
          }
          @media (max-width: 600px) {
            .container { padding: 15px; }
            table, thead, tbody, th, td, tr {
              display: block;
            }
            thead tr { position: absolute; top: -9999px; left: -9999px; }
            tr {
              margin-bottom: 1rem;
              border: 1px solid #ddd;
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
              font-weight: bold;
            }
          }
        </style>
      </head>
      
      <body>
        <div class="container">
          <header>
            <h1>🐾 AdoptaDos</h1>
            <p>Protección animal y adopción responsable en pareja</p>
          </header>

          <!-- Parejas registradas -->
          <div class="section">
            <h2>👥 Parejas registradas</h2>
            <xsl:choose>
              <xsl:when test="count(adopciones/parejas/pareja) = 0">
                <p>No hay parejas registradas.</p>
              </xsl:when>
              <xsl:otherwise>
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Pareja</th>
                      <th>Emails</th>
                      <th>Registro</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="adopciones/parejas/pareja">
                      <tr>
                        <td><xsl:value-of select="@id"/></td>
                        <td>
                          <xsl:value-of select="persona1/nombre"/> <xsl:value-of select="persona1/apellido"/>
                          <br/> &amp; <br/>
                          <xsl:value-of select="persona2/nombre"/> <xsl:value-of select="persona2/apellido"/>
                        </td>
                        <td>
                          <xsl:value-of select="persona1/email"/> <br/>
                          <xsl:value-of select="persona2/email"/>
                        </td>
                        <td><xsl:value-of select="fechaRegistro"/></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <!-- Animales disponibles -->
          <div class="section">
            <h2>🐾 Animales registrados</h2>
            <xsl:choose>
              <xsl:when test="count(adopciones/animales/animal) = 0">
                <p>No hay animales registrados.</p>
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
          </div>

          <!-- Adopciones realizadas -->
          <div class="section">
            <h2>❤️ Adopciones realizadas</h2>
            <xsl:choose>
              <xsl:when test="count(adopciones/adopciones-realizadas/adopcion) = 0">
                <p>No hay adopciones registradas.</p>
              </xsl:when>
              <xsl:otherwise>
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Animal</th>
                      <th>Pareja adoptante</th>
                      <th>Fecha</th>
                    </tr>
                  </thead>
                  <tbody>
                    <xsl:for-each select="adopciones/adopciones-realizadas/adopcion">
                      <xsl:variable name="idP" select="idPareja"/>
                      <xsl:variable name="idA" select="idAnimal"/>
                      
                      <xsl:variable name="pareja" select="//parejas/pareja[@id=$idP]"/>
                      <xsl:variable name="animal" select="//animales/animal[@id=$idA]"/>

                      <tr>
                        <td><xsl:value-of select="@id"/></td>
                        <td>
                          <strong><xsl:value-of select="$animal/nombre"/></strong>
                          (<xsl:value-of select="$animal/especie"/>)
                        </td>
                        <td>
                          <xsl:value-of select="$pareja/persona1/nombre"/> &amp; 
                          <xsl:value-of select="$pareja/persona2/nombre"/>
                        </td>
                        <td><xsl:value-of select="fecha"/></td>
                      </tr>
                    </xsl:for-each>
                  </tbody>
                </table>
              </xsl:otherwise>
            </xsl:choose>
          </div>

          <footer>
            <p>© 2025 AdoptaDos — Proyecto de Lenguaje de Marcas | IES Padre Luis Coloma</p>
            <p>Documento XML generado el <xsl:value-of select="current-date()"/> (simulado)</p>
          </footer>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>