<?xml version='1.0' encoding='iso-8859-1'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<!-- FORMULAS TEMPLATES -->

<!-- AGGREGATE SELECT TEMPLATE -->
<xsl:template match="AggSelFormulas">
	<xsl:if test="Formula">
			<xsl:call-template name="TableHeader">				
				<xsl:with-param name="title">Formulas</xsl:with-param>
				<xsl:with-param name="width">100%</xsl:with-param>
			</xsl:call-template>	
	<table>
	<TR class="textoGrisTabla"><TD>
	<xsl:for-each select="Formula">
		<B>Navigation to evaluate: </B>
		<xsl:choose>
			<xsl:when test="FormulaType='aggsel'">
				<xsl:apply-templates select="FormulaAttri"/>
				<xsl:if test="FormulaExpression">
				<DIV/>
				<B>Formula: </B>
					<xsl:apply-templates select="FormulaExpression"/>
				</xsl:if>				
				<OL>				
				<table>	
					<xsl:call-template name="FormulaWhereMultiple"/>
					<xsl:if test="FormulaGivenAttris">
						<tr><td>Given:</td><td><xsl:apply-templates select="FormulaGivenAttris"/></td></tr>
					</xsl:if>
					<xsl:if test="FormulaIndex">
						<tr><td>Index:</td><td><xsl:value-of select="FormulaIndex"/></td></tr>
					</xsl:if>
					<xsl:if test="FormulaGroupByAttris">
						<tr><td>Group by:</td><td><xsl:apply-templates select="FormulaGroupByAttris"/></td></tr>
					</xsl:if>						
				</table>
				</OL>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="FormulaName"/>
				<xsl:value-of select="FormulaType"/><xsl:apply-templates select="FormulaOutputAttri"/>)<DIV/>
				<OL>
				Where: <xsl:apply-templates select="FormulaWhere"/><DIV/>
				Given: <xsl:apply-templates select="FormulaGivenAttris"/><DIV/>
				Index: <xsl:value-of select="FormulaIndex"/><DIV/>
				Start From: <UL><xsl:apply-templates select="StartFrom"/></UL>
				Loop While: <UL><xsl:apply-templates select="LoopWhile"/></UL><DIV/>
				Returning: <xsl:apply-templates select="FormulaReturnAttri"/><DIV/>
				</OL>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="NavigationTree"/>
	</xsl:for-each>
	</TD></TR>
	</table>
	</xsl:if>		
</xsl:template>
<!-- END AGGREGATE SELECT TEMPLATE -->

<!-- VERTICAL FORMULAS-->

<xsl:template name="FormulaWhereMultiple">
		<xsl:for-each select="FormulaWhere">
			<xsl:choose>
				<xsl:when test="position() = 1">
						<tr><td>Where:</td><td><xsl:call-template name="ProcessList"/></td></tr>
				</xsl:when>
				<xsl:otherwise>
						<tr><td/><td><xsl:call-template name="ProcessList"/></td></tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>		
</xsl:template>

<xsl:template match="FormulaWhere">
	<xsl:call-template name="ProcessList"/>
</xsl:template>

<xsl:template match="VerticalFormulas">
	<xsl:if test="VerticalFormulaGroup">
	<table class="textoGrisTabla">
	<TR><TD> <FONT class="gxsource">Formulas:</FONT></TD></TR>
	<TR><TD>
	<xsl:for-each select="VerticalFormulaGroup">
		<b> Navigation to evaluate: </b><xsl:apply-templates select="FormulasInGroup"/>
		<xsl:apply-templates select="NavigationTree"/>
	</xsl:for-each>
	</TD></TR>
	</table>
	</xsl:if>	
</xsl:template>

<xsl:template match="FormulaOutputAttri">
	<xsl:call-template name="ProcessList">
		<xsl:with-param name="Sep">,</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="FormulasInGroup">
	<xsl:call-template name="ProcessList">
	</xsl:call-template>
</xsl:template>

<!-- REDUNDANTFORMULAS -->
<xsl:template match="RedundantFormulas">
	<FONT class="gxformtitle">Redundant Formulas:</FONT>
	<xsl:apply-templates select="FormulaToUpdate"/>
</xsl:template>

<xsl:template match="FormulaToUpdate">
	<xsl:apply-templates/>
</xsl:template>


</xsl:stylesheet>
