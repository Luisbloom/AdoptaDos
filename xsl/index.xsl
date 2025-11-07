<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
<html>
<head>
  <meta charset="UTF-8"/>
  <title>AdoptaDos – Adopta en pareja ❤️</title>
  <link rel="stylesheet" href="resources/css/styles.css"/>
</head>
<body>
  <header>
    <h1>🌟 AdoptaDos</h1>
    <p>Porque adoptar es mejor… ¡en pareja!</p>
  </header>

  <!-- Controles de interacción -->
  <div class="controles">
    <label>Filtrar por especie:
      <select id="filtro-especie">
        <option value="todos">Todos</option>
        <option value="Perro">Perros</option>
        <option value="Gato">Gatos</option>
        <option value="Conejo">Conejos</option>
      </select>
    </label>
    <label>Buscar:
      <input type="text" id="buscador-nombre" placeholder="Nombre del animal..." />
    </label>
  </div>

  <!-- Animales -->
  <section>
    <h2>🐾 Animales disponibles</h2>
    <div class="lista">
      <xsl:for-each select="document('data/animales/animales.xml')/animales/animal">
        <div class="animal-card" data-especie="{especie}">
          <h3 class="animal-nombre"><xsl:value-of select="nombre"/></h3>
          <p><strong>Especie:</strong> <xsl:value-of select="especie"/></p>
          <p><strong>Edad:</strong> <xsl:value-of select="edad"/> año(s)</p>
          <p class="descripcion"><xsl:value-of select="descripcion"/></p>
          <button class="btn-solicitar" data-id="{@id}">Solicitar adopción</button>
        </div>
      </xsl:for-each>
    </div>
  </section>

  <!-- Parejas -->
  <section>
    <h2>💑 Parejas registradas</h2>
    <ul>
      <xsl:for-each select="document('data/parejas/parejas.xml')/parejas/pareja">
        <li><xsl:value-of select="concat(nombre, ' ', apellido)"/> — <xsl:value-of select="email"/></li>
      </xsl:for-each>
    </ul>
  </section>

  <!-- Adopciones -->
  <section>
    <h2>✅ Adopciones registradas</h2>
    <table border="1">
      <thead><tr><th>Pareja ID</th><th>Animal ID</th><th>Fecha</th><th>Estado</th></tr></thead>
      <tbody>
        <xsl:for-each select="document('data/adopciones/adopciones.xml')/adopciones/adopcion">
          <tr>
            <td><xsl:value-of select="pareja_id"/></td>
            <td><xsl:value-of select="animal_id"/></td>
            <td><xsl:value-of select="fecha"/></td>
            <td><xsl:value-of select="estado"/></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </section>

  <script src="resources/js/index.js"></script>
</body>
</html>
</xsl:template>
</xsl:stylesheet>