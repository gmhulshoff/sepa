<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <div class="table">
  <div class="row">
  
  <div class="cell">
  <div class="table"><div class="row">
  <div class="cell">
    <h2>Incassant</h2>
    <table border="1">
      <xsl:for-each select="/sepa/vereniging">
        <tr><th>Naam</th><td><xsl:value-of select="naam"/></td></tr>
        <tr><th>IBAN</th><td><xsl:value-of select="iban"/></td></tr>
        <tr><th>BIC</th><td><xsl:value-of select="bic"/></td></tr>
        <tr><th>IncassantID</th><td><xsl:value-of select="incassantid"/></td></tr>
      </xsl:for-each>
    </table>
  </div>
  <div class="cell">
    <h2>Incasso</h2>
    <table border="1">
      <xsl:for-each select="/sepa/incasso">
	    <tr><th>Datum</th><td><xsl:value-of select="datum"/></td></tr>
	    <tr><th>Tijd</th><td><xsl:value-of select="tijd"/></td></tr>
	    <tr><th>Kenmerk</th><td><xsl:value-of select="kenmerk"/></td></tr>
	  </xsl:for-each>
    </table>
  </div>
  <div class="cell">
    <h2>Samenvatting</h2>
    <table border="1">
      <tr>
	    <th></th>
	    <th>Aantal</th>
	    <th>&#8364;</th>
      </tr>
	  <tr>
        <th>Bevestigd</th>
	    <td><xsl:value-of select="count(/sepa/lid[bevestigd='Ja']/bedrag)"/></td>
	    <td><xsl:value-of select="format-number(sum(/sepa/lid[bevestigd='Ja']/bedrag), '#.00')"/></td>
	  </tr>
	  <tr>
	    <th>Niet bevestigd</th>
	    <td><xsl:value-of select="count(/sepa/lid[bevestigd='Nee']/bedrag)"/></td>
	    <td><xsl:value-of select="format-number(sum(/sepa/lid[bevestigd='Nee']/bedrag), '#.00')"/></td>
	  </tr>
    </table>
  </div>
  </div></div>
  </div>

  </div>
  <div class="row">
  
  <div class="cell">
    <h2>Details</h2>
    <table border="1">
      <tr>
        <th>Nr<br/><xsl:value-of select="count(/sepa/lid)"/></th>
        <th>Mandaat<br/>ID</th>
        <th>Mandaat<br/>Datum</th>
        <th>IBAN</th>
        <th>Naam</th>
        <th>Bedrag<br/><xsl:value-of select="format-number(sum(/sepa/lid/bedrag), '#.00')"/></th>
	    <th>Bevestigd</th>
      </tr>
      <xsl:for-each select="sepa/lid">
        <xsl:variable name="cls" select="position() mod 2"/>
        <tr class="row{$cls}">
          <td><xsl:value-of select="position()"/></td>
          <td><xsl:value-of select="mandaatid"/></td>
          <td><xsl:value-of select="mandaatdatum"/></td>
          <td><xsl:value-of select="iban"/></td>
          <td><xsl:value-of select="naam"/></td>
          <td><xsl:value-of select="format-number(bedrag, '#.00')"/></td>
          <td><xsl:value-of select="bevestigd"/></td>
        </tr>
      </xsl:for-each>
    </table>
  </div>

  <div class="cell">
  </div>

  <div class="cell">
  </div>

  </div>
  </div>
</xsl:template>

</xsl:stylesheet>
