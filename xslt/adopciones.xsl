<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head><title>Adopciones</title></head>
      <body>
        <h1>Adopciones (XSLT)</h1>
        <h2>Usuarios:</h2>
        <ul>
          <xsl:for-each select="adopciones/usuarios/usuario">
            <li><xsl:value-of select="nombre"/> <xsl:value-of select="apellido"/></li>
          </xsl:for-each>
        </ul>
        <h2>Animales:</h2>
        <ul>
          <xsl:for-each select="adopciones/animales/animal">
            <li><xsl:value-of select="nombre"/> (<xsl:value-of select="@estado"/>)</li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>