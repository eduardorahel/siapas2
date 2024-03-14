<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output indent="no" />
	<xsl:include href="include.xsl"/>

	<xsl:template match="/">
		<html>
			<xsl:call-template name="HtmlHeader"/>
			<body bgcolor="#FFFFFF" text="#000000" link="#000000" alink="#000000" vlink="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
				<xsl:call-template name="HtmlScript"/>

				<form action="" id="FORM1" method="post" name="FORM1">
					<DIV>
						<TABLE width="100%">
							<xsl:for-each select="ObjSpecs/RowImport">
								<TR>
									<TD>
										<xsl:apply-templates select="."/>
									</TD>
								</TR>
							</xsl:for-each>
						</TABLE>
					</DIV>
				</form>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="Name">
		<SPAN class="gxobj">
			<xsl:choose>
				<xsl:when test="../Id and ../Id != 0">
					<xsl:attribute name="title">
						<xsl:value-of select="."/> : <xsl:value-of select="../Description"/>
					</xsl:attribute>
					<xsl:attribute name="onclick">
						try{gxopen(<xsl:value-of select="../Class"/>,<xsl:value-of select="../Id"/>)}
						catch(Exception){}
					</xsl:attribute>
					<xsl:attribute name="oncontextmenu">
						try{gxcontextmenu(<xsl:value-of select="../Class"/>,<xsl:value-of select="../Id"/>)}
						catch(Exception){}
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="../Class and ../Class = 9">
					<xsl:attribute name="class">gxobjnotexist</xsl:attribute>
					<xsl:attribute name="title">
						Model : <xsl:value-of select="."/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">gxobjnotexist</xsl:attribute>
					<xsl:attribute name="title">Invalid Object</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="."/>
		</SPAN>
	</xsl:template>

	<xsl:template match="Status">
		<FONT class="gxstatus">
			<xsl:call-template name="GetStatusDesc">
				<xsl:with-param name="Status">
					<xsl:value-of select="."/>
				</xsl:with-param>
			</xsl:call-template>
		</FONT>
	</xsl:template>

	<xsl:template match="RowImport">
		<DIV>
			<xsl:call-template name="TableHeaderMain">
				<xsl:with-param name="title">
					<xsl:call-template name="GetClsMappedName">
						<xsl:with-param name="Class">
							<xsl:value-of select="TypeName"/>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="TypeName">
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:apply-templates select="Name"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="Status"/>
				</xsl:with-param>
			</xsl:call-template>
			<DIV id="content">
				<TABLE border="0" cellPadding="0" cellSpacing="0" width="100%" class="textoGrisTabla">
					<TBODY>
						<TR>
							<TD width="25%">Name</TD>
							<TD>
								<EM>
									<xsl:apply-templates select="Name"/>
									<xsl:if test="Infos/OrigTblName">
										<B>
											Original Name : <xsl:value-of select="Infos/OrigTblName"/>
										</B>
									</xsl:if>
								</EM>
							</TD>
						</TR>
						<xsl:call-template name="EndRow"/>

						<TR>
							<TD>Description</TD>
							<TD>
								<EM>
									<xsl:value-of select="Description"/>
								</EM>
								<xsl:if test="Infos/OldObjName">
									(Old Description : <xsl:value-of select="Infos/OldObjName"/>)
								</xsl:if>
							</TD>
						</TR>
						<xsl:call-template name="EndRow"/>

						<xsl:if test="Infos/Folder">
							<TR>
								<TD width="25%">Folder</TD>
								<TD>
									<xsl:apply-templates select="Infos/Folder"/>
								</TD>
							</TR>
							<xsl:call-template name="EndRow"/>
						</xsl:if>
					</TBODY>
				</TABLE>
				<xsl:if test="Warnings/Warning|Infos/Message">
					<DIV>
						<xsl:call-template name="TableHeader">
							<xsl:with-param name="title">Info</xsl:with-param>
						</xsl:call-template>

						<DIV id="content">
							<TABLE class="textoGrisTabla" border="0" cellPadding="0" cellSpacing="0" width="100%" style="BORDER-BOTTOM: thin inset; BORDER-RIGHT: thin inset">
								<xsl:for-each select=".//Warning|.//Message">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</TABLE>
						</DIV>
					</DIV>
				</xsl:if>
				<xsl:if test="Errors/Error">
					<DIV>
						<xsl:call-template name="TableHeader">
							<xsl:with-param name="title">Errors</xsl:with-param>
						</xsl:call-template>
						<DIV id="content">
							<TABLE class="textoGrisTabla" border="0" cellPadding="0" cellSpacing="0" width="100%" style="BORDER-BOTTOM: thin inset; BORDER-RIGHT: thin inset">
								<xsl:for-each select=".//Error">
									<xsl:apply-templates select="."/>
								</xsl:for-each>
							</TABLE>
						</DIV>
					</DIV>
				</xsl:if>
			</DIV>
		</DIV>
	</xsl:template>

	<xsl:template match="Folder">
		<xsl:call-template name="RenderImage">
			<xsl:with-param name="Id">Folder</xsl:with-param>
		</xsl:call-template>
		<EM>
			<xsl:text> </xsl:text>
			<xsl:choose>
				<xsl:when test="text()[.!='']">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Main</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</EM>
		<xsl:if test="../OldFolder">
			(Old Folder : <xsl:value-of select="../OldFolder"/>)
		</xsl:if>
	</xsl:template>

	<xsl:template match="Warning">
		<tr class="textoWarn">
			<td valign="top" width="1%">
				<xsl:call-template name="RenderImage">
					<xsl:with-param name="Id">Warning</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<PRE style="font-family: Verdana" canHaveHTML="true">
					<B>
						<FONT class="textoWarn">
							<xsl:value-of select="."/>
						</FONT>
					</B>
				</PRE>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="Message">
		<tr class="textoMsg">
			<td valign="top" width="1%">
				<xsl:call-template name="RenderImage">
					<xsl:with-param name="Id">Message</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<PRE style="font-family: Verdana" canHaveHTML="true">
					<B>
						<FONT class="textoMsg">
							<xsl:value-of select="."/>
						</FONT>
					</B>
				</PRE>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match= "Error">
		<tr class="textoError">
			<td valign="top" width="1%">
				<xsl:call-template name="RenderImage">
					<xsl:with-param name="Id">Error</xsl:with-param>
				</xsl:call-template>
			</td>
			<td>
				<PRE style="font-family: Verdana" canHaveHTML="true">
					<B>
						<FONT class="textoError">
							<xsl:value-of select="."/>
						</FONT>
					</B>
				</PRE>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="Class">
		<IMG>
			<xsl:attribute name="src">
				<xsl:call-template name="GetClsNameImage">
					<xsl:with-param name="Class" select="."/>
					<xsl:with-param name="ImgPath" select="/ObjSpecs/gxpath"/>
				</xsl:call-template>
			</xsl:attribute>
		</IMG>
	</xsl:template>

	<xsl:template name="GetStatusDesc">
		<xsl:param name="Status"/>
		<xsl:choose>
			<xsl:when test="$Status='Error'">not imported</xsl:when>
			<xsl:when test="$Status='Warning' or $Status='Ok'">imported</xsl:when>
			<xsl:otherwise>Unknow Status</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
