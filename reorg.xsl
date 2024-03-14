<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
					 	xmlns:gxsql="urn:SQLFunc">


	<xsl:template match="ReorgSpec">
<DIV id="ReorgSpec">
	<xsl:call-template name="TableHeaderMain">
		<xsl:with-param name="id">tblreorg</xsl:with-param>
		<xsl:with-param name="title">Table 
			<xsl:apply-templates select="Table"/> 
			<xsl:apply-templates select="ReorgCls"/>
		</xsl:with-param>
	</xsl:call-template>
	<DIV id="content">
	<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CDAAAD" style="border-collapse:collapse">
		<xsl:choose> 
			<xsl:when test="ReorgCls[text()='c']">
				 <tr>
				  <td bgcolor="#F1F1F1" class="textoGrande">Table name: 
					<xsl:apply-templates select="Table"/>
				  </td>
				 </tr>
				 <xsl:if test="LocalTable">
					<TR >
						<TD>Local</TD>
						<TD><xsl:value-of select="LocalTable"/></TD>
					</TR>
				</xsl:if>
				<TR >
					<TD colspan="2" class="textoMsg"><xsl:value-of select="ReorgMsg"/></TD>
				</TR>
				 <xsl:if test="ReorgMsgEx">
					<TR >
						<TD colspan="2" class="textoMsg" color="#CECECE"><xsl:value-of select="ReorgMsgEx"/></TD>
					</TR>
				</xsl:if>				
			</xsl:when>
			<xsl:when test="ReorgCls[text()='l']">
					<TR >
						<TD>Table name</TD>
						<TD><xsl:apply-templates select="Table"/></TD>
					</TR>
			</xsl:when>
			<xsl:when test="ReorgCls[text()='s']">
					<TR >
						<TD>Synchronization by row reorganization procedure</TD>
					</TR>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
			<xsl:if test="RedundantAttrisToUpdate">
				<TR class="textoGrisTabla">
					<TD>Redundant attributes to update:</TD>
					<TD><xsl:apply-templates select="RedundantAttrisToUpdate"/></TD>
				</TR>
			</xsl:if>
			<xsl:if test="FromAttrisToUpdate">
				<TR class="textoGrisTabla">
					<TD>From attributes to update: </TD>
					<TD><xsl:apply-templates select="FromAttrisToUpdate"/></TD>
				</TR>
			</xsl:if>
			<xsl:if test="RedundantAttris">
				<TR class="textoGrisTabla">
					<TD>Redundant attributes</TD>
					<TD><xsl:apply-templates select="RedundantAttris"/></TD>
				</TR>	
			</xsl:if>
			<xsl:if test="ProcedureName">
				<TR colspan="2" class="textoGrisTabla">
					<TD>Procedure Name</TD>
					<TD><xsl:value-of select="ProcedureName"/></TD>
				</TR>
			</xsl:if>
			<TR class="textoGrisTabla">
				<TD>
					<xsl:apply-templates select="RenameTable"/>
				</TD>
			</TR>
			<xsl:if test="Errors/Error">
				<TR>
					<TD  colspan="2">
						<xsl:apply-templates select="Errors"/>
					</TD>
				</TR>
			</xsl:if>
			<xsl:if test="Warnings/Warning">
				<TR>
					<TD  colspan="2">
						<xsl:apply-templates select="Warnings"/>
					</TD>
				</TR>
			</xsl:if>
			<TR>
				<TD  colspan="2">
					<xsl:apply-templates select="TableAttributes"/>
				</TD>
			</TR>
			<xsl:if test="TableIndices">
				<TR>
					<TD  colspan="2">
						<xsl:apply-templates select="TableIndices"/>
					</TD>
				</TR>
			</xsl:if>
			<xsl:if test="FKConstraints">
				<TR>
					<TD colspan="2">
						<xsl:apply-templates select="FKConstraints"/>
					</TD>
				</TR>
			</xsl:if>
			<xsl:if test="Statements">
				<TR>
					<TD colspan="2">
						<xsl:apply-templates select="Statements"/>
					</TD>
				</TR>
			</xsl:if>
			<xsl:if test="ObjectSpec/Levels">
				<TR>
					<TD colspan="2">
						<xsl:apply-templates select="ObjectSpec/Levels"/>
					</TD>
				</TR>
			</xsl:if>
		<xsl:if test="AttrisInManyTables/Attribute">
			<xsl:apply-templates select="AttrisInManyTables"/>
		</xsl:if>
	</table>
	</DIV>
</DIV>
</xsl:template>

<!-- ReorgCls TEMPLATE-->
<xsl:template match="ReorgCls">
	<xsl:choose> 
		<xsl:when test="text()[.='c']">
			specification
		</xsl:when>
		<xsl:when test="text()[.='r']">
			load redundancy procedure
		</xsl:when>
		<xsl:when test="text()[.='u']">
			update redundancy procedure
		</xsl:when>
		<xsl:when test="text()[.='l']">
			append data to file procedure
		</xsl:when>
		<xsl:when test="text()[.='s']">
			procedure
		</xsl:when>
		<xsl:otherwise>specification</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="TableAttributes">
	<xsl:call-template name="GenerateTable">
		<xsl:with-param name="ID">TableAttributes</xsl:with-param>
		<xsl:with-param name="Title">Table Structure</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="AttrisInTable|AttrisNoLongerInTable" mode="TableRow">
	<xsl:for-each select="Attribute">
		<tr class="textoGrisTabla"><xsl:apply-templates select="." mode="TableRow"/></tr>
		<xsl:call-template name="EndRow"/>
	</xsl:for-each>
</xsl:template>

<xsl:template match="Indices|NewIndices|IndicesToDelete" mode="TableRow">
	<xsl:apply-templates select="Index" mode="TableRow"/>
</xsl:template>

<xsl:template match="RenameTable">
Rename <xsl:value-of select="OldName"/> to <xsl:value-of select="NewName"/>
</xsl:template>

<xsl:template match="AttriOrder">
<xsl:choose>
	<xsl:when test="text()[.='Descending']">
		<xsl:call-template name="RenderImage"><xsl:with-param name="Id">IdxDescending</xsl:with-param></xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="RenderImage"><xsl:with-param name="Id">IdxAscending</xsl:with-param></xsl:call-template>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template name="CompareProperties">
	<xsl:for-each select="AttriType/Properties/Property">
		<xsl:variable name="Name" select="Name"/>
		<xsl:variable name="Value" select="Value"/>
		<xsl:for-each select="../../../AttriOldType/Properties/Property">
			<xsl:if test="$Name = Name and $Value != Value">
				<xsl:call-template name="ProperyValue">
					<xsl:with-param name="Name"><xsl:value-of select="Name"/></xsl:with-param>
					<xsl:with-param name="Value"><xsl:value-of select="Value"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

<xsl:template name="CompareType">
	<xsl:variable name="typ1" select="AttriType/DataType"/>
	<xsl:variable name="len1" select="AttriType/Presicion"/>
	<xsl:variable name="dec1" select="AttriType/Scale"/>
	<xsl:variable name="typ2" select="AttriOldType/DataType"/>
	<xsl:variable name="len2" select="AttriOldType/Presicion"/>
	<xsl:variable name="dec2" select="AttriOldType/Scale"/>

	<xsl:choose>
		<xsl:when test="$typ1 = $typ2 and $len1 = $len2 and $dec1 = $dec2">
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="ProperyValue">
				<xsl:with-param name="Name">Type</xsl:with-param>
				<xsl:with-param name="Value"><xsl:apply-templates select="AttriOldType"/></xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose> 
</xsl:template>

<xsl:template match="AttriChangeType">
	<xsl:variable name="Var" select="../.."/>
	<xsl:choose>
		<xsl:when test="text()[.='nv'] or text()[.='nn'] or text()[.='ni']">
			<xsl:call-template name="ChangeObject">
				<xsl:with-param name="ChgType">N</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
		<xsl:when test="$Var[name()='AttrisNoLongerInTable']">
			<xsl:call-template name="ChangeObject">
				<xsl:with-param name="ChgType">D</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
		<xsl:otherwise/> <!-- del,upd -->
	</xsl:choose>
</xsl:template>

<!-- table FROM TEMPLATE -->
<xsl:template match="TakesValueFrom">
	<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="OnPrimaryKey">
<xsl:if test="text()[.='Yes']">
	<xsl:call-template name="RenderImage"><xsl:with-param name="Id">Key</xsl:with-param></xsl:call-template>
</xsl:if>
</xsl:template>


<xsl:template match="Attribute" mode="TableRow">
		<!-- Type of change -->
		<TD valign="top" class="textoGrisTabla"><xsl:apply-templates select="AttriChangeType"/></TD>
		<!-- Attribute is part of primary key -->
		<TD valign="top" class="textoGrisTabla"><xsl:apply-templates select="OnPrimaryKey"/></TD>
		<!--  Attribute name -->
		<TD valign="top" noWrap="yes"><xsl:apply-templates select="."/></TD>
		<!--  Definition -->
		<TD valign="top" class="textoGrisTabla">
			<xsl:apply-templates select="AttriType"/>
			<xsl:for-each select="AttriType/Properties/Property">
				<xsl:if test="Name[.='AllowNulls'] and Value[.='No']">Not<xsl:text> </xsl:text>null</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="AttriType/Properties/Property">
				<xsl:if test="Name[.='Autonumber'] and Value[.='Yes']"> Autonumber</xsl:if>
			</xsl:for-each>
			<xsl:for-each select="AttriType/Properties/Property">
				<xsl:if test="Name[.='Autogenerate'] and Value[.='Yes']"> Autogenerate</xsl:if>
			</xsl:for-each>			
			<xsl:for-each select="AttriType/Properties/Property">
				<xsl:if test="Name[.='NLS'] and Value[.='Yes']"> NLS</xsl:if>
			</xsl:for-each>			
		</TD>
		<!-- Previous values -->
		<TD valign="top" class="textoGrisTabla">
			<table width="100%" cellspacing="0" cellpadding="0">
				<xsl:if test="AttriOldName">
					<xsl:call-template name="ProperyValue">
						<xsl:with-param name="Name">Name</xsl:with-param>
						<xsl:with-param name="Value">
							<xsl:value-of select="AttriOldName"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if> 
				<xsl:if test="AttriOldType">
					<xsl:call-template name="CompareType"/>
					<xsl:call-template name="CompareProperties"/>
				</xsl:if>
			</table>
		</TD>
		<!-- Takes values from -->
		<TD valign="top" class="textoGrisTabla"><xsl:apply-templates select="TakesValueFrom"/></TD>
</xsl:template>

<!-- ATTRIS IN MANY TABLE TEMPLATE -->
<xsl:template match="AttrisInManyTables">
<DIV><xsl:attribute name="id">inmany</xsl:attribute>
	<xsl:call-template name="TableHeader">
		<xsl:with-param name="id">inmany</xsl:with-param>
		<xsl:with-param name="title">Secondary attributes in many tables</xsl:with-param>
	</xsl:call-template>
<DIV id="content">
<table width="100%" cellspacing="0" cellpadding="0">
	<TR class="subTitulosTabla">
		<TD>Attribute</TD>
		<TD>Type</TD>
		<TD/>
	</TR>
	<xsl:for-each select="Attribute">	
	<TR class="textoGrisTabla">
		<TD width="15%"><xsl:apply-templates select="."/> </TD>
		<TD width="7%"><xsl:apply-templates select="AttriType"/> </TD>
		<TD width="30%"/>
	</TR>
	</xsl:for-each>
</table>
</DIV>
</DIV>
</xsl:template>



<xsl:template match="TableIndices">
	<xsl:call-template name="GenerateTable">
		<xsl:with-param name="ID">Indices</xsl:with-param>
		<xsl:with-param name="Title">Indexes</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template match="Index" mode="TableRow">
	<xsl:param name="ChgType">none</xsl:param>
	<TR class="textoGrisTabla">
	<TD valign="top">
		<xsl:choose>			
			<xsl:when test="name(..) ='NewIndices'">
				<xsl:call-template name="ChangeObject">
					<xsl:with-param name="ChgType">N</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name(..) = 'IndicesToDelete'">
				<xsl:call-template name="ChangeObject">
					<xsl:with-param name="ChgType">D</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
		</xsl:choose>
	</TD>
	<TD/>
	<TD valign="top"><xsl:value-of select="IndexName"/></TD>
	<TD valign="top"><xsl:apply-templates select="IndexType"/><xsl:apply-templates select="Clustered"/></TD>
	<TD valign="top"><xsl:apply-templates select="IndexAttris"/></TD>
	<TD/>
	</TR>
	<xsl:call-template name="EndRow"/>
</xsl:template>

<xsl:template match="IndexType">
	<xsl:choose>
		<xsl:when test="text()[.='u']">
			primary key
		</xsl:when>
		<xsl:when test="text()[.='k']">
			unique
		</xsl:when>
		<xsl:otherwise>
			duplicate
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="Clustered">
	<xsl:if test="text()[.='Yes']"> Clustered</xsl:if>
</xsl:template>

<xsl:template match="IndexAttris">
	<table cellspacing="0" cellpadding="0">
		<TR class="text">
			<TD>
				<table cellspacing="0" cellpadding="0">
					<xsl:for-each select="Attribute">
						<TR class="text">
							<TD>
								<xsl:choose>
									<xsl:when test="AttriOrder">
										<xsl:apply-templates select="AttriOrder"/>
										</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="RenderImage">
											<xsl:with-param name="Id">IdxAscending</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</TD>
							<TD>
								<xsl:apply-templates select="."/><xsl:text> </xsl:text>
							</TD>
						</TR>
					</xsl:for-each>
				</table>
			</TD>
		</TR>
	</table>
</xsl:template>

<xsl:template match="IndexAttribute">
<TD><xsl:apply-templates select="IndexOrder"/></TD><TD><xsl:value-of select="Attribute"/>,</TD>
</xsl:template>

<xsl:template match="FKConstraint" mode="TableRow">
		<TD valign="top">
			<xsl:choose>			
				<xsl:when test="ChangeType = 'new'">
					<xsl:call-template name="ChangeObject">
						<xsl:with-param name="ChgType">N</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="ChangeType = 'rmv'">
					<xsl:call-template name="ChangeObject">
						<xsl:with-param name="ChgType">D</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</TD>
		<TD/>
		<TD valign="top"><xsl:apply-templates select="Table"/></TD>
		<TD valign="top"><xsl:call-template name="VAttributes"/></TD>
		<TD/>
</xsl:template>

<xsl:template match="FKConstraints">
<xsl:if test="FKConstraint">
	<xsl:call-template name="GenerateTable">
		<xsl:with-param name="ID">FKConstraint</xsl:with-param>
		<xsl:with-param name="Title">Foreign key constraints</xsl:with-param>
		<xsl:with-param name="RowTemplate">FKConstraint</xsl:with-param>
	</xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template match="Statements">

  <xsl:call-template name="GenerateTable">
    <xsl:with-param name="ID">Statement</xsl:with-param>
    <xsl:with-param name="Title">Statements</xsl:with-param>
    <xsl:with-param name="RowTemplate">Statement</xsl:with-param>
  </xsl:call-template>
</xsl:template>

 <xsl:template match="Statement" mode="TableRow">
   <TD valign="top">
		<PRE><xsl:value-of disable-output-escaping="yes" select="gxsql:GetSql(.)"/></PRE>
   </TD>
 </xsl:template>  

</xsl:stylesheet>
