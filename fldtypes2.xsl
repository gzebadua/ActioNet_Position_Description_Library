<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp" version="1.0" exclude-result-prefixes="xsl msxsl ddwrt" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:SharePoint="Microsoft.SharePoint.WebControls" xmlns:ddwrt2="urn:frontpage:internal" ddwrt:oob="true">
    <xsl:output method="html" indent="no"/>
  <xsl:template name="dvt_headerfield" ddwrt:dvt_mode="header">
    <xsl:param name="fieldname" />
    <xsl:param name="fieldtitle" />
    <xsl:param name="displayname"  />
    <xsl:param name="fieldtype" select="'0'"/>
    <xsl:variable name="separator" select="' '" />
    <xsl:variable name="connector" select="';'" />
    <xsl:variable name="linkdir">
      <xsl:choose>
        <xsl:when test="$dvt_sortfield = $fieldname and ($dvt_sortdir = 'ascending' or $dvt_sortdir = 'ASC')">Desc</xsl:when>
        <xsl:otherwise>Asc</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="jsescapeddisplayname">
      <xsl:call-template name="fixQuotes">
        <xsl:with-param name="string" select="$displayname"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="sortable">
      <xsl:choose>
        <xsl:when test="../../@BaseViewID='3' and ../../List/@TemplateType='106'">FALSE</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./@Sortable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$MasterVersion=4 and not($NoAJAX)">
        <div Sortable="{$sortable}" SortDisable="" FilterDisable="" Filterable="{@Filterable}" FilterDisableMessage="{@FilterDisableMessage}" name="{@Name}" CTXNum="{$ViewCounter}"
             DisplayName="{@DisplayName}" FieldType="{@FieldType}" ResultType="{@ResultType}" SortFields="{$RootFolderParam}{$FieldSortParam}SortField={@Name}&amp;SortDir={$linkdir}"
             class="ms-vh-div">
          <xsl:call-template name="headerfield">
            <xsl:with-param name="fieldname" select ="$fieldname" />
            <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
            <xsl:with-param name="displayname" select="$displayname" />
            <xsl:with-param name="fieldtype" select="$fieldtype"/>
          </xsl:call-template>
        </div>
      <!-- render the markup for view header chevron from server side if the view header field is sortable or filterable and fieldtype is not equal to certain type -->
      <!-- Make sure the test condition below is consistent with the functions IsFieldNotFilterable() and IsFieldNotSortable() in filter.jss -->
      <xsl:if test="(not($sortable='FALSE') and not(@FieldType='MultiChoice')) or (not(@Filterable='FALSE') and not(@FieldType='Note') and not(@FieldType='URL'))">
        <div class="s4-ctx">
          <span>&#160;</span>
            <a onfocus="OnChildColumn(this.parentNode.parentNode); return false;" onclick="PopMenuFromChevron(event); return false;" href="javascript:;" title="{$open_menu}">
            </a>
          <span>&#160;</span>
        </div>
      </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="style">padding:0 !important;border:0 !important;</xsl:attribute>
        <div style="width:100%;position:relative;left:0;top:0;margin:0;border:0">
          <xsl:choose>
            <xsl:when test="$NoAJAX">
              <table CtxNum="{$ViewCounter}" cellspacing="1" cellpadding="0" class="ms-unselectedtitle" name="{$fieldname}" DisplayName="{$displayname}" height="100%">
                <xsl:choose>
                  <xsl:when test="$MasterVersion=4">
                    <xsl:attribute name="style">width:100%;height:27px</xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="style">width:100%</xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$sortable='FALSE'">
                  <xsl:attribute name="Sortable">FALSE</xsl:attribute>
                </xsl:if>
                <xsl:if test="@Filterable='FALSE'">
                  <xsl:attribute name="Filterable">FALSE</xsl:attribute>
                </xsl:if>
                <xsl:if test="@FilterDisableMessage">
                  <xsl:attribute name="FilterDisableMessage">
                    <xsl:value-of select="@FilterDisableMessage" />
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="not($sortable='FALSE') or not(@Filterable='FALSE')">
                  <xsl:attribute name="onmouseover">
                    <xsl:text disable-output-escaping="yes">OnMouseOverAdHocFilter(this, '</xsl:text>
                    <xsl:value-of select="concat($jsescapeddisplayname,$separator,$fieldname, $separator,$fieldtype, $connector, $LCID, $separator, $WebPartClientID)" />
                    <xsl:text disable-output-escaping="yes">' , '', '')</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="SortFields"><xsl:value-of select="concat($RootFolderParam,$FieldSortParam,'SortField=',@Name,'&amp;SortDir=',$linkdir)"/></xsl:attribute>
                  <xsl:attribute name="FieldType"><xsl:value-of select="@FieldType"/></xsl:attribute>
                  <xsl:attribute name="ResultType"><xsl:value-of select="@ResultType"/></xsl:attribute>
                </xsl:if>
                <xsl:call-template name="headerFieldRow">
                  <xsl:with-param name="fieldname" select="$fieldname"/>
                  <xsl:with-param name="fieldtitle" select ="$fieldtitle"/>
                  <xsl:with-param name="displayname" select="$displayname"/>
                  <xsl:with-param name="fieldtype" select ="$fieldtype"/>
                </xsl:call-template>
              </table>
            </xsl:when>
            <xsl:otherwise>
              <table style="width:100%;" Sortable="{$sortable}" SortDisable="" FilterDisable="" Filterable="{@Filterable}" FilterDisableMessage="{@FilterDisableMessage}" name="{@Name}" CTXNum="{$ViewCounter}"
                 DisplayName="{@DisplayName}" FieldType="{@FieldType}" ResultType="{@ResultType}" SortFields="{$RootFolderParam}{$FieldSortParam}SortField={@Name}&amp;SortDir={$linkdir}"
                 height="100%" cellspacing="1" cellpadding="0" class="ms-unselectedtitle" onmouseover="OnMouseOverFilter(this)">
                <xsl:call-template name="headerFieldRow">
                  <xsl:with-param name="fieldname" select="$fieldname"/>
                  <xsl:with-param name="fieldtitle" select ="$fieldtitle"/>
                  <xsl:with-param name="displayname" select="$displayname"/>
                  <xsl:with-param name="fieldtype" select ="$fieldtype"/>
                </xsl:call-template>
              </table>
            </xsl:otherwise>
          </xsl:choose>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="headerFieldRow" ddwrt:dvt_mode="header">
    <xsl:param name="fieldname" />
    <xsl:param name="fieldtitle" />
    <xsl:param name="displayname"  />
    <xsl:param name="fieldtype" select="'0'"/>
    <tr>
      <td width="100%" class="ms-vb" nowrap="nowrap">
        <xsl:if test="$MasterVersion=4 and $NoAJAX">
          <xsl:attribute name="style">padding-left:0px;padding-top:5px</xsl:attribute>
        </xsl:if>
        <xsl:call-template name="headerfield">
          <xsl:with-param name="fieldname" select ="$fieldname" />
          <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
          <xsl:with-param name="displayname" select="$displayname" />
          <xsl:with-param name="fieldtype" select="$fieldtype"/>
        </xsl:call-template>
      </td>
      <td style="position:absolute;">
        <img src="/_layouts/images/blank.gif" width="13" style="visibility: hidden" alt="" />
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="headerfield" ddwrt:dvt_mode="header">
    <xsl:param name="fieldname" />
    <xsl:param name="fieldtitle" />
    <xsl:param name="displayname"  />
    <xsl:param name="fieldtype" select="'0'"/>
    <xsl:choose>
      <xsl:when test="$Filter='1'">
        <xsl:value-of select ="$Rows/@filter.render" disable-output-escaping ="yes"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="(@ImnHeader='TRUE') and ($PresenceEnabled='1')">
            <table cellpadding="0" cellspacing="0" dir="{$XmlDefinition/List/@Direction}">
              <tr>
                <td class="ms-imnImgTD">
                  <img border="0" valign="middle" height="12" width="12" altbase="{$idPresEnabled}" src="/_layouts/images/blank.gif" onload="IMNRegisterHeader(event)" id="imnhdr{position()}"/>
                </td>
                <td nowrap="nowrap" class="ms-vh ms-imnTxtTD">
                  <xsl:call-template name="FieldHeader">
                    <xsl:with-param name="fieldname" select="$fieldname"/>
                    <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
                    <xsl:with-param name="displayname" select="$displayname"/>
                    <xsl:with-param name="fieldtype" select="$fieldtype"/>
                  </xsl:call-template>
                </td>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$fieldtype='number'">
                <div align="right" class="ms-numHeader">
                  <xsl:call-template name="FieldHeader">
                    <xsl:with-param name="fieldname" select="$fieldname"/>
                    <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
                    <xsl:with-param name="displayname" select="$displayname"/>
                    <xsl:with-param name="fieldtype" select="$fieldtype"/>
                  </xsl:call-template>
                </div>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="FieldHeader">
                  <xsl:with-param name="fieldname" select="$fieldname"/>
                  <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
                  <xsl:with-param name="displayname" select="$displayname"/>
                  <xsl:with-param name="fieldtype" select="$fieldtype"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldHeader" ddwrt:dvt_mode="header">
    <xsl:param name="fieldname" />
    <xsl:param name="fieldtitle" />
    <xsl:param name="displayname" />
    <xsl:param name="fieldtype" select="'0'"/>
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="sortable">
      <xsl:choose>
        <xsl:when test="../../@BaseViewID='3' and ../../List/@TemplateType='106'">FALSE</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./@Sortable"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="not($sortable='FALSE')">
        <!-- sortable -->
        <xsl:variable name="sortfield">
          <xsl:choose>
            <xsl:when test="substring($fieldname, string-length($fieldname) - 5) = '(text)'">
              <xsl:value-of select="substring($fieldname, 1, string-length($fieldname) - 6)" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$fieldname"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="linkdir">
          <xsl:choose>
            <xsl:when test="$dvt_sortfield = $sortfield and ($dvt_sortdir = 'ascending' or $dvt_sortdir = 'ASC')">Desc</xsl:when>
            <xsl:otherwise>Asc</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sortText">
          <xsl:choose>
            <xsl:when test="$linkdir='Desc'">&apos; + &apos;descending&apos; + &apos;</xsl:when>
            <xsl:otherwise>&apos; + &apos;ascending&apos; + &apos;</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="jsescapeddisplayname">
          <xsl:call-template name="fixQuotes">
            <xsl:with-param name="string" select="$displayname"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="separator" select="' '" />
        <xsl:variable name="connector" select="';'" />
        <a id="diidSort{$fieldname}" onfocus="OnFocusFilter(this)">
          <xsl:attribute name="href">javascript: <xsl:if test="$NoAJAX">
              <xsl:call-template name="GenFireServerEvent">
                <xsl:with-param name="param" select="concat('dvt_sortfield={',$sortfield,'};dvt_sortdir={',$sortText,'}')"/>
                <xsl:with-param name="apos">'</xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:choose>
              <xsl:when test="not($NoAJAX)">javascript:return OnClickFilter(this,event);</xsl:when>
              <xsl:otherwise>javascript: <xsl:call-template name="GenFireServerEvent">
                  <xsl:with-param name="param" select="concat('dvt_sortfield={',$sortfield,'};dvt_sortdir={',$sortText,'}')"/>
                  <xsl:with-param name="apos">'</xsl:with-param>
                </xsl:call-template>; event.cancelBubble = true; return false;</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="not($NoAJAX)">
              <xsl:attribute name="SortingFields"><xsl:value-of select ="$RootFolderParam"/><xsl:value-of select ="$FieldSortParam"/>SortField=<xsl:value-of select="@Name"/>&amp;SortDir=<xsl:value-of select="$linkdir"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="FilterString"><xsl:value-of select="concat($jsescapeddisplayname,$separator,$fieldname, $separator,$fieldtype, $connector, $LCID, $separator, $WebPartClientID)" /></xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$fieldtype = 'Attachments'">
              <xsl:value-of select="$fieldtitle" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$fieldtitle"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="$dvt_sortfield = $sortfield">
            <xsl:choose>
              <xsl:when test="$dvt_sortdir = 'ascending'">
                <img border="0" alt="{$Rows/@viewedit_onetidSortAsc}" src="{ddwrt:FieldSortImageUrl('Desc')}" />
              </xsl:when>
              <xsl:when test="$dvt_sortdir = 'descending'">
                <img border="0" alt="{$Rows/@viewedit_onetidSortDesc}" src="{ddwrt:FieldSortImageUrl('Asc')}" />
              </xsl:when>
            </xsl:choose>
          </xsl:if>
          <img src="/_layouts/images/blank.gif" class="ms-hidden" border="0" width="1" height="1" alt=""/>
        </a>
        <img src="/_layouts/images/blank.gif" alt="" border="0"/>
        <xsl:choose>
          <xsl:when test="contains($dvt_filterfields, concat(';', $fieldname, ';' )) or contains($dvt_filterfields, concat(';@', $fieldname, ';' ))">
            <img src="/_layouts/images/filter.gif" border="0" alt="" />
          </xsl:when>
          <xsl:otherwise>
            <img src="/_layouts/images/blank.gif" border="0" alt=""/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="not(@Filterable='FALSE') and ($sortable='FALSE')">
        <xsl:choose>
          <xsl:when test="$fieldtype = 'Attachments'">
            <xsl:value-of select="$fieldtitle" disable-output-escaping="yes"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$fieldtitle"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="contains($dvt_filterfields, concat(';', $fieldname, ';' )) or contains($dvt_filterfields, concat(';@', $fieldname, ';' ))">
          <img src="/_layouts/images/filter.gif" border="0" alt="" />
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <!-- neither sortable nor filterable-->
        <xsl:choose>
          <xsl:when test="$fieldtype = 'Attachments'">
            <xsl:value-of select="$fieldtitle" disable-output-escaping="yes"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$fieldtitle"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="($fieldtype='BusinessData') and not($XmlDefinition/List/@ExternalDataList='1')">
      <a style="padding-left:2px;padding-right:12px" onmouseover="" onclick="GoToLink(this);return false;"
        href="{$HttpVDir}/_layouts/BusinessDataSynchronizer.aspx?ListId={$List}&amp;ColumnName={$fieldname}">
        <img border="0" src="/_layouts/images/bdupdate.gif" alt="{$Rows/@resource.wss.BusinessDataField_UpdateImageAlt}" title="{$Rows/@resource.wss.BusinessDataField_UpdateImageAlt}"/>
      </a>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_Menu_PrintFieldWithECB" ddwrt:ECB="Menu" match="FieldRef[@ListItemMenu]" mode="PrintFieldWithECB" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="PermMask">
      <xsl:choose>
        <xsl:when test="$thisNode/@PermMask != ''"><xsl:value-of select="$thisNode/@PermMask"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$ExternalDataListPermissions"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$EcbMode or $NoAJAX">
        <xsl:choose>
          <xsl:when test="$MasterVersion=4">
            <!-- Client JS uses 'itx' string to decide whether to create AJAX menu or not -->
            <!-- If AJAX is enabled, then we must include the 'itx' string at the end of the class -->
            <xsl:variable name="ClassName">
              <xsl:choose>
                <xsl:when test="$NoAJAX or $EcbMode">ms-vb</xsl:when>
                <xsl:otherwise>ms-vb itx</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <div class="{$ClassName}" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$ID}" Field="{@Name}"
              Url="{$thisNode/@FileRef.urlencodeasurl}" DRef="{$thisNode/@FileDirRef}" Perm="{$PermMask}" Type="{$thisNode/@HTML_x0020_File_x0020_Type}"
              Ext="{$thisNode/@File_x0020_Type}"
              OType="{$thisNode/@FSObjType}"
              COUId="{$thisNode/@CheckedOutUserId}" HCD="{$thisNode/@_HasCopyDestinations.value}"
              CSrc="{$thisNode/@_CopySource}" MS="{$thisNode/@_ModerationStatus.}" CType="{$thisNode/@ContentType}"
              CId="{$thisNode/@ContentTypeId}" UIS="{$thisNode/@_UIVersion}" SUrl="{$thisNode/@_SourceUrl}"
              Icon="{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapall}"
              EventType="{$thisNode/@EventType}">
              <xsl:if test="$IsDocLib">
                <xsl:attribute name="sred">
                  <xsl:value-of select="$thisNode/@serverurl.progid"/>
                </xsl:attribute>
                <xsl:attribute name="defaultio">
                  <xsl:value-of select="$XmlDefinition/List/@DefaultItemOpen"/>
                </xsl:attribute>
                <xsl:attribute name="cout">
                  <xsl:value-of select="$thisNode/@IsCheckedoutToLocal"/>
                </xsl:attribute>
              </xsl:if>
              <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                <xsl:with-param name="thisNode" select="$thisNode" />
                <xsl:with-param name="Position" select="$Position" />
              </xsl:apply-templates>
            </div>
            <!-- render the markup for list item chevron from server side -->
            <div class="s4-ctx" onmouseover="OnChildItem(this.parentNode); return false;">
              <span>&#160;</span>
              <a onfocus="OnChildItem(this.parentNode.parentNode); return false;" onclick="PopMenuFromChevron(event); return false;" href="javascript:;" title="{$open_menu}">
              </a>
              <span>&#160;</span>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <table height="100%" cellspacing="0" class="ms-unselectedtitle" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$ID}"
             Url="{$thisNode/@FileRef.urlencodeasurl}" DRef="{$thisNode/@FileDirRef}" Perm="{$PermMask}" Type="{$thisNode/@HTML_x0020_File_x0020_Type}"
             Ext="{$thisNode/@File_x0020_Type}"
             OType="{$thisNode/@FSObjType}"
             COUId="{$thisNode/@CheckedOutUserId}" HCD="{$thisNode/@_HasCopyDestinations.value}"
             CSrc="{$thisNode/@_CopySource}" MS="{$thisNode/@_ModerationStatus.}" CType="{$thisNode/@ContentType}"
             CId="{$thisNode/@ContentTypeId}" UIS="{$thisNode/@_UIVersion}" SUrl="{$thisNode/@_SourceUrl}"
             DocIcon="{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapall}"
             EventType="{$thisNode/@EventType}">
              <xsl:if test="$IsDocLib">
                <xsl:attribute name="sred">
                  <xsl:value-of select="$thisNode/@serverurl.progid"/>
                </xsl:attribute>
                <xsl:attribute name="defaultio">
                  <xsl:value-of select="$XmlDefinition/List/@DefaultItemOpen"/>
                </xsl:attribute>
                <xsl:attribute name="cout">
                  <xsl:value-of select="$thisNode/@IsCheckedoutToLocal"/>
                </xsl:attribute>
              </xsl:if>
              <tr>
                <td width="100%" class="ms-vb">
                  <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                    <xsl:with-param name="thisNode" select="$thisNode" />
                    <xsl:with-param name="Position" select="$Position" />
                  </xsl:apply-templates>
                </td>
                <td>
                  <img src="/_layouts/images/blank.gif" width="13" style="visibility:hidden" alt="" />
                </td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$MasterVersion=4">
            <div class="ms-vb itx" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$ID}" Field="{@Name}" Perm="{$PermMask}" EventType="{$thisNode/@EventType}">
              <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                <xsl:with-param name="thisNode" select="$thisNode" />
                <xsl:with-param name="Position" select="$Position" />
              </xsl:apply-templates>
            </div>
            <!-- render the markup for list item chevron from server side -->
            <div class="s4-ctx" onmouseover="OnChildItem(this.parentNode); return false;">
              <span>&#160;</span>
              <a onfocus="OnChildItem(this.parentNode.parentNode); return false;" onclick="PopMenuFromChevron(event); return false;" href="javascript:;" title="{$open_menu}">
              </a>
              <span>&#160;</span>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <table height="100%" cellspacing="0" class="ms-unselectedtitle itx" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$ID}" Field="{@Name}" Perm="{$PermMask}" EventType="{$thisNode/@EventType}">
              <tr>
                <td width="100%" class="ms-vb">
                  <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                    <xsl:with-param name="thisNode" select="$thisNode" />
                    <xsl:with-param name="Position" select="$Position" />
                  </xsl:apply-templates>
                </td>
                <td>
                  <img src="/_layouts/images/blank.gif" width="13" style="visibility:hidden" alt="" ddwrt:insideECB=""/>
                </td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>  
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_NoMenu_PrintFieldWithECB" ddwrt:ECB="Menu" match="FieldRef" mode="PrintFieldWithECB" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="folderUrlAdditionalQueryString" select="''"/>
    <xsl:apply-templates mode="PrintFieldWithDisplayFormLink" select=".">
      <xsl:with-param name="thisNode" select="$thisNode" />
      <xsl:with-param name="Position" select="$Position" />
      <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template name="FieldRef_Ecb_PrintFieldWithDisplayFormLink" ddwrt:ECB="Link" match="FieldRef[@LinkToItem]" mode="PrintFieldWithDisplayFormLink" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <!-- This is a folder -->
        <xsl:variable name="FolderCTID">
          <xsl:value-of select="$PagePath" />?RootFolder=<xsl:value-of select="$thisNode/@FileRef.urlencode" /><xsl:value-of select="$ShowWebPart"/>&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$IsDocLib">
            <a href="{$FolderCTID}" onmousedown="VerifyFolderHref(this, event, '{$thisNode/@File_x0020_Type.url}','{$thisNode/@File_x0020_Type.progid}','{$XmlDefinition/List/@DefaultItemOpen}', '{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}', '{$thisNode/@HTML_x0020_File_x0020_Type}', '{$thisNode/@serverurl.progid}')" 
               onclick="return HandleFolder(this,event,'{$PagePath}?RootFolder=' + escapeProperly('{$thisNode/@FileRef}') + '{$ShowWebPart}&amp;FolderCTID={$thisNode/@ContentTypeId}&amp;View={$View}','TRUE','FALSE','{$thisNode/@File_x0020_Type.url}','{$thisNode/@File_x0020_Type.progid}','{$XmlDefinition/List/@DefaultItemOpen}','{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','{$thisNode/@HTML_x0020_File_x0020_Type}','{$thisNode/@serverurl.progid}','{$thisNode/@CheckoutUser.id}','{$Userid}','{$XmlDefinition/List/@ForceCheckout}','{$thisNode/@IsCheckedoutToLocal}','{$thisNode/@PermMask}');">
              <xsl:call-template name="FieldRef_PrintField">
                <xsl:with-param name="thisNode" select="$thisNode" />
                <xsl:with-param name="Position" select="$Position" />
              </xsl:call-template>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <a href="{$FolderCTID}" onclick="javascript:EnterFolder(event, '{$PagePath}?RootFolder=' + escapeProperly('{$thisNode/@FileRef}') + '{$ShowWebPart}&amp;FoldeCTID={$thisNode/@ContentTypeId}&amp;View={$View}');return false;" target="_self">
              <xsl:call-template name="FieldRef_PrintField">
                <xsl:with-param name="thisNode" select="$thisNode" />
                <xsl:with-param name="Position" select="$Position" />
              </xsl:call-template>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <a onfocus="OnLink(this)" href="{$FORM_DISPLAY}&amp;ID={$ID}" onclick="EditLink2(this,{$ViewCounter});return false;" target="_self">
          <xsl:call-template name="FieldRef_PrintField">
            <xsl:with-param name="thisNode" select="$thisNode" />
            <xsl:with-param name="Position" select="$Position" />
          </xsl:call-template>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_NoEcb_PrintFieldWithDisplayFormLink" ddwrt:ECB="Link" match="FieldRef" mode="PrintFieldWithDisplayFormLink" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="folderUrlAdditionalQueryString"/>
    <xsl:call-template name="FieldRef_PrintField">
      <xsl:with-param name="thisNode" select="$thisNode" />
      <xsl:with-param name="Position" select="$Position" />
      <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="FieldRef_PrintField" match="FieldRef" mode="PrintField" ddwrt:dvt_mode="body" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="folderUrlAdditionalQueryString"/>
    <xsl:choose>
      <xsl:when test="@Direction">
        <span dir="{@Direction}">
          <xsl:call-template name="PrintField">
            <xsl:with-param name="thisNode" select="$thisNode" />
            <xsl:with-param name="Position" select="$Position" />
            <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
          </xsl:call-template>
        </span>
      </xsl:when>
      <xsl:otherwise>
         <xsl:call-template name="PrintField">
          <xsl:with-param name="thisNode" select="$thisNode" />
          <xsl:with-param name="Position" select="$Position" />
          <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="PrintField" ddwrt:dvt_mode="body" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Type" select="string(@Type)"/>
    <xsl:param name="Name" select="string(@Name)"/>
    <xsl:param name="folderUrlAdditionalQueryString"/>
    <xsl:choose>
      <xsl:when test="$Type='DateTime'">
        <xsl:apply-templates select="." mode="DateTime_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Computed'">
        <xsl:choose>
          <xsl:when test="$Name='LinkTitle' or $Name='LinkTitleNoMenu'">
            <xsl:apply-templates select="." mode="Computed_LinkTitle_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='LinkFilename' or $Name='LinkFilenameNoMenu'">
            <xsl:apply-templates select="." mode="Computed_LinkFilename_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='DocIcon'">
            <xsl:apply-templates select="." mode="Computed_DocIcon_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
              <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='NameOrTitle'">
            <xsl:apply-templates select="." mode="Computed_NameOrTitle_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='URLwMenu'">
            <xsl:apply-templates select="." mode="Computed_URLwMenu_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='HealthReportSeverityIcon'">
            <xsl:apply-templates select="." mode="Computed_HealthReportSeverityIcon_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='LinkDiscussionTitle' or $Name='LinkDiscussionTitleNoMenu'">
            <xsl:apply-templates select="." mode="Computed_LinkDiscussionTitle_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:when test="$Name='Threading' or $Name='BodyAndMore'">
            <xsl:apply-templates select="." mode="Computed_body">
              <xsl:with-param name="thisNode" select="$thisNode" />
              <xsl:with-param name="Position" select="$Position" />
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="." mode="Computed_body">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$Type='Attachments'">
        <xsl:apply-templates select="." mode="Attachments_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='User' or $Type='UserMulti'">
        <xsl:apply-templates select="." mode="User_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Note'">
        <xsl:apply-templates select="." mode="Note_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Text'">
        <xsl:apply-templates select="." mode="Text_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Number' or $Type='Currency'">
        <xsl:apply-templates select="." mode="Number_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Lookup' or $Type='LookupMulti' or $Type='WorkflowStatus'">
        <xsl:apply-templates select="." mode="Lookup_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='URL'">
        <xsl:apply-templates select="." mode="URL_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='CrossProjectLink'">
        <xsl:apply-templates select="." mode="CrossProjectLink_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='Recurrence'">
        <xsl:apply-templates select="." mode="Recurrence_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="$Type='AllDayEvent'">
        <xsl:apply-templates select="." mode="AllDayEvent_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="@CAMLRendering='TRUE'">
        <xsl:apply-templates select="." mode="CAMLRendering_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="CTXGeneration" ddwrt:ghost="always">
    <xsl:if test="$XmlDefinition/ViewFields/FieldRef[@FieldType='BusinessData']">
      <script src="/_layouts/wssactionmenu.js" />
      <script src="/_layouts/wsshtmlmenus.js" />
    </xsl:if>
    <xsl:if test="not($GroupingRender)">
    <script type="text/javascript">
      ctx = new ContextInfo();
      <xsl:if test="not($IsPostBack)">
        <xsl:text disable-output-escaping="yes">
      var existingHash = '';
      if(window.location.href.indexOf("#") > -1){
        existingHash = window.location.href.substr(window.location.href.indexOf("#"));
      }
      ctx.existingServerFilterHash = existingHash;
      if (ctx.existingServerFilterHash.indexOf("ServerFilter=") == 1) {
        ctx.existingServerFilterHash = ctx.existingServerFilterHash.replace(/-/g, '&amp;').replace(/&amp;&amp;/g, '-');
        var serverFilterRootFolder = GetUrlKeyValue("RootFolder", true,ctx.existingServerFilterHash);
        var currentRootFolder = GetUrlKeyValue("RootFolder", true);
        if("" == serverFilterRootFolder &amp;&amp; "" != currentRootFolder)
        {
          ctx.existingServerFilterHash += "&amp;RootFolder=" + currentRootFolder;
        }
        window.location.hash = '';
        window.location.search = '?' + ctx.existingServerFilterHash.substr("ServerFilter=".length + 1);
      }
        </xsl:text>
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@basetype">
          ctx.listBaseType = <xsl:value-of select="$XmlDefinition/List/@basetype" />;
      </xsl:if>
      <xsl:if test="$InlineEdit">
        ctx.InlineEdit = true;
      </xsl:if>
      <xsl:if test="$OverrideSelectCommand">
        ctx.overrideSelectCommand = "<xsl:value-of select="$OverrideSelectCommand" />";
      </xsl:if>
      <xsl:if test="$OverrideFilterQstring">
        ctx.overrideFilterQstring = "<xsl:value-of select="$OverrideFilterQstring" />";
      </xsl:if>
      <xsl:if test="$OverrideScope">
        ctx.overrideScope = "<xsl:value-of select="$OverrideScope" />";
      </xsl:if>
      <xsl:if test="$AddServerFilterOperationHash">
        <xsl:text disable-output-escaping="yes">
        if(typeof(browseris) != "undefined" &amp;&amp; (browseris.ie || browseris.safari)) {
          ctx.addedServerFilterHash = "ServerFilter=" + ctx.overrideFilterQstring;
          ctx.addedServerFilterHash = ctx.addedServerFilterHash.replace(/-/g, "--").replace(/&amp;/g, "-");
          window.location.hash = ctx.addedServerFilterHash;
        }
        </xsl:text>
      </xsl:if>
      ctx.NavigateForFormsPages = <xsl:choose>
        <xsl:when test="$NavigateForFormsPages='1'">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>;
      ctx.listTemplate = "<xsl:value-of select="$XmlDefinition/List/@TemplateType" />";
      ctx.listName = "<xsl:value-of select="$List" />";
      ctx.view = "<xsl:value-of select="$View"/>";
      ctx.listUrlDir = "<xsl:value-of select="$ListUrlDir" />";
      ctx.HttpPath = "<xsl:value-of select="$HttpPath" />";
      ctx.HttpRoot = "<xsl:value-of select="$HttpVDir" />";
      ctx.imagesPath = "/_layouts/images/";
      ctx.PortalUrl = "<xsl:value-of select="$XmlDefinition/List/@PortalUrl"/>";
      ctx.SendToLocationName = "<xsl:value-of select="$XmlDefinition/List/@SendToLocationName" />";
      ctx.SendToLocationUrl = "<xsl:value-of select="$XmlDefinition/List/@SendToLocationUrl" />";
      <xsl:choose>
        <xsl:when test="$XmlDefinition/List/@RecycleBinEnabled">
          ctx.RecycleBinEnabled = <xsl:value-of select="$XmlDefinition/List/@RecycleBinEnabled" />;
        </xsl:when>
        <xsl:otherwise>
          ctx.RecycleBinEnabled = 1;
        </xsl:otherwise>
      </xsl:choose>
      ctx.OfficialFileName = "<xsl:value-of select="$XmlDefinition/List/@OfficialFileName"/>";
      ctx.OfficialFileNames = "<xsl:value-of select="$XmlDefinition/List/@OfficialFileNames"/>";
      ctx.WriteSecurity = "<xsl:value-of select="$XmlDefinition/List/@WriteSecurity" />";
      ctx.SiteTitle = "<xsl:value-of select="$WebTitle"/>";
      ctx.ListTitle = "<xsl:value-of select="$ListTitle" />";
      if (ctx.PortalUrl == "") ctx.PortalUrl = null;
      ctx.displayFormUrl = "<xsl:value-of select="$FORM_DISPLAY" />";
      ctx.editFormUrl = "<xsl:value-of select="$FORM_EDIT" />";
      ctx.isWebEditorPreview = <xsl:choose>
        <xsl:when test="$WebEditorPreview='TRUE'">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>;
      ctx.ctxId = <xsl:value-of select="$ViewCounter"/>;
      ctx.isXslView = true;
      <xsl:if test="$NoAJAX">
        ctx.noAJAX = true;
      </xsl:if>
      if (g_ViewIdToViewCounterMap["<xsl:value-of select="$View" />"] == null)
          g_ViewIdToViewCounterMap["<xsl:value-of select="$View" />"]= <xsl:value-of select="$ViewCounter"/>;
      ctx.CurrentUserId = <xsl:value-of select="$Userid" />;
      <xsl:if test="$XmlDefinition/List/@moderatedlist='1'">
        ctx.isModerated = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@ForceCheckout='1'">
        ctx.isForceCheckout = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@EnableMinorVersions='1'">
        ctx.EnableMinorVersions = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@VersioningEnabled='1'">
        ctx.verEnabled = 1;
      </xsl:if>
      <xsl:if test="$RecursiveView='1'">
        ctx.recursiveView = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@WorkflowsAssociated='1'">
        ctx.WorkflowsAssociated = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@ExternalDataList='1'">
        ctx.ExternalDataList = true;
      </xsl:if>
      <xsl:if test="$XmlDefinition/List/@enablecontenttypes='1'">
        ctx.ContentTypesEnabled = true;
      </xsl:if>
      <xsl:if test="$HasRelatedCascadeLists='1'">
        ctx.HasRelatedCascadeLists = 1;
      </xsl:if>
      ctx<xsl:value-of select="$ViewCounter"/> = ctx;
      g_ctxDict['ctx<xsl:value-of select="$ViewCounter"/>'] = ctx;
    </script>
    <xsl:if test="$IsDocLib">
      <!-- doc lib-->
      <xsl:text disable-output-escaping="yes">&lt;script type=&quot;text/vbscript&quot;&gt;
    On Error Resume Next
    Set EditDocumentButton = CreateObject(&quot;SharePoint.OpenDocuments.3&quot;)
    If (IsObject(EditDocumentButton)) Then
        fNewDoc3 = true
    Else
        Set EditDocumentButton = CreateObject(&quot;SharePoint.OpenDocuments.2&quot;)
        If (IsObject(EditDocumentButton)) Then
            fNewDoc2 = true
        Else
            Set EditDocumentButton = CreateObject(&quot;SharePoint.OpenDocuments.1&quot;)
        End If
    End If    
    fNewDoc = IsObject(EditDocumentButton)
      &lt;/script&gt;
    </xsl:text>
    </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_header" ddwrt:dvt_mode="header" match="FieldRef" mode="header">
    <th nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="(@Type='User' or @Type='UserMulti') and ($PresenceEnabled='1')">ms-vh</xsl:when>
          <xsl:otherwise>ms-vh2</xsl:otherwise>
         </xsl:choose>
      </xsl:attribute>
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">
          <xsl:value-of select="@Name"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtitle">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="displayname">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtype">
          <xsl:choose>
            <xsl:when test="@Type='Number' or @Type='Currency'">number</xsl:when>
            <xsl:otherwise>x:string</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_DateTime_header" ddwrt:dvt_mode="header" match="FieldRef[@Type='DateTime']" mode="header">
    <th class="ms-vh2" nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">
          <xsl:value-of select="@Name"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtitle">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="displayname">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtype">x:datetime</xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template match="FieldRef[@FieldType='BusinessData']" mode="header" ddwrt:dvt_mode="header">
    <th class="ms-vh2" nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">
          <xsl:value-of select="@Name"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtitle">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="displayname">
          <xsl:value-of select="@DisplayName"/>
        </xsl:with-param>
        <xsl:with-param name="fieldtype">BusinessData</xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_Attachments_header" ddwrt:dvt_mode="header" match="FieldRef[@Type='Attachments']" mode="header">
    <th class="ms-vh-icon" nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">Attachments</xsl:with-param>
        <xsl:with-param name="fieldtitle">&lt;img border=&apos;0&apos; alt=&apos;<xsl:value-of select="$Rows/@resource.wss.lstsetng_attach"/>&apos; src=&apos;/_layouts/images/attachhd.gif&apos;/&gt;</xsl:with-param>
        <xsl:with-param name="displayname">Attachments</xsl:with-param>
        <xsl:with-param name="fieldtype">Attachments</xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_SelectedFlag_header" ddwrt:dvt_mode="header" match="FieldRef[@Name='SelectedFlag']" mode="header">
    <th nowrap="nowrap" scope="col" class="ms-vh3-nograd">
      <img id="diidHeaderImageSelectedFlag" alt="{$Rows/@Selection_Checkbox}" src="/_layouts/images/blank.gif" width="16" height="16" border="0"/>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_Recurrence_header" ddwrt:dvt_mode="header" match="FieldRef[@Type='Recurrence']" mode="header">
    <th class="ms-vh-icon" nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">fRecurrence</xsl:with-param>
        <xsl:with-param name="fieldtitle">&lt;IMG id=&quot;diidHeaderImagefRecurrence&quot; src=&quot;/_layouts/images/recurrence.gif&quot; width=&quot;16&quot; height=&quot;16&quot; border=&quot;0&quot; /&gt;</xsl:with-param>
        <xsl:with-param name="displayname">Recurrence</xsl:with-param>
        <xsl:with-param name="fieldtype">Attachments</xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_CrossProjectLink_header" ddwrt:dvt_mode="header" match="FieldRef[@Type='CrossProjectLink']" mode="header">
    <th class="ms-vh-icon" nowrap="nowrap" scope="col" onmouseover="OnChildColumn(this)">
      <xsl:call-template name="dvt_headerfield">
        <xsl:with-param name="fieldname">WorkspaceLink</xsl:with-param>
        <xsl:with-param name="fieldtitle">&lt;IMG id=&quot;diidHeaderImageWorkspaceLink&quot; src=&quot;/_layouts/images/mtgicnhd.gif&quot; width=&quot;16&quot; height=&quot;16&quot; border=&quot;0&quot; /&gt;</xsl:with-param>
        <xsl:with-param name="displayname">Workspace</xsl:with-param>
        <xsl:with-param name="fieldtype">Attachments</xsl:with-param>
      </xsl:call-template>
    </th>
  </xsl:template>
  <xsl:template name="FieldRef_body" ddwrt:dvt_mode="body" match="FieldRef" mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]"/>
  </xsl:template>
  <xsl:template match="FieldRef[@Encoded]" ddwrt:dvt_mode="body" mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping="yes" />
  </xsl:template>
  <xsl:template name="FieldRef_Attachments_body" ddwrt:dvt_mode="body" match="FieldRef" mode="Attachments_body">
    <xsl:param name="thisNode" select="."/>
      <xsl:if test="not ($thisNode/@Attachments='0')">
        <img border="0" src="/_layouts/images/attach.gif" alt="{$thisNode/../@resource.wss.fldtype_attachment_alttex}" title="{$thisNode/../@resource.wss.fldtype_attachment_alttex}" class="ms-vb-lvitemimg"/>
      </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_Note_body" ddwrt:dvt_mode="body" match="FieldRef" mode="Note_body">
    <xsl:param name="thisNode" select="."/>
    <div dir="{@Direction}" class="ms-rtestate-field">
      <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping="yes"/>
    </div>
  </xsl:template>
  <xsl:template name="EncodedAbsUrl">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType = '0'">
        <xsl:value-of select="$HttpHost"/>
        <xsl:value-of select="$thisNode/@FileRef"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$thisNode/@FileRef"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Thumbnail_body" ddwrt:dvt_mode="body" match="FieldRef[@Name='Thumbnail']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="url">
      <xsl:call-template name="EncodedAbsUrl">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$thisNode/@FSObjType='0'">
      <xsl:if test="not($thisNode/@ImageWidth='') and not($thisNode/@ImageWidth = '0')">
        <xsl:variable name="alt">
          <xsl:choose>
            <xsl:when test="not($thisNode/@Description='')">
              <xsl:value-of select="$thisNode/@Description"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$thisNode/../@resource.wss.Thunmbnail"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="src">
          <xsl:choose>
            <xsl:when test="string-length($thisNode/@AlternateThumbnailUrl) &gt; 0">
              <xsl:value-of select="substring-before($thisNode/@AlternateThumbnailUrl, ',')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$thisNode/@ThumbnailExists='1'">
                  <xsl:value-of select="$HttpHost"/><xsl:value-of select="ddwrt:UrlDirName($thisNode/@FileRef)"/>/_t/<xsl:value-of select="ddwrt:UrlBaseName($url)"/>_<xsl:value-of select="ddwrt:GetFileExtension($url)"/>.jpg
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="$thisNode/@ThumbnailExists='0'">
                      /_layouts/images/<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test="$thisNode/@ImageWidth=''">
                          /_layouts/images/<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$HttpHost"/><xsl:value-of select="ddwrt:UrlDirName($thisNode/@FileRef)"/>/_t/<xsl:value-of select="ddwrt:UrlBaseName($url)"/>_<xsl:value-of select="ddwrt:GetFileExtension($url)"/>.jpg
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <a href="{$FORM_DISPLAY}&amp;ID={$ID}">
          <img border="0" src="{$src}" alt="{$alt}"/>
        </a>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_ContentType_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='ContentType']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@ContentType"/>
  </xsl:template>
  <xsl:template name="FieldRef_ImageSize_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='ImageSize']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:if test="$thisNode/@FSObjType='0'">
      <xsl:if test="not($thisNode/@ImageWidth='') and not($thisNode/@ImageWidth = '0')">
        <span dir="ltr">
          <xsl:value-of select="$thisNode/@ImageWidth"/> x <xsl:value-of select="$thisNode/@ImageHeight"/>
        </span>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_Computed_NameOrTitle_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="Computed_NameOrTitle_body">
    <xsl:param name="thisNode" select="."/>
    <table cellspacing="0" class="ms-unselectedtitle" NameOrTitle="true" Url="{$thisNode/@FileRef}" DRef="{$thisNode/@FileDirRef}" COUId="{$thisNode/@CheckedOutUserId}"
            MS="{$thisNode/@_ModerationStatus.}" UIS="{$thisNode/@_UIVersion}" Perm="{$thisNode/@PermMask}" Type="{$thisNode/@HTML_x0020_File_x0020_Type}" 
            HCD="{$thisNode/@_HasCopyDestinations.value}" CSrc="{$thisNode/@_CopySource}" 
            Icon="{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapall}"
            FSObjType="{$thisNode/@FSObjType}" 
            Ext="{$thisNode/@File_x0020_Type}" cellpadding="0" msopnlid="data">
      <tr id="title{$thisNode/@ID}" onclick="if (!IsImgLibJssLoaded()) return; ClickRow({$thisNode/@ID})" 
        oncontextmenu="if (!IsImgLibJssLoaded()) return true; return ContextMenuOnRow({$thisNode/@ID});" 
        onmouseover="if (!IsImgLibJssLoaded()) return; MouseOverRow({$thisNode/@ID})" 
        onmouseout="if (!IsImgLibJssLoaded()) return; MouseOutRow({$thisNode/@ID})">
        <td class="ms-vb">
          <xsl:choose>
            <xsl:when test="$thisNode/@FSObjType='0'">
              <xsl:choose>
                <xsl:when test="$thisNode/@ImageWidth=''">
                  <a href="{$HttpHost}{$thisNode/@FileRef}" onclick="if (!IsImgLibJssLoaded()) return; javascript:DisplayItemOnFileRef({$thisNode/@ID});return false;" 
                    onmouseover="if (!IsImgLibJssLoaded()) return; javascript:MouseOverRow({$thisNode/@ID})" target="_self">
                    <xsl:value-of select="$thisNode/@FileLeafRef.Name" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}" onclick="if (!IsImgLibJssLoaded()) return; javascript:DisplayItemOnFileRef({$thisNode/@ID});return false;"
                    onmouseover="if (!IsImgLibJssLoaded()) return; javascript:MouseOverRow({$thisNode/@ID})" target="_self">
                      <xsl:value-of select="$thisNode/@FileLeafRef.Name" />
                  </a>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
                <xsl:call-template name="NewGif">
                  <xsl:with-param name="thisNode" select="$thisNode"/>
                </xsl:call-template>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$RecursiveView='1'">
                  <xsl:value-of select="$thisNode/@FileLeafRef" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="filterLink">
                    <xsl:choose>
                      <xsl:when test="starts-with($FilterLink, '?RootFolder=')">
                        <xsl:value-of select="substring-after($FilterLink, '&amp;')"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="substring($FilterLink, 2)"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <a href="{$PagePath}?RootFolder={$thisNode/@FileRef}&amp;{$filterLink}" target="_self">
                    <xsl:value-of select="$thisNode/@FileLeafRef" />
                  </a>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td class="ms-menuimagecell" style="visibility:hidden" width="10" id="menuTd{$thisNode/@ID}">
          <a id="menuHref{$thisNode/@ID}" href="javascript:ClickRow({$thisNode/@ID})" onclick="JavaScript:ClickRow({$thisNode/@ID}); JavaScript:return false;">
            <img border="0" width="13" src="/_layouts/images/menudark.gif" alt="{$thisNode/../@EditMenu}" />
          </a>
        </td>
      </tr>
    </table>
  </xsl:template >
  <xsl:template name="FieldRef_FileSizeDisplay_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='FileSizeDisplay']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:if test="$thisNode/@FSObjType='0'">
      <xsl:value-of select ="ceiling(number($thisNode/@File_x0020_Size) div 1024)"/> KB
    </xsl:if>
  </xsl:template>
  <xsl:template name="FileType_body" ddwrt:dvt_mode="body" match ="FieldRef[@ID='c53a03f3-f930-4ef2-b166-e0f2210c13c0']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select ="$thisNode/@File_x0020_Type"/>
  </xsl:template>
  <xsl:template name="FieldRef_CrossProjectLink_body" ddwrt:dvt_mode="body" match="FieldRef" mode="CrossProjectLink_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="not($thisNode/@WorkspaceLink='1' or $thisNode/@WorkspaceLink='-1')">
        <img border="0" width="16" height="16" src="/_layouts/images/blank.gif" />
      </xsl:when>
      <xsl:otherwise>
        <a href="{$thisNode/@Workspace}" target="_self" title="{$thisNode/../@resource.wss.Meeting_Workspace}">
          <img border="0" src="/_layouts/images/mtgicon.gif" alt="{$thisNode/../@resource.wss.Meeting_Workspace}"/>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef" name="FieldRef_AllDayEvent_body" ddwrt:dvt_mode="body" mode="AllDayEvent_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="stringYes" select="$thisNode/../@resource.wss.fld_yes"/>
    <xsl:if test="$thisNode/@*[name()=current()/@Name] = $stringYes">
      <xsl:value-of select="$stringYes"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_Recurrence_body" ddwrt:dvt_mode="body" match="FieldRef" mode="Recurrence_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="fRecurrence" select="$thisNode/@*[name()=current()/@Name]"/>
    <xsl:variable name="src">/_layouts/images/<xsl:choose>
        <xsl:when test="$fRecurrence='1'">
          <xsl:choose>
            <xsl:when test="$thisNode/@EventType='3'">recurEx.gif</xsl:when>
            <xsl:when test="$thisNode/@EventType='4'">recurEx.gif</xsl:when>
            <xsl:otherwise>recur.gif</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>blank.gif</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="alt">
      <xsl:if test="$fRecurrence='1'">
        <xsl:choose>
          <xsl:when test="@EventType='3'">
            <xsl:value-of select="$thisNode/../@resource.wss.fldtype_recurexceptimg_alttext"/>
          </xsl:when>
          <xsl:when test="@EventType='4'">
            <xsl:value-of select="$thisNode/../@resource.wss.fldtype_recurexceptimg_alttext"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$thisNode/../@resource.wss.fldtype_recurimg_alttext"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:variable>
    <img border="0" width="16" height="16" src="{$src}" alt="{$alt}" title="{$alt}"/>
  </xsl:template>
  <xsl:template name="FieldRef_SelectedFlag_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='SelectedFlag']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:if test="$thisNode/@FSObjType='0'">
      <script>
        fSelectFieldAppeared = true; firstIdWithCheckbox ='<xsl:value-of select="$ID"/>'
      </script>
      <input type="checkbox" disabled="" style="visibility:hidden" title='{$thisNode/../@Selection_Checkbox}' name="selectionCheckBox" id="cbx_{$ID}"
             onfocus="if (!IsImgLibJssLoaded()) return; HiLiteRow({$ID})" onclick="if (!IsImgLibJssLoaded()) return; ToggleSelection({$ID})"/>
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_Completed_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='Completed']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$thisNode/@_Level = '1'">
        <xsl:value-of select="$thisNode/../@resource.wss.fld_yes"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$thisNode/../@resource.wss.fld_no"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_DisplayResponse_body" ddwrt:dvt_mode="body" match="FieldRef[@Name='DisplayResponse']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$FreeForm = 1">
        <xsl:call-template name="DisplayResponseNoMenu">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$MasterVersion=4 and not($NoAJAX)">
              <xsl:call-template name="DisplayResponseNoMenu">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:call-template>
          </xsl:when>
          <xsl:when test="$NoAJAX">
            <table height="100%" cellspacing="0" class="ms-unselectedtitle" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$thisNode/@ID}"
             Url="{$thisNode/@FileRef}" DRef="{$thisNode/@FileDirRef}" Perm="{$thisNode/@PermMask}" Type="{$thisNode/@HTML_x0020_File_x0020_Type}"
             Ext="{$thisNode/@File_x0020_Type}"
             OType="{$thisNode/@FSObjType}"
             COUId="{$thisNode/@CheckedOutUserId}" HCD="{$thisNode/@_HasCopyDestinations.value}"
             CSrc="{$thisNode/@_CopySource}" MS="{$thisNode/@_ModerationStatus.}" CType="{$thisNode/@ContentType}"
             CId="{$thisNode/@ContentTypeId}" UIS="{$thisNode/@_UIVersion}" SUrl="{$thisNode/@_SourceUrl}">
              <tr>
                <td width="100%" class="ms-vb">
                  <xsl:call-template name="DisplayResponseNoMenu">
                    <xsl:with-param name="thisNode" select="$thisNode"/>
                  </xsl:call-template>
                </td>
                <td>
                  <img src="/_layouts/images/blank.gif" width="13" style="visibility:hidden" alt="" />
                </td>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <table height="100%" cellspacing="0" class="ms-unselectedtitle itx" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$thisNode/@ID}">
              <tr>
                <td width="100%" class="ms-vb">
                  <xsl:call-template name="DisplayResponseNoMenu">
                    <xsl:with-param name="thisNode" select="$thisNode"/>
                  </xsl:call-template>
                </td>
                <td>
                  <img src="/_layouts/images/blank.gif" width="13" style="visibility:hidden" alt="" />
                </td>
              </tr>
            </table>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="DisplayResponseNoMenu" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <a onfocus="OnLink(this)" href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}" onclick="GoToLink(this);return false;" target="_self" id="onetidViewResponse">
      <xsl:value-of select="$Rows/@resource.wss.View_Response"/> #<xsl:value-of select="$thisNode/@ID"/>
    </a>
  </xsl:template>
  <xsl:template name="GetFolderIconSourcePath">
    <xsl:param name="thisNode"/>
    <xsl:variable name="mapico" select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico"/>
    <xsl:choose>
      <xsl:when test="$mapico=''">/_layouts/images/folder.gif</xsl:when>
      <xsl:otherwise>/_layouts/images/<xsl:value-of select="$mapico"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Computed_DocIcon_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="Computed_DocIcon_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="folderUrlAdditionalQueryString" select="''"/>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <xsl:variable name="alttext">
          <xsl:choose>
            <xsl:when test="starts-with($thisNode/@ContentTypeId, &quot;0x0120D5&quot;)">
              <xsl:value-of select="$thisNode/../@itemname_documentset"/>: <xsl:value-of select="$thisNode/@FileLeafRef"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$thisNode/../@listformtitle_folder"/>: <xsl:value-of select="$thisNode/@FileLeafRef"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="mapico" select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico"/>
        <xsl:variable name="folderIconPath">
          <xsl:call-template name="GetFolderIconSourcePath">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- This is a folder -->
        <xsl:choose>
          <xsl:when test="$RecursiveView='1'">
            <img border="0" alt="{$alttext}" src="{$folderIconPath}" />
            <xsl:choose>
              <xsl:when test="$thisNode/@IconOverlay != ''">
                <img src="/_layouts/images/{$thisNode/@IconOverlay.mapoly}" class="ms-vb-icon-overlay" alt="" title="" />
              </xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="FolderCTID">
              <xsl:value-of select="$PagePathFinal" />RootFolder=<xsl:value-of select="$thisNode/@FileRef.urlencode" /><xsl:value-of select="$ShowWebPart"/>&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View"/><xsl:value-of select="$folderUrlAdditionalQueryString"/>
            </xsl:variable>
            <a href="{$FolderCTID}" onmousedown ="VerifyFolderHref(this, event, '{$thisNode/@File_x0020_Type.url}','{$thisNode/@File_x0020_Type.progid}','{$XmlDefinition/List/@DefaultItemOpen}', '{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}', '{$thisNode/@HTML_x0020_File_x0020_Type}', '{$thisNode/@serverurl.progid}')"
               onclick="return HandleFolder(this,event,&quot;{$PagePathFinal}RootFolder=&quot; + escapeProperly(&quot;{$thisNode/@FileRef}&quot;) + '{$ShowWebPart}&amp;FolderCTID={$thisNode/@ContentTypeId}&amp;View={$View}{$folderUrlAdditionalQueryString}','TRUE','FALSE','{$thisNode/@File_x0020_Type.url}','{$thisNode/@File_x0020_Type.progid}','{$XmlDefinition/List/@DefaultItemOpen}','{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','{$thisNode/@HTML_x0020_File_x0020_Type}','{$thisNode/@serverurl.progid}','{$thisNode/@CheckoutUser.id}','{$Userid}','{$XmlDefinition/List/@ForceCheckout}','{$thisNode/@IsCheckedoutToLocal}','{$thisNode/@PermMask}');">
              <img border="0" alt="{$alttext}" title="{$alttext}" src="{$folderIconPath}" />
              <xsl:choose>
                <xsl:when test="$thisNode/@IconOverlay != ''">
                  <img src="/_layouts/images/{$thisNode/@IconOverlay.mapoly}" class="ms-vb-icon-overlay" alt="" title="" />
                </xsl:when>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$IsDocLib">
            <!-- warning: this code has optimization in webpart. Change it must change the webpart code too!-->
              <xsl:choose>
                <xsl:when test="not ($thisNode/@IconOverlay) or $thisNode/@IconOverlay =''">
                    <xsl:choose>
                        <xsl:when test="not ($thisNode/@CheckoutUser.id) or $thisNode/@CheckoutUser.id =''">
                            <img border="0" alt="{$thisNode/@FileLeafRef}" title="{$thisNode/@FileLeafRef}" src="/_layouts/images/{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico}"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="alttext"><xsl:value-of select="$thisNode/@FileLeafRef"/><xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&#10;</xsl:text><xsl:value-of select="$thisNode/../@managecheckedoutfiles_header_checkedoutby"/>: <xsl:value-of select="$thisNode/@CheckoutUser.title"/></xsl:variable>
                            <img border="0" alt="{$alttext}" title="{$alttext}" src="/_layouts/images/{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico}" />
                            <img src="/_layouts/images/checkoutoverlay.gif" class="ms-vb-icon-overlay" alt="{$alttext}" title="{$alttext}" />                            
                        </xsl:otherwise>
                    </xsl:choose>                  
                </xsl:when>
                <xsl:otherwise >                  
                  <img border="0" alt="{$thisNode/@FileLeafRef}" title="{$thisNode/@FileLeafRef}" src="/_layouts/images/{$thisNode/@IconOverlay.mapico}" />
                  <img src="/_layouts/images/{$thisNode/@IconOverlay.mapoly}" class="ms-vb-icon-overlay" alt="" title="" />
                </xsl:otherwise>
              </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <img border="0" src="/_layouts/images/{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico}">
              <xsl:attribute name="alt">
                <xsl:value-of select="$thisNode/@Title"/>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:value-of select="$thisNode/@Title"/>
              </xsl:attribute>
            </img>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_DateTime_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="DateTime_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$FreeForm">
        <xsl:call-template name="FieldRef_ValueOf">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <nobr>
          <xsl:call-template name="FieldRef_ValueOf">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </nobr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_ValueOf" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]"/>
  </xsl:template>
  <xsl:template match="FieldRef" mode="CAMLRendering_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping ="yes"/>
  </xsl:template>
  <!-- Move this to the PrintField template when BusinessData becomes separate SPFieldType -->
  <xsl:template name="FieldRef_BusinessData_body" ddwrt:dvt_mode="body" match="FieldRef[@FieldType='BusinessData']" mode="Text_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$FreeForm">
        <xsl:apply-templates select="." mode="BusinessDataWSS_standaloneBody">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <nobr>
          <xsl:apply-templates select="." mode="BusinessDataWSS_standaloneBody">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:apply-templates>
        </nobr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="string-replace">
    <xsl:param name="inputString"/>
    <xsl:param name="oldString"/>
    <xsl:param name="newString"/>
    <xsl:choose>
      <xsl:when test="contains($inputString, $oldString)">
        <xsl:value-of select="substring-before($inputString, $oldString)"/>
        <xsl:value-of select="$newString"/>
        <xsl:call-template name="string-replace">
          <xsl:with-param name="inputString" select="substring-after($inputString, $oldString)"/>
          <xsl:with-param name="oldString" select="$oldString"/>
          <xsl:with-param name="newString" select="$newString"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$inputString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef" mode="BusinessDataWSS_standaloneBody" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="isExternalDataList" select="$EntityName != ''" />
    <xsl:variable name="fieldDefinition" select="$XmlDefinition/ViewFields/FieldRef[@Name=current()/@Name]"/>
    <xsl:variable name="fieldValue" select="$thisNode/@*[name()=current()/@Name]"/>
    <xsl:variable name="parentItemId">
      <xsl:if test="$isExternalDataList">
        <xsl:value-of select="$thisNode/@BdcIdentity"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="itemId">
      <xsl:if test="not($isExternalDataList)">
        <xsl:value-of select="$thisNode/@*[name()=$fieldDefinition/@RelatedField]"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="formattedFieldValue">
      <xsl:choose>
        <xsl:when test="$fieldValue=''"><!-- display "(blank)" if no value --><xsl:value-of select="$thisNode/../@resource.wss.BusinessDataField_Blank" /></xsl:when>
        <xsl:otherwise><xsl:value-of select="$fieldValue" /></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="($isExternalDataList) or ($itemId != '')">
        <table cellpadding="0" cellspacing="0" style="display=inline">
          <tr>
            <xsl:choose>
              <xsl:when test="$fieldDefinition/@HasActions = 'True'">
		<xsl:variable name="loadingMessage">
                  <xsl:call-template name="string-replace">
                    <xsl:with-param name="inputString" select="$thisNode/../@resource.wss.BusinessDataField_ActionMenuLoadingMessage"/>
                    <xsl:with-param name="oldString" select='"&apos;"'/>
                    <xsl:with-param name="newString" select='"\&apos;"'/>
                  </xsl:call-template>
                </xsl:variable> 
                <td><input type="hidden" name="BusinessDataField_ActionsMenuProxyPageWebUrl" id="BusinessDataField_ActionsMenuProxyPageWebUrl" value="{$HttpVDir}" />
                <div style="display=inline">
                  <table cellspacing="0">
                    <tr>
                      <td class="ms-vb" valign="top" nowrap="nowrap">
                        <span class="ms-SPLink ms-hovercellinactive" 
                          onmouseover="this.className='ms-SPLink ms-HoverCellActive';"
                          onmouseout="this.className='ms-SPLink ms-HoverCellInactive';">
                          <xsl:choose>
                            <xsl:when test="$isExternalDataList">
                              <a style="cursor:hand;white-space:nowrap;">
                                <img border="0" align="absmiddle" src="/_layouts/images/bizdataactionicon.gif" tabindex="0" alt="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}" title="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}"
                                  onclick="showActionMenuInExternalList('{$loadingMessage}',null,true,'{$LobSystemInstanceName}','{$EntityNamespace}','{$EntityName}','{$SpecificFinderName}','{$fieldDefinition/@AssociationName}','{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$parentItemId}', event)"
                                  onkeydown="actionMenuOnKeyDownInExternalList('{$loadingMessage}',null,true,'{$LobSystemInstanceName}','{$EntityNamespace}','{$EntityName}','{$SpecificFinderName}','{$fieldDefinition/@AssociationName}','{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$parentItemId}', event)" />
                              </a>
                              <a>
                                <img align="absmiddle" src="/_layouts/images/menudark.gif" tabindex="0" alt="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}"
                                  onclick="showActionMenuInExternalList('{$loadingMessage}',null,true,'{$LobSystemInstanceName}','{$EntityNamespace}','{$EntityName}','{$SpecificFinderName}','{$fieldDefinition/@AssociationName}','{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$parentItemId}', event)"
                                  onkeydown="actionMenuOnKeyDownInExternalList('{$loadingMessage}',null,true,'{$LobSystemInstanceName}','{$EntityNamespace}','{$EntityName}','{$SpecificFinderName}','{$fieldDefinition/@AssociationName}','{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$parentItemId}', event)" />
                              </a>
                            </xsl:when>
                            <xsl:otherwise>
                              <a style="cursor:hand;white-space:nowrap;">
                                <img border="0" align="absmiddle" src="/_layouts/images/bizdataactionicon.gif" tabindex="0" alt="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}" title="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}"
                                  onclick="showActionMenu('{$loadingMessage}',null,true,'{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$itemId}', event)"
                                  onkeydown="actionMenuOnKeyDown('{$loadingMessage}',null,true,'{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$itemId}', event)" />
                              </a>
                              <a>
                                <img align="absmiddle" src="/_layouts/images/menudark.gif" tabindex="0" alt="{$thisNode/../@resource.wss.BusinessDataField_ActionMenuAltText}"
                                  onclick="showActionMenu('{$loadingMessage}',null,true,'{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$itemId}', event)"
                                  onkeydown="actionMenuOnKeyDown('{$loadingMessage}',null,true,'{$fieldDefinition/@SystemInstanceName}','{$fieldDefinition/@EntityNamespace}','{$fieldDefinition/@EntityName}','{$itemId}', event)" />
                              </a>
                            </xsl:otherwise>
                          </xsl:choose>
                        </span>
                      </td>
                    </tr>
                  </table>
                </div>
                <!-- End of div for HtmlMenuButton -->
                <!-- Div for HtmlMenu -->
                <div STYLE="display=inline" />
                <!-- End of div for HtmlMenu -->
                </td>
              </xsl:when>
              <xsl:otherwise />
            </xsl:choose>
            <td class="ms-vb">
              <xsl:choose>
                <xsl:when test="($fieldDefinition/@Profile != '') and ($fieldDefinition/@ContainsDefaultAction = 'True')">
                  <a>
                    <xsl:attribute name="href">
                      <!-- Action Menu
                      -->
                      <xsl:choose>
                        <xsl:when test="$isExternalDataList">
                          <xsl:value-of select="$HttpVDir"/><xsl:value-of select="concat($fieldDefinition/@Profile, $parentItemId)"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$HttpVDir"/><xsl:value-of select="concat($fieldDefinition/@Profile, $itemId)"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                    <xsl:value-of select="$formattedFieldValue" />
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$formattedFieldValue" />
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
        </table>
      </xsl:when>
      <xsl:otherwise />
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Text_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="Text_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="@AutoHyperLink='TRUE' and @Name = 'Title'">
		<xsl:element name="a">
			<xsl:attribute name="href">
			    <xsl:text>http://zebaduag03644/SitePages/EditPD.aspx?ID=</xsl:text><xsl:value-of select="$thisNode/@ID" ></xsl:value-of>
			</xsl:attribute>
			<xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping ="yes" />
		</xsl:element>
      </xsl:when>
      <xsl:when test="@AutoHyperLink='TRUE'">
          <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping ="yes" />
      </xsl:when>
      <xsl:otherwise>
          <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_RepairDocument_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='RepairDocument']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <input id="chkRepair" type="checkbox" title="{$thisNode/../@Relink}" docID="{$thisNode/@ID}" />
  </xsl:template>
  <xsl:template name="FieldRef_Combine_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='Combine']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="url">
      <xsl:call-template name="EncodedAbsUrl">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$thisNode/@FSObjType='0'">
      <input id="chkCombine" type="checkbox" title="{$thisNode/../@resource.wss.Merge}" href="{$url}" />
      <input id="chkUrl" type="hidden" href="{$thisNode/@TemplateUrl}" />
      <!-- TemplateUrl -->
      <input id="chkProgID" type="hidden" href="{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}" />
    </xsl:if>
  </xsl:template>
  <xsl:template name="FieldRef_LinkIssueIDNoMenu_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='LinkIssueIDNoMenu']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <a href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}" onclick="EditLink2(this,{$ViewCounter});return false;" target="_self">
      <xsl:value-of select="$thisNode/@ID"/>
    </a>
  </xsl:template>
  <!-- ifhasrigth(2)-->
  <xsl:template name="IfHasRight" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="mask" select="$thisNode/@PermMask"/>
    <xsl:variable name="bit" select="substring($mask, string-length($mask))"/>
    <xsl:choose>
      <xsl:when test="$bit = '4' or $bit = '5' or $bit = '6' or $bit = '7' or 
                      $bit = 'C' or $bit = 'c' or $bit = 'D' or $bit = 'd' or $bit = 'E' or $bit = 'e' or $bit = 'F' or $bit = 'f'">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="EditRequiresCheckout" ddwrt:ghost="always">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="itemNotCheckedOut" select="not ($thisNode/@CheckoutUser.id) or $thisNode/@CheckoutUser.id =''"/>
    <xsl:choose>
      <xsl:when test="$XmlDefinition/List/@ForceCheckout='1' and $thisNode/@FSObjType != '1' and $itemNotCheckedOut">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Edit_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='Edit']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="hasRight">
      <xsl:call-template name="IfHasRight">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="requiresCheckout">
      <xsl:call-template name="EditRequiresCheckout">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$hasRight = '1'">
        <a href="{$FORM_EDIT}&amp;ID={$ID}" onclick="EditItemWithCheckoutAlert(event, '{$FORM_EDIT}&amp;ID={$ID}', '{$requiresCheckout}', '{$thisNode/@IsCheckedoutToLocal}', '{$thisNode/@FileRef.urlencode}', '{$HttpVDir}', '{$thisNode/@CheckedOutUserId}', '{$Userid}');return false;" target="_self">
          <img border="0" alt="{$thisNode/../@Edit}" src="/_layouts/images/edititem.gif"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_URLNoMenu_body" ddwrt:dvt_mode="body" match ="FieldRef[@Name='URLNoMenu']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="url" select="$thisNode/@URL" />
    <xsl:variable name="desc" select="$thisNode/@URL.desc" />
    <xsl:choose>
      <xsl:when test="$url=''">
        <xsl:value-of select="$desc" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@Format='Image'">
            <img onfocus="OnLink(this)" src="{$url}" alt="{$desc}" />
          </xsl:when>
          <xsl:otherwise>
            <a onfocus="OnLink(this)" href="{$url}">
              <xsl:choose>
                <xsl:when test="$desc=''">
                  <xsl:value-of select="$url" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$desc" />
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Computed_URLwMenu_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="Computed_URLwMenu_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <xsl:choose>
          <xsl:when test="$RecursiveView='1'">
            <xsl:value-of select="@FileLeafRef" />
          </xsl:when>
          <xsl:otherwise>
            <a onfocus="OnLink(this)" href="javascript:SubmitFormPost()"
               onclick="javascript:ClearSearchTerm(&quot;{$View}&quot;);ClearSearchTerm(&quot;&quot;);SubmitFormPost('{$PagePath}?RootFolder=' + escapeProperly(&quot;{$thisNode/@FileRef}&quot;) + '{$ShowWebPart}&amp;FolderCTID={$thisNode/@ContentTypeId}');return false;">
              <xsl:value-of select="$thisNode/@FileLeafRef" />
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="url" select="$thisNode/@URL" />
        <xsl:variable name="desc" select="$thisNode/@URL.desc" />
        <xsl:choose>
          <xsl:when test="$url=''">
            <xsl:value-of select="$desc" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@Format='Image'">
                <img onfocus="OnLink(this)" src="{$url}" alt="{$desc}" />
              </xsl:when>
              <xsl:otherwise>
                <a onfocus="OnLink(this)" href="{$url}">
                  <xsl:choose>
                    <xsl:when test="$desc=''">
                      <xsl:value-of disable-output-escaping="no" select="$url" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$desc" />
                    </xsl:otherwise>
                  </xsl:choose>
                </a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Computed_HealthReportSeverityIcon_body" ddwrt:dvt_mode="body" match ="FieldRef" mode="Computed_HealthReportSeverityIcon_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="severity" select="substring-before($thisNode/@HealthReportSeverity, ' - ')" />
    <xsl:choose>
      <xsl:when test="$severity='1'">
        <img src="/_layouts/images/hltherr.png" alt="{$severity}" />
      </xsl:when>
      <xsl:when test="$severity='2'">
        <img src="/_layouts/images/hlthwrn.png" alt="{$severity}" />
      </xsl:when>
      <xsl:when test="$severity='3'">
        <img src="/_layouts/images/hlthinfo.png" alt="{$severity}" />
      </xsl:when>
      <xsl:when test="$severity='4'">
        <img src="/_layouts/images/hlthsucc.png" alt="{$severity}" />
      </xsl:when>
      <xsl:otherwise>
        <img src="/_layouts/images/hlthfail.png" alt="{$severity}" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="ResolveId">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$EntityName != ''"><xsl:value-of select="$thisNode/@BdcIdentity"/></xsl:when>
      <xsl:when test="$thisNode/@EventType = 4"><xsl:value-of select="$thisNode/@ID"/>.1.<xsl:value-of select="$thisNode/@MasterSeriesItemID"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$thisNode/@ID"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="NewGif" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <img src="/_layouts/{$LCID}/images/new.gif" alt="{$NewGifAltString}" title="{$NewGifAltString}" class="ms-newgif" />
  </xsl:template>
  <xsl:template match="FieldRef[@Name='TitlewURL']" mode="Computed_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <a href="{$thisNode/@URL}"><xsl:value-of select="$thisNode/@Title"/></a>
  </xsl:template>
  <xsl:template name="FieldRef_TitlewMenu_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="url" select="$thisNode/@URL" />
    <xsl:variable name="desc" select="$thisNode/@URL.desc" />
    <xsl:choose>
      <xsl:when test="$url=''">
        <xsl:value-of select="$thisNode/@Title" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="@Format='Image'">
            <img onfocus="OnLink(this)" src="{$url}" alt="{$thisNode/@Title}"/>
          </xsl:when>
          <xsl:otherwise>
            <a onfocus="OnLink(this)" href="{$url}">
              <xsl:choose>
                <xsl:when test="@Title=''">
                  <xsl:value-of select="@desc"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$thisNode/@Title" />
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef[@Name='TitlewMenu']" mode="Computed_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$MasterVersion=4 and not($NoAJAX)">
        <div class="ms-vb itx" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$thisNode/@ID}" Field="{@Name}">
          <xsl:call-template name="FieldRef_TitlewMenu_body">
            <xsl:with-param name="thisNode" select="$thisNode" />
          </xsl:call-template>
        </div>
        <!-- render the markup for list item chevron from server side -->
        <div class="s4-ctx" onmouseover="OnChildItem(this.parentNode); return false;">
          <span>&#160;</span>
          <a onfocus="OnChildItem(this.parentNode.parentNode); return false;" onclick="PopMenuFromChevron(event); return false;" href="javascript:;" title="{$open_menu}">
          </a>
          <span>&#160;</span>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <table height="100%" cellspacing="0" class="ms-unselectedtitle itx" onmouseover="OnItem(this)" CTXName="ctx{$ViewCounter}" id="{$thisNode/@ID}">
          <tr>
            <td width="100%" class="ms-vb">
              <xsl:call-template name="FieldRef_TitlewMenu_body">
                <xsl:with-param name="thisNode" select="$thisNode" />
              </xsl:call-template>
            </td>
            <td>
              <img src="/_layouts/images/blank.gif" width="13" style="visibility:hidden" alt="" />
            </td>
          </tr>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef" name="LinkTitleNoMenu" mode="Computed_LinkTitle_body" ddwrt:tag="a" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="ShowAccessibleIcon" select="0"/>
    <xsl:param name="folderUrlAdditionalQueryString" select="''"/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <xsl:call-template name="LinkFilenameNoMenu">
          <xsl:with-param name="thisNode" select="$thisNode"/>
          <xsl:with-param name="folderUrlAdditionalQueryString" select="$folderUrlAdditionalQueryString"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- for blog post list, view item opened a new page, not in dialog even in v4 -->
        <xsl:choose>
              <xsl:when test="$XmlDefinition/List/@TemplateType != 301">
                  <a onfocus="OnLink(this)" href="{$FORM_DISPLAY}&amp;ID={$ID}&amp;ContentTypeID={$thisNode/@ContentTypeId}" onclick="EditLink2(this,{$ViewCounter});return false;" target="_self">
                      <xsl:call-template name="LinkTitleValue">
                        <xsl:with-param name="thisNode" select="$thisNode"/>
                        <xsl:with-param name="ShowAccessibleIcon" select="$ShowAccessibleIcon"/>
                     </xsl:call-template>
                  </a>
              </xsl:when>
              <xsl:otherwise>
                    <a onfocus="OnLink(this)" href="{$FORM_DISPLAY}&amp;ID={$ID}" onclick="GoToLink(this);return false;" target="_self">
                      <xsl:call-template name="LinkTitleValue">
                        <xsl:with-param name="thisNode" select="$thisNode"/>
                        <xsl:with-param name="ShowAccessibleIcon" select="$ShowAccessibleIcon"/>
                     </xsl:call-template>
                  </a>
              </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
          <xsl:call-template name="NewGif">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="LinkTitleValue" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="ShowAccessibleIcon" select="0"/>
    <xsl:variable name="titlevalue" select="$thisNode/@Title"/>
    <xsl:choose>
      <xsl:when test="$titlevalue=''">
        <xsl:value-of select="$Rows/@resource.wss.NoTitle"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$HasTitleField">
            <!-- if it's also at top level, it's already encoded, decode it.-->
            <xsl:value-of disable-output-escaping="yes" select="$titlevalue" />
          </xsl:when>
          <xsl:otherwise>
            <a href="#">
              <xsl:value-of select="$titlevalue" />
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$ShowAccessibleIcon">
        <img src="/_layouts/images/blank.gif" class="ms-hidden" border="0" width="1" height="1" alt="{$idPresEnabled}" />
      </xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef" name="LinkFilenameNoMenu" mode="Computed_LinkFilename_body" ddwrt:tag="a" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="ShowAccessibleIcon" select="0"/>
    <xsl:param name="folderUrlAdditionalQueryString"/>
    <xsl:param name="IncludeOnClick" select="1"/>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <xsl:choose>
          <xsl:when test="$RecursiveView">
            <xsl:value-of select="$thisNode/@FileLeafRef" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="FolderURL">
              <xsl:value-of select="$PagePathFinal" />RootFolder=<xsl:value-of select="$thisNode/@FileRef.urlencode" /><xsl:value-of select="$ShowWebPart"/>&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View"/><xsl:value-of select="$folderUrlAdditionalQueryString"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$IsDocLib">
                <xsl:variable name="OnMouseDownJS">
                  javascript:VerifyFolderHref(this,event,'<xsl:value-of select="$thisNode/@File_x0020_Type.url" />','<xsl:value-of select="$thisNode/@File_x0020_Type.progid" />','<xsl:value-of select="$XmlDefinition/List/@DefaultItemOpen" />','<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon" />','<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type" />','<xsl:value-of select="$thisNode/@serverurl.progid" />');return false;
                </xsl:variable>
                <xsl:variable name="OnClickJS">
                  return HandleFolder(this,event,&quot;<xsl:value-of select="$PagePathFinal" />RootFolder=&quot; + escapeProperly(&quot;<xsl:value-of select="$thisNode/@FileRef" />&quot;) + '<xsl:value-of select="$ShowWebPart" />&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View" /><xsl:value-of select="$folderUrlAdditionalQueryString"/>','TRUE','FALSE','<xsl:value-of select="$thisNode/@File_x0020_Type.url" />','<xsl:value-of select="$thisNode/@File_x0020_Type.progid" />','<xsl:value-of select="$XmlDefinition/List/@DefaultItemOpen" />','<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon" />','<xsl:value-of select="$thisNode/@HTML_x0020_File_x0020_Type" />','<xsl:value-of select="$thisNode/@serverurl.progid" />','<xsl:value-of select="$thisNode/@CheckoutUser.id" />','<xsl:value-of select="$Userid" />','<xsl:value-of select="$XmlDefinition/List/@ForceCheckout" />','<xsl:value-of select="$thisNode/@IsCheckedoutToLocal" />','<xsl:value-of select="$thisNode/@PermMask" />');
                </xsl:variable>
                <a onfocus="OnLink(this)" href="{$FolderURL}">
                  <xsl:choose>
                    <xsl:when test="$IncludeOnClick = '1'">
                      <xsl:attribute name="onmousedown">
                        <xsl:value-of select="$OnMouseDownJS"/>
                      </xsl:attribute>
                      <xsl:attribute name="onclick">
                        <xsl:value-of select="$OnClickJS"/>
                      </xsl:attribute>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:value-of select="$thisNode/@FileLeafRef" />
                  <xsl:choose>
                    <xsl:when test="$ShowAccessibleIcon">
                      <img src="/_layouts/images/blank.gif" class="ms-hidden" border="0" width="1" height="1" alt="{$idPresEnabled}" />
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                  </xsl:choose>
                </a>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="OnClickJS">
                  javascript:EnterFolder(&quot;<xsl:value-of select="$PagePathFinal" />RootFolder=&quot; + escapeProperly(&quot;<xsl:value-of select="$thisNode/@FileRef" />&quot;) + '<xsl:value-of select="$ShowWebPart" />&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View" /><xsl:value-of select="$folderUrlAdditionalQueryString" />');return false;
                </xsl:variable>
                <a onfocus="OnLink(this)" href="{$FolderURL}">
                  <xsl:choose>
                    <xsl:when test="$IncludeOnClick = '1'">
                      <xsl:attribute name="onclick">
                        <xsl:value-of select="$OnClickJS"/>
                      </xsl:attribute>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:value-of select="$thisNode/@FileLeafRef" />
                  <xsl:choose>
                    <xsl:when test="$ShowAccessibleIcon">
                      <img src="/_layouts/images/blank.gif" class="ms-hidden" border="0" width="1" height="1" alt="{$idPresEnabled}" />
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                  </xsl:choose>
                </a>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- warning: this code has optimization in webpart. Change it must change the webpart code too!-->
        <a onfocus="OnLink(this)" href="{$thisNode/@FileRef}" onmousedown="return VerifyHref(this,event,'{$XmlDefinition/List/@DefaultItemOpen}','{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','{$thisNode/@serverurl.progid}')" 
           onclick="return DispEx(this,event,'TRUE','FALSE','{$thisNode/@File_x0020_Type.url}','{$thisNode/@File_x0020_Type.progid}','{$XmlDefinition/List/@DefaultItemOpen}','{$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','{$thisNode/@HTML_x0020_File_x0020_Type}','{$thisNode/@serverurl.progid}','{$thisNode/@CheckoutUser.id}','{$Userid}','{$XmlDefinition/List/@ForceCheckout}','{$thisNode/@IsCheckedoutToLocal}','{$thisNode/@PermMask}')">
          <xsl:value-of select="$thisNode/@FileLeafRef.Name" />
        </a>
        <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
          <xsl:call-template name="NewGif">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="FieldRef" mode="Computed_LinkDiscussionTitle_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="ShowAccessibleIcon" select="0"/>
    <xsl:choose>
      <xsl:when test="$thisNode/@FSObjType='1'">
        <xsl:choose>
          <xsl:when test="$RecursiveView">
            <xsl:value-of disable-output-escaping="no" select="$thisNode/@Title" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="FolderURL">
              <xsl:value-of select="$PagePath" />?RootFolder=<xsl:value-of select="$thisNode/@FileRef.urlencode" /><xsl:value-of select="$ShowWebPart"/>&amp;FolderCTID=<xsl:value-of select="$thisNode/@ContentTypeId" />&amp;View=<xsl:value-of select="$View"/>
            </xsl:variable>
              <a onfocus="OnLink(this)" href="{$FolderURL}" onclick="javascript:GoToDiscussion(&quot;{$PagePath}?RootFolder=&quot; + escapeProperly(&quot;{$thisNode/@FileRef}&quot;) + '{$ShowWebPart}&amp;FolderCTID={$thisNode/@ContentTypeId}&amp;View={$View}');return false;">
              <xsl:choose>
                <xsl:when test="$thisNode/@Title=''">
                  <xsl:value-of select="$Rows/@resource.wss.NoTitle"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of disable-output-escaping="no" select="$thisNode/@Title" />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="$ShowAccessibleIcon">
                  <img src="/_layouts/images/blank.gif" class="ms-hidden" border="0" width="1" height="1" alt="{$idPresEnabled}" />
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
              </xsl:choose>
            </a>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
          <xsl:call-template name="NewGif">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="LinkTitleNoMenu">
          <xsl:with-param name="thisNode" select ="$thisNode"/>
          <xsl:with-param name="ShowAccessibleIcon" select="1"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- SelectedTitle Field => b1f7969b-ea65-42e1-8b54-b588292635f2 -->
  <xsl:template name="FieldRef_SelectedTitle_body" ddwrt:dvt_mode="body" match="FieldRef[@ID='b1f7969b-ea65-42e1-8b54-b588292635f2']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$SelectedID=$ID or ($SelectedID='-1' and not($thisNode/preceding-sibling::*))">
          <img border="0" align="absmiddle" style="cursor: hand" src="/_layouts/images/rbsel.gif" alt="{$thisNode/../@Selected}" />
      </xsl:when>
      <xsl:otherwise>
        <a href="javascript:SelectField('{$View}','{$ID}');return false;" onclick="SelectField('{$View}','{$ID}');return false;" target="_self">
          <img border="0" align="absmiddle" style="cursor: hand" src="/_layouts/images/rbunsel.gif"  alt="{$thisNode/../@resource.wss.GroupBoardTimeCardSettingsNotFlex}" />
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_User_body" ddwrt:dvt_mode="body" match="FieldRef" mode="User_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of disable-output-escaping="yes" select="$thisNode/@*[name()=current()/@Name]" />
  </xsl:template>
  <xsl:template name="FieldRef_Number_body" ddwrt:dvt_mode="body" match="FieldRef" mode="Number_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:choose>
      <xsl:when test="$FreeForm">
        <xsl:call-template name="FieldRef_ValueOf_DisableEscape">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <div align="right">
          <xsl:call-template name="FieldRef_ValueOf_DisableEscape">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_ValueOf_DisableEscape" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of disable-output-escaping="yes" select="$thisNode/@*[name()=current()/@Name]" />
  </xsl:template>
  <xsl:template name="FieldRef_Lookup_body" ddwrt:dvt_mode="body" match="FieldRef" mode="Lookup_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]"/>
  </xsl:template>
  <xsl:template match="FieldRef[@Encoded]" ddwrt:dvt_mode="body" mode="Lookup_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:value-of select="$thisNode/@*[name()=current()/@Name]" disable-output-escaping="yes" />
  </xsl:template>
  <xsl:template name="FieldRef_Image_URL_body" ddwrt:dvt_mode="body" match="FieldRef[@Format='Image']" mode="URL_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="url" select="$thisNode/@*[name()=current()/@Name]" />
    <xsl:variable name="desc" select="$thisNode/@*[name()=concat(current()/@Name, '.desc')]" />
    <xsl:choose>
      <xsl:when test="$url=''">
      </xsl:when>
      <xsl:otherwise>
        <img src="{$url}" alt="{$desc}" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="FieldRef_Hyperlink_URL_body" ddwrt:dvt_mode="body" match="FieldRef[@Format='Hyperlink']" mode="URL_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="url" select="$thisNode/@*[name()=current()/@Name]" />
    <xsl:variable name="desc" select="$thisNode/@*[name()=concat(current()/@Name, '.desc')]" />
    <xsl:choose>
      <xsl:when test="$url=''">
        <xsl:if test="$desc=''">
          <xsl:value-of select="$desc"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$url}" >
          <xsl:choose>
            <xsl:when test="$desc=''">
              <xsl:value-of select="$url"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$desc"/>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name ="RenderThumbnail" match ="FieldRef[@Name='ThumbnailOnForm'] " mode="Computed_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="subDir" select="'_t'"/>
    <xsl:param name="classToApply" select="''"/>
    <xsl:param name="resizeSquareSideLength" select="0"/>
    <xsl:variable name="libUrl" select="substring-before($thisNode/@FileRef,$thisNode/@FileLeafRef)"/>
    <xsl:variable name="fileExt">
      <xsl:call-template name="getFileExt">
        <xsl:with-param name="FileNameAndExt" select="$thisNode/@FileLeafRef"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fileName">
      <xsl:call-template name="getFileName">
        <xsl:with-param name="FileNameAndExt" select="$thisNode/@FileLeafRef"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="srcpath">
      <xsl:choose>
        <xsl:when test="$thisNode/@FSObjType='1'">
          <xsl:choose>
            <xsl:when test="string-length($thisNode/@AlternateThumbnailUrl) &gt; 0">
              <xsl:value-of select="$thisNode/@AlternateThumbnailUrl"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="GetFolderIconSourcePath">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="string-length($thisNode/@AlternateThumbnailUrl) &gt; 0">
              <xsl:value-of select="$thisNode/@AlternateThumbnailUrl"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$thisNode/@ThumbnailExists.value='1'">
                  <xsl:value-of select="concat($libUrl,$subDir,'/',$fileName,'_',$fileExt,'.jpg')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="$fileExt = 'wmv'">
                      <xsl:value-of select="concat($RootSiteUrl,'/_layouts/images/VideoPreview.png')"/>
                    </xsl:when>
                    <xsl:when test="$fileExt = 'wma' or $fileExt = 'mp3'">
                      <xsl:value-of select="concat($RootSiteUrl,'/_layouts/images/AudioPreview.png')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="concat('/_layouts/images/',$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico)"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name ="ident" select="concat('thumbnail_',$thisNode/@ID)"/>
    <xsl:variable name="additionalStyleToApply">
      <xsl:choose>
        <xsl:when test="$resizeSquareSideLength = 0 or string-length($thisNode/@AlternateThumbnailUrl) &gt; 0"/>
        <xsl:when test="$thisNode/@ThumbnailExists.value='1'">
          <xsl:call-template name="getResizedAndCenteredStyle">
            <xsl:with-param name="imageWidth" select="$thisNode/@ImageWidth"/>
            <xsl:with-param name="imageHeight" select="$thisNode/@ImageHeight"/>
            <xsl:with-param name="defaultSize" select="$resizeSquareSideLength"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$fileExt = 'wma' or $fileExt = 'mp3' or $fileExt = 'wmv'">
          <xsl:call-template name="getResizedAndCenteredStyle">
            <xsl:with-param name="imageWidth" select="320"/>
            <xsl:with-param name="imageHeight" select="240"/>
            <xsl:with-param name="defaultSize" select="$resizeSquareSideLength"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="getResizedAndCenteredStyle">
            <xsl:with-param name="imageWidth" select="16"/>
            <xsl:with-param name="imageHeight" select="16"/>
            <xsl:with-param name="defaultSize" select="$resizeSquareSideLength"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:value-of select="$ident"/>
    </xsl:variable>
    <xsl:variable name="class">
      <xsl:value-of select="$classToApply"/>
    </xsl:variable>
    <xsl:variable name="style">max-width:<xsl:value-of select="$XmlDefinition/List/@thumbnailsize"/>px;max-height:<xsl:value-of select="$XmlDefinition/List/@thumbnailsize"/>px;<xsl:value-of select="$additionalStyleToApply"/></xsl:variable>
    <xsl:variable name="src">
      <xsl:choose>
        <xsl:when test="string-length($srcpath) &lt; 6">
          <xsl:value-of select="'/_layouts/images/Error.gif'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$srcpath"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <img id="{$id}" class="{$class}" style="{$style}" src="{$src}" title="{$thisNode/@_Comments}"/>
  </xsl:template>
  <xsl:template name="RenderPreview" match ="FieldRef[@Name='PreviewOnForm']" mode="Computed_body" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="subDir" select="'_w'"/>
    <xsl:param name="styleToApply" select="''"/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="libUrl" select="substring-before($thisNode/@FileRef,$thisNode/@FileLeafRef)"/>
    <xsl:variable name="fileExt">
      <xsl:call-template name="getFileExt">
        <xsl:with-param name="FileNameAndExt" select="$thisNode/@FileLeafRef"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="fileName">
      <xsl:call-template name="getFileName">
        <xsl:with-param name="FileNameAndExt" select="$thisNode/@FileLeafRef"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name ="ident" select="concat('preview_',$ID)"/>
    <xsl:variable name="srcpath">
      <xsl:choose>
        <xsl:when test="$thisNode/@FSObjType='1'">
          <xsl:value-of select="'/_layouts/images/folder.gif'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="string-length($thisNode/@AlternateThumbnailUrl) &gt; 0">
              <xsl:value-of select="substring-before($thisNode/@AlternateThumbnailUrl, ',')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$thisNode/@PreviewExists.value='1'">
                  <xsl:value-of select="concat($libUrl,$subDir,'/',$fileName,'_',$fileExt,'.jpg')"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat('/_layouts/images/',$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="id">
      <xsl:value-of select="$ident"/>
    </xsl:variable>
    <xsl:variable name="class">
      <xsl:value-of select="$styleToApply"/>
    </xsl:variable>
    <xsl:variable name="style">max-width:<xsl:value-of select="$XmlDefinition/List/@webimagewidth"/>px;max-height:<xsl:value-of select="$XmlDefinition/List/@webimageheight"/>px;</xsl:variable>
    <xsl:variable name="src">
      <xsl:choose>
        <xsl:when test="string-length($srcpath) &lt; 6">
          <xsl:value-of select="'/_layouts/images/Error.gif'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$srcpath"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <img id="{$id}" class="{$class}" style="{$style}" src="{$src}"/>
  </xsl:template>
  <xsl:template name="getFileExt" ddwrt:dvt_mode="body">
    <xsl:param name="FileNameAndExt"/>
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="extPosition">
    <xsl:call-template name="lastIndexOf">
      <xsl:with-param name="sourceString" select="$FileNameAndExt"/>
      <xsl:with-param name="targetChar" select="'.'"/>
    </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$extPosition > 0">
        <xsl:value-of select="substring($FileNameAndExt,$extPosition + 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getFileName" ddwrt:dvt_mode="body">
    <xsl:param name="FileNameAndExt"/>
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="extPosition">
      <xsl:call-template name="lastIndexOf">
        <xsl:with-param name="sourceString" select="$FileNameAndExt"/>
        <xsl:with-param name="targetChar" select="'.'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$extPosition > 0">
        <xsl:value-of select="substring($FileNameAndExt,1,$extPosition - 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string($FileNameAndExt)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getResizedAndCenteredStyle">
    <xsl:param name="imageWidth" select="''"/>
    <xsl:param name="imageHeight" select="''"/>
    <xsl:param name="defaultSize" select="100"/>
    <xsl:choose>
      <xsl:when test="$imageWidth != '' and $imageHeight != ''">
        <xsl:variable name="maxW" select="$defaultSize - 10"/>
        <xsl:variable name="maxH" select="$defaultSize - 10"/>
        <xsl:variable name="heightAspect" select="$imageHeight div $imageWidth"/>
        <xsl:variable name="widthAspect" select="$imageWidth  div $imageHeight"/>
        <xsl:choose>
          <xsl:when test="$imageWidth &lt; ($maxW + 1) and $imageHeight &lt; ($maxH + 1)">
            <xsl:call-template name="getResizedAndCenteredStyleString">
              <xsl:with-param name="newW" select="$imageWidth"/>
              <xsl:with-param name="newH" select="$imageHeight"/>
              <xsl:with-param name="defaultSize" select="$defaultSize"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$imageWidth &gt; $maxW and $imageHeight &lt; $maxH">
            <xsl:call-template name="getResizedAndCenteredStyleString">
              <xsl:with-param name="newW" select="$maxW"/>
              <xsl:with-param name="newH" select="round($maxW * $heightAspect)"/>
              <xsl:with-param name="defaultSize" select="$defaultSize"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$imageWidth &lt; $maxW and $imageHeight &gt; $maxH">
            <xsl:call-template name="getResizedAndCenteredStyleString">
              <xsl:with-param name="newH" select="$maxH"/>
              <xsl:with-param name="newW" select="round($maxH * $widthAspect)"/>
              <xsl:with-param name="defaultSize" select="$defaultSize"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$imageWidth &gt; $imageHeight">
                <xsl:call-template name="getResizedAndCenteredStyleString">
                  <xsl:with-param name="newW" select="$maxW"/>
                  <xsl:with-param name="newH" select="round($maxW * $heightAspect)"/>
                  <xsl:with-param name="defaultSize" select="$defaultSize"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="getResizedAndCenteredStyleString">
                  <xsl:with-param name="newH" select="$maxH"/>
                  <xsl:with-param name="newW" select="round($maxH * $widthAspect)"/>
                  <xsl:with-param name="defaultSize" select="$defaultSize"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="''"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getResizedAndCenteredStyleString">
    <xsl:param name="newW"/>
    <xsl:param name="newH"/>
    <xsl:param name="defaultSize" select="100"/>
    <xsl:variable name="marginLeft">
      <xsl:choose>
        <xsl:when test="$newW &lt; $defaultSize">
          <xsl:value-of select="round(($defaultSize - $newW) div 2)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="marginTop">
      <xsl:choose>
        <xsl:when test="$newH &lt; $defaultSize">
          <xsl:value-of select="round(($defaultSize - $newH) div 2)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat('width:',$newW,'px; height',$newH,'px; margin-left:',$marginLeft,'px; margin-top:',$marginTop,'px;')"/>
  </xsl:template>
  <xsl:template name="LinkTitleVersionNoMenu" match ="FieldRef[@Name='LinkTitleVersionNoMenu']" mode="Computed_body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="ShowAccessibleIcon" select="0"/>
    <a onfocus="OnLink(this)" href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}" onclick="GoToHistoryLink(this, {$thisNode/@_UIVersion});return false;" target="_self">
    <xsl:call-template name="LinkTitleValue">
      <xsl:with-param name="thisNode" select="$thisNode"/>
      <xsl:with-param name="ShowAccessibleIcon" select="$ShowAccessibleIcon"/>
    </xsl:call-template>
    </a>
    <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
      <xsl:call-template name="NewGif">
        <xsl:with-param name="thisNode" select="$thisNode"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="lastIndexOf" ddwrt:dvt_mode="body">
    <xsl:param name="sourceString"/>
    <xsl:param name="targetChar"/>
    <xsl:param name="thisNode" select="."/>
    <xsl:variable name="len" select="string-length($sourceString)"/>
    <xsl:variable name="lastChar" select="substring($sourceString,$len,1)"/>
    <xsl:choose>
      <!--String is empty-->
      <xsl:when test="$len &lt; 1">
        <xsl:value-of select="number(-1)"/>
      </xsl:when>
      <!--Last char in string matches the target char-->
      <xsl:when test="$lastChar = $targetChar">
        <xsl:value-of select="number($len)"/>
      </xsl:when>
      <!--Otherwise recurse with string shortened by cutting off its last char-->
      <xsl:otherwise>
        <xsl:call-template name="lastIndexOf">
          <xsl:with-param name="sourceString" select="substring($sourceString,1,$len - 1)"/>
          <xsl:with-param name="targetChar" select="$targetChar"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="fixQuotes">
    <xsl:param name="string"/>
    <xsl:choose>
      <xsl:when test="contains($string, &quot;'&quot;)">
        <xsl:value-of
          select="substring-before($string, &quot;'&quot;)"/>
        <xsl:text>\'</xsl:text>
        <xsl:call-template name="fixQuotes">
          <xsl:with-param name="string"
            select="substring-after($string, &quot;'&quot;)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
