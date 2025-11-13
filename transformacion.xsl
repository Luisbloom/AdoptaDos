<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
    <div>
        <!-- Sección de Animales -->
        <section id="animales">
            <h2>🐶 Animales disponibles</h2>
            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Especie</th>
                    <th>Raza</th>
                    <th>Edad</th>
                    <th>Sexo</th>
                </tr>
                <xsl:for-each select="adoptados/animales/animal">
                    <tr>
                        <td><xsl:value-of select="nombre"/></td>
                        <td><xsl:value-of select="especie"/></td>
                        <td><xsl:value-of select="raza"/></td>
                        <td><xsl:value-of select="edad"/></td>
                        <td><xsl:value-of select="sexo"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </section>

        <!-- Sección de Parejas -->
        <section id="parejas">
            <h2>💑 Parejas registradas</h2>
            <table>
                <tr>
                    <th>Integrante 1</th>
                    <th>Integrante 2</th>
                    <th>Ciudad</th>
                    <th>Correo</th>
                </tr>
                <xsl:for-each select="adoptados/parejas/pareja">
                    <tr>
                        <td><xsl:value-of select="nombre1"/></td>
                        <td><xsl:value-of select="nombre2"/></td>
                        <td><xsl:value-of select="ciudad"/></td>
                        <td><xsl:value-of select="correo"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </section>

        <!-- Sección de Adopciones -->
        <section id="adopciones">
            <h2>📜 Adopciones realizadas</h2>
            <table>
                <tr>
                    <th>Pareja</th>
                    <th>Animal adoptado</th>
                    <th>Fecha</th>
                </tr>
                <xsl:for-each select="adoptados/adopciones/adopcion">
                    <tr>
                        <td>
                            <xsl:variable name="parejaId" select="parejaRef"/>
                            <xsl:value-of select="/adoptados/parejas/pareja[@id=$parejaId]/nombre1"/>
                            &amp;
                            <xsl:value-of select="/adoptados/parejas/pareja[@id=$parejaId]/nombre2"/>
                        </td>
                        <td>
                            <xsl:variable name="animalId" select="animalRef"/>
                            <xsl:value-of select="/adoptados/animales/animal[@id=$animalId]/nombre"/>
                        </td>
                        <td><xsl:value-of select="fecha"/></td>
                    </tr>
                </xsl:for-each>
            </table>
        </section>
    </div>
</xsl:template>

</xsl:stylesheet>
