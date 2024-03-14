<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"	xmlns:gx="urn:schemas-artech-com:gx">
	<xsl:include href="include.xsl"/>

	<xsl:output method="html" encoding="iso-8859-1"/>

	<xsl:template match="/">

		<html>
			<xsl:call-template name="HtmlHeader"/>
			<body>
				<xsl:call-template name="HtmlScript"/>

				<DIV>
					<TABLE width="100%">
						<xsl:for-each select="ObjSpecs/TableList">
							<TR>
								<TD>
									<xsl:apply-templates select="."/>
								</TD>
							</TR>
						</xsl:for-each>
					</TABLE>
				</DIV>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="TableList">
		<DIV>
			<xsl:attribute name="id">
				gx<xsl:value-of select="Table/TableName"/>
			</xsl:attribute>
			<xsl:call-template name="TableHeaderMain">
				<xsl:with-param name="title">
					Table <xsl:apply-templates select="Table"/>
				</xsl:with-param>
			</xsl:call-template>
			<DIV id="content">
				<TABLE width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CDAAAD" style="border-collapse:collapse" class="textoGrisTabla">
					<tr>
						<td>
							<table width="100%" cellpadding="0" cellspacing="0" class="textoGrisTabla">
								<TR>
									<TD width="25%">Name</TD>
									<TD>
										<xsl:apply-templates select="Table" mode="icon"/>
									</TD>
								</TR>
								<xsl:call-template name="EndRow"/>
								<TR>
									<TD>Description</TD>
									<TD>
										<xsl:value-of select="Table/TableDesc"/>
									</TD>
								</TR>
								<xsl:call-template name="EndRow"/>
								<xsl:if test="TblAssocDView">
									<TR>
										<TD>Associated to Data View </TD>
										<TD>
											<xsl:apply-templates select="TblAssocDView"/>
										</TD>
									</TR>
									<xsl:call-template name="EndRow"/>
								</xsl:if>
							</table>
						</td>
					</tr>
					<TR>
						<TD colspan="2">
							<xsl:apply-templates select="TblAtts"/>
							<BR/>
						</TD>
					</TR>
					<!-- Only in detailed listing -->
					<xsl:if test="TblIdxs">
						<TR>
							<TD colspan="2">
								<xsl:apply-templates select="TblIdxs"/>
								<BR/>
							</TD>
						</TR>
					</xsl:if>
					<xsl:if test="SubToTbls/TblSubor">
						<TR>
							<TD width="90%" colspan="2">
								<xsl:apply-templates select="SubToTbls"/>
								<BR/>
							</TD>
						</TR>
					</xsl:if>
					<xsl:if test="SupOfTbls/TblSuper">
						<TR>
							<TD width="90%" colspan="2">
								<xsl:apply-templates select="SupOfTbls"/>
								<BR/>
							</TD>
						</TR>
					</xsl:if>
					<xsl:if test="TblCKeys[CKey[2]]">
						<TR>
							<TD colspan="2">
								<xsl:apply-templates select="TblCKeys"/>
								<BR/>
							</TD>
						</TR>
					</xsl:if>
					<xsl:if test="TblPrompts/TblPrompt">
						<TR>
							<TD width="90%" colspan="2">
								<xsl:apply-templates select="TblPrompts"/>
								<BR/>
							</TD>
						</TR>
					</xsl:if>
					<!-- end of: Only in detailed listing -->
					<xsl:if test="PropPart/OneProp">
						<tr>
							<td colspan="2">
								<xsl:apply-templates select="PropPart"/>
							</td>
						</tr>
					</xsl:if>
				</TABLE>
			</DIV>
		</DIV>
	</xsl:template>

	<xsl:template match="TblAtt" mode="TableRow">

	</xsl:template>

	<!-- TableAtts TEMPLATE -->
	<xsl:template match="TblAtts">
		<DIV>
			<xsl:attribute name="id">tblAtts</xsl:attribute>
			<xsl:call-template name="TableHeader">
				<xsl:with-param name="title">Table Structure</xsl:with-param>
			</xsl:call-template>
			<DIV id="content">
				<TABLE width="100%" cellspacing="0" cellpadding="0" style="BORDER-BOTTOM: thin inset; BORDER-RIGHT: thin inset">
					<TR class="text">
						<TD class="subTitulosTabla"/>
						<TD class="subTitulosTabla">Name</TD>
						<TD class="subTitulosTabla">Description</TD>
						<TD class="subTitulosTabla">Type</TD>
						<TD class="subTitulosTabla">Formula</TD>
						<TD class="subTitulosTabla" noWrap="yes">Subtype of</TD>
					</TR>


					<xsl:for-each select="TblAtt[not(TblAttInf) and (not(Attribute/FormulaDef) or TblAttInf)]">
						<TR class="textoGrisTabla">
							<xsl:apply-templates select="."/>
						</TR>
						<xsl:call-template name="EndRow"/>
					</xsl:for-each>


					<xsl:if test="TblAtt[ TblAttInf or (Attribute/FormulaDef and not(TblAttInf))]">
						<TR class="textoGrisTabla">
							<TD colspan="6">
								<TABLE cellspacing="0" cellpadding="0" width="100%" class="text">
									<TR>
										<TD width="1%">
											<IMG style="CURSOR: hand" onclick="displayVirtual()">
												<xsl:attribute name="src">
													<xsl:call-template name="PathImage">
														<xsl:with-param name="Id">Collapse</xsl:with-param>
													</xsl:call-template>
												</xsl:attribute>
											</IMG>
										</TD>
										<TD>
											<HR color="#800000"/>
										</TD>
									</TR>
									<TR id="virtual">
										<TD colspan="2">
											<TABLE cellspacing="0" cellpadding="0">
												<xsl:for-each select="TblAtt[ TblAttInf or (Attribute/FormulaDef and not(TblAttInf))]">
													<TR class="textoGrisTabla" >
														<xsl:apply-templates select="."/>
													</TR>
													<xsl:call-template name="EndRow"/>
												</xsl:for-each>
											</TABLE>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</xsl:if>

				</TABLE>
			</DIV>
		</DIV>
	</xsl:template>

	<!-- TblAttri TEMPLATE -->
	<xsl:template match="TblAtt">
		<xsl:variable name="ImageId">
			<xsl:call-template name="GetBmpAtt"/>
		</xsl:variable>
		<TD valign="top" width="2%">
			<xsl:if test="$ImageId != ''">
				<xsl:call-template name="RenderImage">
					<xsl:with-param name="Id">
						<xsl:value-of select="$ImageId"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</TD>
		<TD valign="top" width="15%">
			<xsl:apply-templates select="Attribute"/>
		</TD>
		<TD valign="top" width="25%">
			<xsl:value-of select="Attribute/AttriDesc"/>
		</TD>
		<TD valign="top" width="15%" noWrap="yes">
			<xsl:apply-templates select="Attribute/Type"/>
			<!--<xsl:if test="Attribute/Length">
				(<xsl:value-of select="Attribute/Length"/>
				<xsl:if test="Attribute/Decimals">.<xsl:value-of select="Attribute/Decimals"/></xsl:if>)
			</xsl:if>
		-->
			<xsl:if test="Attribute/Sign">
				<xsl:text>-</xsl:text>
			</xsl:if>
		</TD>
		<TD valign="top" align="left">
			<xsl:if test="Attribute/FormulaDef">
				<xsl:apply-templates select="Attribute/FormulaDef"/>
			</xsl:if>
		</TD>
		<TD valign="top">
			<!-- width="15%" -->
			<xsl:if test="Attribute/AttriSuper">
				<xsl:apply-templates select="Attribute/AttriSuper"/>
			</xsl:if>
		</TD>
	</xsl:template>

	<!-- Type TEMPLATE -->
	<xsl:template match="Type">
		<xsl:value-of select="."/>
		<xsl:if test="../Length">
			(
			<xsl:value-of select="../Length"/>
			<xsl:if test="../Decimals">
				.<xsl:value-of select="../Decimals"/>
			</xsl:if>
			)
		</xsl:if>
		<xsl:if test="../MaxLen">
			(<xsl:value-of select="../MaxLen"/>)
		</xsl:if>
		<xsl:if test="../DateLen">
			(
			<xsl:value-of select="../DateLen"/>.<xsl:value-of select="../TimeLen"/>
			)
		</xsl:if>
	</xsl:template>

	<!-- SubtypeOf TEMPLATE -->
	<xsl:template match="SubtypeOf">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- TblAssocDView -->
	<xsl:template match="TblAssocDView">
		<xsl:apply-templates select="Object" mode="icon"/>
	</xsl:template>

	<!-- SubToTbls TEMPLATE -->
	<xsl:template match="SubToTbls">
		<xsl:call-template name="GenerateTable">
			<xsl:with-param name="ID">SubOfTbls</xsl:with-param>
			<xsl:with-param name="Title">Subordinated To</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- SupOfTbls TEMPLATE -->
	<xsl:template match="SupOfTbls">
		<xsl:call-template name="GenerateTable">
			<xsl:with-param name="ID">SupOfTbls</xsl:with-param>
			<xsl:with-param name="Title">Superordinated To</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- TABLES TEMPLATE -->
	<xsl:template match="TblSubor" mode="TableRow">
		<TD>
			<xsl:apply-templates select="Table"/>
		</TD>
		<TD>
			<xsl:apply-templates select="TblSubBy"/>
		</TD>
	</xsl:template>

	<xsl:template match="TblSuper" mode="TableRow">
		<TD>
			<xsl:apply-templates select="Table"/>
		</TD>
		<TD>
			<xsl:apply-templates select="TblSupBy"/>
		</TD>
	</xsl:template>

	<!-- Prompts TEMPLATE -->
	<xsl:template match="TblPrompts">
		<DIV>
			<xsl:attribute name="id">prompts</xsl:attribute>
			<xsl:call-template name="TableHeader">
				<xsl:with-param name="title">Associated Prompts</xsl:with-param>
			</xsl:call-template>
			<DIV id="content">
				<TABLE width="100%" class="gxcontent" cellspacing="0" cellpadding="0">
					<xsl:for-each select="TblPrompt">
						<TR class="textoGrisTabla">
							<TD>
								<xsl:for-each select="Object/ObjCls">
									<!--
					<IMG align="absMiddle">
						<xsl:attribute name="src">
							<xsl:value-of select="/ObjSpecs/gxpath"/>gxxml/images/
							<xsl:call-template name="GetBmpPrompt">
								<xsl:with-param name="ClassId">
									<xsl:value-of select="."/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
					</IMG>
-->
								</xsl:for-each>
								<xsl:apply-templates select="Object" mode="icon"/>
							</TD>
						</TR>
					</xsl:for-each>
				</TABLE>
			</DIV>
		</DIV>
	</xsl:template>


	<!-- CKEYS TEMPLATE -->
	<xsl:template match="TblCKeys">
		<DIV>
			<xsl:attribute name="id">ckey</xsl:attribute>
			<xsl:call-template name="TableHeader">
				<xsl:with-param name="title">Candidate Keys</xsl:with-param>
			</xsl:call-template>
			<DIV id="content">
				<TABLE width="100%" >
					<THEAD>
						<TR class="subTitulosTabla">
							<TH align="left">Composition</TH>
						</TR>
					</THEAD>
					<xsl:apply-templates select="CKey"/>
				</TABLE>
			</DIV>
		</DIV>
	</xsl:template>

	<!-- CKEY TEMPLATE -->
	<xsl:template match="CKey">
		<xsl:if test="not(KeyIsPrimary)">
			<TR class="textoGrisTabla">
				<TD>
					<xsl:for-each select="Attribute">
						<xsl:if test="position() != 1">, </xsl:if>
						<xsl:apply-templates select="."/>
					</xsl:for-each>
				</TD>
			</TR>
		</xsl:if>
	</xsl:template>

	<!-- SATTS TEMPLATE -->
	<xsl:template match="TblSubBy|TblSupBy">
		<xsl:for-each select="Attribute">
			<xsl:if test="position() != 1">, </xsl:if>
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:template>

	<!-- IndexAtts TEMPLATE -->
	<xsl:template match="IdxAtts">
		<TABLE cellspacing="0" cellpadding="0">
			<TR class="textoGrisTabla">
				<TD noWrap="yes">
					<xsl:for-each select="IdxAtt">
						<xsl:if test="position() != 1">, </xsl:if>
						<xsl:apply-templates select="Attribute"/>
						<xsl:apply-templates select="IdxOrder"/>
					</xsl:for-each>
				</TD>
			</TR>
		</TABLE>
	</xsl:template>

	<xsl:template match="IdxOrder">
		<xsl:if test="text()[.='D']">
			<xsl:text> </xsl:text>
			<xsl:call-template name="RenderImage">
				<xsl:with-param name="Id">IdxDescending</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- TABLEIDXS TEMPLATE -->
	<xsl:template match="TblIdxs">
		<xsl:call-template name="GenerateTable">
			<xsl:with-param name="ID">ListTableIndices</xsl:with-param>
			<xsl:with-param name="Title">Indices</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- INDEX TEMPLATE -->
	<xsl:template match="Index" mode="TableRow">
		<TD>
			<xsl:value-of select="IdxName"/>
		</TD>
		<TD>
			<xsl:value-of select="IdxType"/>
		</TD>
		<TD nowrap="yes">
			<xsl:apply-templates select="IdxAtts"/>
		</TD>
	</xsl:template>

	<xsl:template match="text()|@*">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template name="GetBmpAtt">
		<xsl:choose>
			<xsl:when test="TblAttIsKey">
				Key
			</xsl:when>
			<xsl:when test="TblAttInf">
				Inferred
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="TblAttRed">
					Redundant
				</xsl:if>
				<xsl:if test="Attribute/FormulaDef">
					Formula
				</xsl:if>
				<xsl:choose>
					<xsl:when test="AllowNulls[text()='Yes']">
						Null
					</xsl:when>
					<xsl:when test="AllowNulls[text()='No']">
						Not Null
					</xsl:when>
					<xsl:otherwise>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- PropPart TEMPLATE -->
	<xsl:template match="PropPart">
		<xsl:call-template name="GenerateTable">
			<xsl:with-param name="ID">Properties</xsl:with-param>
			<xsl:with-param name="Title">Properties</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="OneProp" mode="TableRow">
		<td>
			<xsl:value-of select="Name"/>
		</td>
		<td>
			<xsl:value-of select="Value"/>
		</td>
	</xsl:template>
</xsl:stylesheet>
