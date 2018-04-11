<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/*[name()='Document']/*[name()='CstmrDrctDbtInitn']">
<![CDATA[<sepa>
  <incasso>
    <datum>]]><xsl:value-of select="substring-before(*[name()='GrpHdr']/*[name()='CreDtTm'], 'T')"/><![CDATA[</datum>
    <tijd>]]><xsl:value-of select="substring-before(substring-after(*[name()='GrpHdr']/*[name()='CreDtTm'], 'T'), 'Z')"/><![CDATA[</tijd>
    <kenmerk>]]><xsl:value-of select="substring-before(*[name()='GrpHdr']/*[name()='MsgId'], substring-before(*[name()='GrpHdr']/*[name()='CreDtTm'], 'T'))"/><![CDATA[</kenmerk>
  </incasso>
  <vereniging>
    <naam>]]><xsl:value-of select="*[name()='PmtInf']/*[name()='Cdtr']/*[name()='Nm']"/><![CDATA[</naam>
    <iban>]]><xsl:value-of select="*[name()='PmtInf']/*[name()='CdtrAcct']/*[name()='Id']/*[name()='IBAN']"/><![CDATA[</iban>
    <bic>]]><xsl:value-of select="*[name()='PmtInf']/*[name()='CdtrAgt']/*[name()='FinInstnId']/*[name()='BIC']"/><![CDATA[</bic>
    <incassantid>]]><xsl:value-of select="*[name()='PmtInf']/*[name()='CdtrSchmeId']/*[name()='Id']/*[name()='PrvtId']/*[name()='Othr']/*[name()='Id']"/><![CDATA[</incassantid>
  </vereniging>]]>
  <xsl:for-each select="*[name()='PmtInf']/*[name()='DrctDbtTxInf']">
  <xsl:sort select="*[name()='DrctDbtTx']/*[name()='MndtRltdInf']/*[name()='MndtId']"/>
  <![CDATA[<lid>
    <naam>]]><xsl:value-of select="*[name()='Dbtr']/*[name()='Nm']"/><![CDATA[</naam>
    <iban>]]><xsl:value-of select="*[name()='DbtrAcct']/*[name()='Id']/*[name()='IBAN']"/><![CDATA[</iban>
    <bedrag>]]><xsl:value-of select="*[name()='InstdAmt']"/><![CDATA[</bedrag>
    <mandaatid>]]><xsl:value-of select="*[name()='DrctDbtTx']/*[name()='MndtRltdInf']/*[name()='MndtId']"/><![CDATA[</mandaatid>
    <mandaatdatum>]]><xsl:value-of select="*[name()='DrctDbtTx']/*[name()='MndtRltdInf']/*[name()='DtOfSgntr']"/><![CDATA[</mandaatdatum>
  </lid>]]>
  </xsl:for-each>
<![CDATA[</sepa>]]>
</xsl:template>

</xsl:stylesheet>
