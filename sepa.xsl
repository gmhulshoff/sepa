<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/"><![CDATA[<Document xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>
  <CstmrDrctDbtInitn>]]>
<xsl:call-template name="header"></xsl:call-template>
<xsl:call-template name="incasssoregels"></xsl:call-template>  <![CDATA[</CstmrDrctDbtInitn>
</Document>]]>
</xsl:template>

<xsl:template name="header">    <![CDATA[<GrpHdr>
      <MsgId>]]><xsl:value-of select="/sepa/incasso/kenmerk"/><xsl:value-of select="/sepa/incasso/datum"/><![CDATA[</MsgId>
      <CreDtTm>]]><xsl:value-of select="/sepa/incasso/datum"/>T<xsl:value-of select="/sepa/incasso/tijd"/>Z<![CDATA[</CreDtTm>
      <NbOfTxs>]]><xsl:value-of select="count(/sepa/lid)"/><![CDATA[</NbOfTxs>
      <InitgPty>
        <Nm>]]><xsl:value-of select="/sepa/vereniging/naam"/><![CDATA[</Nm>
      </InitgPty>
    </GrpHdr>]]>
</xsl:template>

<xsl:template name="incasssoregels">    <![CDATA[<PmtInf xmlns='urn:iso:std:iso:20022:tech:xsd:pain.008.001.02'>
      <PmtInfId>]]><xsl:value-of select="/sepa/incasso/kenmerk"/><![CDATA[</PmtInfId>
      <PmtMtd>DD</PmtMtd>
      <PmtTpInf>
        <SvcLvl>
          <Cd>SEPA</Cd>
        </SvcLvl>
        <LclInstrm>
          <Cd>CORE</Cd>
        </LclInstrm>
        <SeqTp>RCUR</SeqTp>
      </PmtTpInf>
      <ReqdColltnDt>]]><xsl:value-of select="/sepa/incasso/datum"/><![CDATA[</ReqdColltnDt>
      <Cdtr>
        <Nm>]]><xsl:value-of select="/sepa/vereniging/naam"/><![CDATA[</Nm>
        <PstlAdr>
          <Ctry>NL</Ctry>
        </PstlAdr>
        </Cdtr>
        <CdtrAcct>
          <Id>
            <IBAN>]]><xsl:value-of select="/sepa/vereniging/iban"/><![CDATA[</IBAN>
          </Id>
        </CdtrAcct>
        <CdtrAgt>
        <FinInstnId>
          <BIC>]]><xsl:value-of select="/sepa/vereniging/bic"/><![CDATA[</BIC>
        </FinInstnId>
      </CdtrAgt>
      <UltmtCdtr>
        <Nm>]]><xsl:value-of select="/sepa/vereniging/naam"/><![CDATA[</Nm>
      </UltmtCdtr>
      <ChrgBr>SLEV</ChrgBr>
      <CdtrSchmeId>
        <Id>
          <PrvtId>
            <Othr>
              <Id>]]><xsl:value-of select="/sepa/vereniging/incassantid"/><![CDATA[</Id>
              <SchmeNm>
                <Prtry>SEPA</Prtry>
              </SchmeNm>
            </Othr>
          </PrvtId>
        </Id>
      </CdtrSchmeId>]]>
<xsl:for-each select="sepa/lid">      <![CDATA[<DrctDbtTxInf xmlns="urn:iso:std:iso:20022:tech:xsd:pain.008.001.02">
        <PmtId>
          <EndToEndId>]]><xsl:value-of select="/sepa/incasso/kenmerk"/>-<xsl:value-of select="mandaatid"/><![CDATA[</EndToEndId>
        </PmtId>
        <InstdAmt Ccy="EUR">]]><xsl:value-of select="bedrag"/><![CDATA[</InstdAmt>
        <DrctDbtTx>
          <MndtRltdInf>
            <MndtId>]]><xsl:value-of select="mandaatid"/><![CDATA[</MndtId>
            <DtOfSgntr>]]><xsl:value-of select="mandaatdatum"/><![CDATA[</DtOfSgntr>
          </MndtRltdInf>
        </DrctDbtTx>
        <DbtrAgt>
          <FinInstnId/>
        </DbtrAgt>
        <Dbtr>
          <Nm>]]><xsl:value-of select="naam"/><![CDATA[</Nm>
          <PstlAdr>
            <Ctry>NL</Ctry>
          </PstlAdr>
        </Dbtr>
        <DbtrAcct>
          <Id>
            <IBAN>]]><xsl:value-of select="iban"/><![CDATA[</IBAN>
          </Id>
        </DbtrAcct>
        <UltmtDbtr>
          <Nm>]]><xsl:value-of select="naam"/><![CDATA[</Nm>
        </UltmtDbtr>
      </DrctDbtTxInf>]]>
</xsl:for-each>    <![CDATA[</PmtInf>]]>
</xsl:template>
</xsl:stylesheet>
