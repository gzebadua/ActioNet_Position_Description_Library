<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp" version="1.0" exclude-result-prefixes="xsl msxsl ddwrt"
                xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:asp="http://schemas.microsoft.com/ASPNET/20"
                xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:SharePoint="Microsoft.SharePoint.WebControls" xmlns:ddwrt2="urn:frontpage:internal" ddwrt:oob="true">
  <xsl:output method="html" indent="no"/>
  <xsl:variable name="FirstRow" select="$dvt_firstrow" />
  <xsl:variable name="LastRow" select="$FirstRow + $dvt_RowCount - 1" />
  <xsl:param name="Rows" select="/dsQueryResponse/Rows"/>
  <xsl:param name="AllRows" select="/dsQueryResponse/Rows/Row[$EntityName = '' or (position() &gt;= $FirstRow and position() &lt;= $LastRow)]"/>
    <xsl:variable name="ViewClassName">
    <xsl:choose>
      <xsl:when test="$dvt_RowCount=0">ms-emptyView</xsl:when>
      <xsl:otherwise>ms-listviewtable</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$RenderCTXOnly='True'">
        <xsl:call-template name="CTXGeneration"/>
      </xsl:when>
      <xsl:when test="($ManualRefresh = 'True')">
        <xsl:call-template name="AjaxWrapper" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="RootTemplate" select="$XmlDefinition"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="AjaxWrapper" ddwrt:ghost="always">
    <table width="100%" border="0"  cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top">
          <xsl:apply-templates mode="RootTemplate" select="$XmlDefinition"/>
        </td>
        <td width="1%" class="ms-vb" valign="top">
          <xsl:variable name="onclick">
            javascript: <xsl:call-template name="GenFireServerEvent">
              <xsl:with-param name="param" select="'cancel'"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="alt">
            <xsl:value-of select="$Rows/@resource.wss.ManualRefreshText"/>
          </xsl:variable>
          <a href="javascript:" onclick="{$onclick};return false;">
            <img src="/_layouts/images/staticrefresh.gif" id="ManualRefresh" border="0" alt="{$alt}"/>
          </a>
        </td>
      </tr>
    </table>
  </xsl:template>
  <!-- BaseViewID = 0 is summary view (home page view)-->
  <xsl:template name="View_DefaultSummary_RootTemplate" mode="RootTemplate" match="View[@BaseViewID='0']" ddwrt:dvt_mode="root">
    <xsl:apply-templates select="." mode="full" />
  </xsl:template>
  <!-- BaseViewID='9' and TemplateType='115' is XMLForm repair links view -->
  <xsl:template name="View_XMLForm_RepairLinks_RootTemplate" mode="RootTemplate" match="View[@BaseViewID='9' and List/@TemplateType='115']" ddwrt:dvt_mode="root">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <xsl:call-template name="RepairLinksToolbar"/>
      <xsl:call-template name="CTXGeneration"/>
      <tr>
        <td>
          <xsl:if test="not($NoAJAX)">
            <iframe src="javascript:false;" id="FilterIframe{$ViewCounter}" name="FilterIframe{$ViewCounter}" style="display:none" height="0" width="0" FilterLink="{$FilterLink}"></iframe>
          </xsl:if>
          <table id="{$List}-{$View}" summary="{List/@title} {List/@description}" xmlns:o="urn:schemas-microsoft-com:office:office" o:WebQuerySourceHref="{$HttpPath}&amp;XMLDATA=1&amp;RowLimit=0&amp;View={$View}" class="{$ViewClassName}" width="100%" border="0" cellspacing="0" cellpadding="1" dir="{List/@Direction}">
            <xsl:apply-templates select="." mode="full" />          
          </table>
          <script type='text/javascript'><xsl:value-of select ="concat('HideListViewRows(&quot;', $List, '-', $View, '&quot;);')"/></script>
        </td>
      </tr>
    </table>
    <xsl:call-template name="pagingButtons" />    
  </xsl:template>
  <!-- ViewStyleID='20' is the Preview Pane-->
  <xsl:template name="View_PreviewPane_RootTemplate" mode="RootTemplate" match="View[ViewStyle/@ID='20']" ddwrt:dvt_mode="root">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <xsl:call-template name="CTXGeneration"/>
      <tr>
        <td>
          <table id="{$List}-{$View}" summary="{List/@title} {List/@description}" xmlns:o="urn:schemas-microsoft-com:office:office" o:WebQuerySourceHref="{$HttpPath}&amp;XMLDATA=1&amp;RowLimit=0&amp;View={$View}"
                    class="{$ViewClassName}" width="100%" border="0" cellspacing="0" cellpadding="1" dir="{List/@Direction}">
            <tr>
              <td>
    <script type='text/javascript'><xsl:value-of select ="concat('HideListViewRows(&quot;', $List, '-', $View, '&quot;);')"/></script>
    <xsl:apply-templates select="." mode="full" />
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <xsl:call-template name="pagingButtons" />    
  </xsl:template>
  <xsl:template name="PicLibScriptGeneration" ddwrt:ghost="always">  
    <script type="text/javascript">
      <xsl:if test="@BaseViewID='7' ">
        fSelectedView = true;
      </xsl:if>
      currentViewGuid = "<xsl:value-of select='$View'/>";
      InitImglibView(<xsl:value-of select="concat('&quot;', $List, '&quot;,&quot;', $LCID, '&quot;')"/>);
      vCurrentListUrlAsHTML = "<xsl:value-of select="$HttpVDir" />/<xsl:value-of select="$Project" />/";
      vCurrentWebUrl = "<xsl:value-of select="$HttpVDir" />";
    </script>
  </xsl:template>
  <xsl:template name="View_Default_RootTemplate" mode="RootTemplate" match="View" ddwrt:dvt_mode="root">
    <xsl:param name="ShowSelectAllCheckbox" select="'True'"/>
    <!-- Only if not doing the default view and toolbar type is standard (not freeform or none)-->
    <xsl:if test="($IsGhosted = '0' and $MasterVersion=3 and Toolbar[@Type='Standard']) or $ShowAlways">
      <xsl:call-template name="ListViewToolbar"/>
    </xsl:if>
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <!-- not show ctx for survey overview-->
      <xsl:if test="not($NoCTX)">
        <xsl:call-template name="CTXGeneration"/>
      </xsl:if>
      <xsl:if test="List/@TemplateType=109">
        <xsl:call-template name="PicLibScriptGeneration"/>
      </xsl:if>
      <tr>
        <td>
          <xsl:if test="not($NoAJAX)">
            <iframe src="javascript:false;" id="FilterIframe{$ViewCounter}" name="FilterIframe{$ViewCounter}" style="display:none" height="0" width="0" FilterLink="{$FilterLink}"></iframe>
          </xsl:if>
          <table summary="{List/@title} {List/@description}" xmlns:o="urn:schemas-microsoft-com:office:office" o:WebQuerySourceHref="{$HttpPath}&amp;XMLDATA=1&amp;RowLimit=0&amp;View={$View}" 
                          width="100%" border="0" cellspacing="0" dir="{List/@Direction}">
            <xsl:if test="not($NoCTX)">
              <xsl:attribute name="onmouseover">EnsureSelectionHandler(event,this,<xsl:value-of select ="$ViewCounter"/>)</xsl:attribute>
            </xsl:if>
            <xsl:if test="$NoAJAX">
              <xsl:attribute name="FilterLink">
                <xsl:value-of select="$FilterLink"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="cellpadding">
              <xsl:choose>
                <xsl:when test="ViewStyle/@ID='15' or ViewStyle/@ID='16'">0</xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:choose>
                <xsl:when test="$IsDocLib or dvt_RowCount = 0">onetidDoclibViewTbl0</xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="concat($List, '-', $View)"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="ViewStyle/@ID='0' or ViewStyle/@ID='17'"><xsl:value-of select="$ViewClassName"/> ms-basictable</xsl:when>
                <xsl:when test="ViewStyle/@ID='16'"><xsl:value-of select="$ViewClassName"/> ms-listviewtable2</xsl:when>
                <xsl:otherwise><xsl:value-of select="$ViewClassName"/></xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:if test="$InlineEdit">
              <xsl:attribute name="inlineedit">javascript: <xsl:value-of select="ddwrt:GenFireServerEvent('__cancel;dvt_form_key={@ID}')"/>;CoreInvoke('ExpGroupOnPageLoad', 'true');</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="." mode="full">
              <xsl:with-param name="ShowSelectAllCheckbox" select="$ShowSelectAllCheckbox"/>
            </xsl:apply-templates>
          </table>
              <xsl:choose>
                <xsl:when test="$IsDocLib or dvt_RowCount = 0"><script type='text/javascript'>HideListViewRows("onetidDoclibViewTbl0");</script></xsl:when>
                <xsl:otherwise>
                  <script type='text/javascript'><xsl:value-of select ="concat('HideListViewRows(&quot;', $List, '-', $View, '&quot;);')"/></script>
                </xsl:otherwise>
              </xsl:choose>
        </td>
      </tr>
      <xsl:if test="$dvt_RowCount = 0 and not (@BaseViewID='3' and List/@TemplateType='102')">
        <tr>
          <td>
             <table width="100%" border="0" dir="{List/@Direction}">
               <xsl:call-template name="EmptyTemplate" />
             </table>
          </td>
        </tr>
      </xsl:if>
    </table>
    <!-- rowlimit doesn't show page footer-->
    <xsl:call-template name="pagingButtons" />
    <xsl:if test="Toolbar[@Type='Freeform'] or ($MasterVersion=4 and Toolbar[@Type='Standard'])">
      <xsl:call-template name="Freeform">
        <xsl:with-param name="AddNewText">
          <xsl:choose>
            <xsl:when test="List/@TemplateType='104'">
              <!-- announcement-->
              <xsl:value-of select="$Rows/@resource.wss.idHomePageNewAnnounce"/>
            </xsl:when>
            <xsl:when test="List/@TemplateType='101' or List/@TemplateType='115'">
              <!-- doc lib or form lib-->
              <xsl:value-of select="$Rows/@resource.wss.Add_New_Document"/>
            </xsl:when>
            <xsl:when test="List/@TemplateType='103'">
              <!-- link -->
              <xsl:value-of select="$Rows/@resource.wss.AddNewLink"/>
            </xsl:when>
            <xsl:when test="List/@TemplateType='106'">
              <!-- Event -->
              <xsl:value-of select="$Rows/@resource.wss.AddNewEvent"/>
            </xsl:when>
            <xsl:when test="List/@TemplateType='119'">
              <!-- Wiki Library -->
              <xsl:value-of select="$Rows/@resource.wss.AddNewWikiPage"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$Rows/@resource.wss.addnewitem"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="ID">
          <xsl:choose>
          <xsl:when test="List/@TemplateType='104'">idHomePageNewAnnouncement</xsl:when>
          <xsl:when test="List/@TemplateType='101'">idHomePageNewDocument</xsl:when>
          <xsl:when test="List/@TemplateType='103'">idHomePageNewLink</xsl:when>
          <xsl:when test="List/@TemplateType='106'">idHomePageNewEvent</xsl:when>
          <xsl:when test="List/@TemplateType='119'">idHomePageNewWikiPage</xsl:when>
          <xsl:otherwise>idHomePageNewItem</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="GroupHeader">
    <xsl:param name="fieldtitle" />
    <xsl:param name="fieldname" />
    <xsl:param name="group" select="."/>
    <xsl:param name="fieldtype" />
    <xsl:param name="groupid" />
    <xsl:param name="groupindex" />
    <xsl:param name="groupindex2" />
    <xsl:param name="imagesrc" />
    <xsl:param name="alttext" />
    <xsl:param name="altname" />
    <xsl:param name="RowCount" select="1"/>
    <xsl:param name="Collapse"/>
    <tbody id="titl{$ViewCounter}-{$groupindex}{$groupindex2}" groupString="{@*[name()=concat($fieldtitle, '.urlencoded')]}">
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>
      <tr id="group{$groupid}">
        <td colspan="100" nowrap="nowrap">
          <xsl:attribute name="class">
            <xsl:choose>
              <xsl:when test="$groupid='0' or $groupid='9'">ms-gb</xsl:when>
              <xsl:otherwise>ms-gb2</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <xsl:choose>
            <xsl:when test="$groupid='0' or $groupid='9'">
            </xsl:when>
            <xsl:when test="$groupid='1'">
              <img src="/_layouts/images/blank.gif" alt="" height="1" width="10"/>
            </xsl:when>
            <xsl:otherwise>
              <img src="/_layouts/images/blank.gif" alt="" height="1" width="20"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$NoAJAX or $InlineEdit">
              <a href="javascript:" onclick="javascript:ExpCollGroup('{$ViewCounter}-{$groupindex}{$groupindex2}', 'img_{$ViewCounter}-{$groupindex}{$groupindex2}',event, true);return false;">
                <img src="{$imagesrc}" border="0" alt="{$alttext}" id="img_{$ViewCounter}-{$groupindex}{$groupindex2}" />
                <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="$fieldname" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a href="javascript:" onclick="javascript:ExpCollGroup('{$ViewCounter}-{$groupindex}{$groupindex2}', 'img_{$ViewCounter}-{$groupindex}{$groupindex2}',event, false);return false;">
                <img src="{$imagesrc}" border="0" alt="{$alttext}" id="img_{$ViewCounter}-{$groupindex}{$groupindex2}" />
                <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
                <xsl:value-of select="$fieldname" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="$fieldname"> : </xsl:if>
          <xsl:choose>
            <xsl:when test="$fieldtype='Number' or $fieldtype='Currency'">
              <xsl:value-of select="@*[name()=$fieldtitle]" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="$fieldtype='Freeform'">
              <xsl:value-of select="@*[name()=$fieldtitle]" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="$fieldtype ='DateTime'">
              <xsl:value-of select="@*[name()=concat($fieldtitle, '.groupdisp')]"/>              
            </xsl:when>
            <xsl:when test="$fieldtype='User' or $fieldtype='UserMulti'">
              <xsl:value-of select="@*[name()=concat($fieldtitle, '.span')]" disable-output-escaping="yes"/>
            </xsl:when> 
            <xsl:otherwise>
              <xsl:apply-templates mode="PrintField" select="$group">
                <xsl:with-param name="thisNode" select="."/>
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose>
          <span style="font-weight: lighter;display: inline-block;">
            <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            <xsl:choose>
              <xsl:when test="$XmlDefinition/List/@Direction='rtl' or $LCID='1037'">
                <xsl:text disable-output-escaping="yes">&amp;#8207;</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text disable-output-escaping="yes">&amp;#8206;</xsl:text>
              </xsl:otherwise>
            </xsl:choose>(<xsl:value-of select="$RowCount"/>)
          </span>
        </td>
      </tr>
    </tbody>
  </xsl:template>
  <xsl:template name="GroupTemplate">
    <xsl:param name="Groups" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="HasExtraColumn" select="false()"/>
    <xsl:if test="position() = 1">
      <input type="hidden" id="GroupByColFlag"/>
      <input type="hidden" id="GroupByWebPartID{$ViewCounter}" webPartID="{$View}"/>
      <tbody id="GroupByCol{$View}">
        <tr id="GroupByCol{$ViewCounter}" queryString ="{$FilterLink}"/>
      </tbody >
    </xsl:if>
	<xsl:if test="../../@ViewStyleID='6'">f
      <script type="text/javascript">
        fIsInGroupByView = true;
      </script>
	</xsl:if>
    <xsl:choose>
      <xsl:when test="../../@ViewStyleID='20'">
        <script type="text/javascript">
          ppt = document.getElementById('previewpanetable<xsl:value-of select ="$ViewCounter"/>');
          ppt.style.display = "none";
          ppe = document.getElementById('previewpaneerror<xsl:value-of select ="$ViewCounter"/>');
          ppe.innerHTML = "<xsl:value-of select ='$Rows/@resource.wss.ViewStyleInGroupedViews'/>";
        </script>
        </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="expandImage">
          <xsl:choose>
            <xsl:when test="$Collapse">/_layouts/images/plus.gif</xsl:when>
            <xsl:otherwise>/_layouts/images/minus.gif</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="expandText">
          <xsl:choose>
            <xsl:when test="$Collapse">
              <xsl:value-of select="$Rows/@resource.wss.collapse"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$Rows/@resource.wss.expand"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="count($Groups) = 2">
            <xsl:variable name="fieldtitle" select="$Groups[1]/@Name"/>
            <xsl:variable name="fieldtitle2" select="$Groups[2]/@Name"/>
            <xsl:choose>
              <xsl:when test="@*[name() = concat($fieldtitle, '.newgroup')] = '1'">
                <xsl:call-template name="GroupHeader">
                  <xsl:with-param name="fieldtitle" select="$fieldtitle"/>
                  <xsl:with-param name="fieldname" select="$Groups[1]/@DisplayName"/>
                  <xsl:with-param name="group" select="$Groups[1]"/>
                  <xsl:with-param name="fieldtype" select="$Groups[1]/@Type"/>
                  <xsl:with-param name="groupid" select="'0'" />
                  <xsl:with-param name="imagesrc" select="$expandImage"/>
                  <xsl:with-param name="alttext">
                    <xsl:value-of select="$Rows/@resource.wss.collapse"/>
                  </xsl:with-param>
                  <xsl:with-param name="altname">
                    <xsl:value-of select="$Rows/@resource.wss.expand"/>
                  </xsl:with-param>
                  <xsl:with-param name="RowCount" select="@*[name() = concat($fieldtitle, '.COUNT.group')]"/>
                  <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                </xsl:call-template>
                <!--aggregate -->
                <xsl:if test="$XmlDefinition/Aggregations/FieldRef">
                  <tbody id="aggr{$ViewCounter}-{@*[name() = concat($fieldtitle, '.groupindex')]}_">
                    <xsl:if test="$Collapse">
                      <xsl:attribute name="style">display:none</xsl:attribute>
                    </xsl:if>
                    <tr>
                      <xsl:if test="$HasExtraColumn">
                        <td/>
                      </xsl:if>
                      <xsl:if test="$InlineEdit">
                        <td width="1%"/>
                      </xsl:if >
                      <xsl:apply-templates mode="aggregate" select="$XmlDefinition/ViewFields/FieldRef[not(@Explicit='TRUE')]">
                        <xsl:with-param name="Rows" select="."/>
                        <xsl:with-param name="GroupLevel" select="1"/>
                      </xsl:apply-templates>
                    </tr>
                  </tbody>
                </xsl:if>
                <xsl:call-template name="GroupHeader">
                  <xsl:with-param name="fieldtitle" select="$fieldtitle2"/>
                  <xsl:with-param name="fieldname" select="$Groups[2]/@DisplayName"/>
                  <xsl:with-param name="group" select="$Groups[2]"/>
                  <xsl:with-param name="fieldtype" select="$Groups[2]/@Type"/>
                  <xsl:with-param name="groupid" select="'1'" />
                  <xsl:with-param name="imagesrc" select="$expandImage" />
                  <xsl:with-param name="alttext">
                    <xsl:choose>
                      <xsl:when test="$Collapse">
                        <xsl:value-of select="$Rows/@resource.wss.expand"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$Rows/@resource.wss.collapse"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="altname" select="$expandText"/>
                  <xsl:with-param name="RowCount" select="@*[name() = concat($fieldtitle2, '.COUNT.group2')]"/>
                  <xsl:with-param name="Collapse" select="$Collapse"/>
                  <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                  <xsl:with-param name="groupindex2" select="@*[name() = concat($fieldtitle2, '.groupindex2')]"/>
                </xsl:call-template>
                <!--aggregate -->
                <xsl:if test="$XmlDefinition/Aggregations/FieldRef">
                  <tbody id="aggr{$ViewCounter}-{@*[name() = concat($fieldtitle, '.groupindex')]}{@*[name() = concat($fieldtitle2, '.groupindex2')]}_">
                    <xsl:if test="$Collapse">
                      <xsl:attribute name="style">display:none</xsl:attribute>
                    </xsl:if>
                    <tr>
                      <xsl:if test="$HasExtraColumn">
                        <td/>
                      </xsl:if>
                      <xsl:if test="$InlineEdit">
                        <td width="1%"/>
                      </xsl:if >
                      <xsl:apply-templates mode="aggregate" select="$XmlDefinition/ViewFields/FieldRef[not(@Explicit='TRUE')]">
                        <xsl:with-param name="Rows" select="."/>
                        <xsl:with-param name="GroupLevel" select="2"/>
                      </xsl:apply-templates>
                    </tr>
                  </tbody>
                </xsl:if>
                <xsl:call-template name="NewTBody">
                  <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                  <xsl:with-param name="groupindex2" select="@*[name() = concat($fieldtitle2, '.groupindex2')]"/>
                  <xsl:with-param name="Collapse" select="$Collapse"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@*[name() = concat($fieldtitle2, '.newgroup')] = '1'">
                <xsl:call-template name="GroupHeader">
                  <xsl:with-param name="fieldtitle" select="$fieldtitle2"/>
                  <xsl:with-param name="fieldname" select="$Groups[2]/@DisplayName"/>
                  <xsl:with-param name="group" select="$Groups[2]"/>
                  <xsl:with-param name="fieldtype" select="$Groups[2]/@Type"/>
                  <xsl:with-param name="groupid" select="'1'" />
                  <xsl:with-param name="imagesrc" select="$expandImage" />
                  <xsl:with-param name="alttext">
                    <xsl:choose>
                      <xsl:when test="$Collapse">
                        <xsl:value-of select="$Rows/@resource.wss.expand"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$Rows/@resource.wss.collapse"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="altname" select="$expandText"/>
                  <xsl:with-param name="RowCount" select="@*[name() = concat($fieldtitle2, '.COUNT.group2')]"/>
                  <xsl:with-param name="Collapse" select="$Collapse"/>
                  <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                  <xsl:with-param name="groupindex2" select="@*[name() = concat($fieldtitle2, '.groupindex2')]"/>
                </xsl:call-template>
                <!--aggregate -->
                <xsl:if test="$XmlDefinition/Aggregations/FieldRef">
                  <tbody id="aggr{$ViewCounter}-{@*[name() = concat($fieldtitle, '.groupindex')]}{@*[name() = concat($fieldtitle2, '.groupindex2')]}_">
                    <xsl:if test="$Collapse">
                      <xsl:attribute name="style">display:none</xsl:attribute>
                    </xsl:if>
                    <tr>
                      <xsl:if test="$HasExtraColumn">
                        <td/>
                      </xsl:if>
                      <xsl:if test="$InlineEdit">
                        <td width="1%"/>
                      </xsl:if >
                      <xsl:apply-templates mode="aggregate" select="$XmlDefinition/ViewFields/FieldRef[not(@Explicit='TRUE')]">
                        <xsl:with-param name="Rows" select="."/>
                        <xsl:with-param name="GroupLevel" select="2"/>
                      </xsl:apply-templates>
                    </tr>
                  </tbody>
                </xsl:if>
                <xsl:call-template name="NewTBody">
                  <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                  <xsl:with-param name="groupindex2" select="@*[name() = concat($fieldtitle2, '.groupindex2')]"/>
                  <xsl:with-param name="Collapse" select="$Collapse"/>
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="count($Groups) = 1">
            <xsl:variable name="fieldtitle" select="$Groups/@Name"/>
            <xsl:if test="@*[name() = concat($fieldtitle, '.newgroup')] = '1'">
              <xsl:call-template name="GroupHeader">
                <xsl:with-param name="fieldtitle">
                  <xsl:value-of select="$fieldtitle"/>
                </xsl:with-param>
                <xsl:with-param name="fieldname">
                  <xsl:value-of select="$Groups/@DisplayName"/>
                </xsl:with-param>
                <xsl:with-param name="group" select="$Groups[1]"/>
                <xsl:with-param name="fieldtype">
                  <xsl:value-of select="$Groups/@Type"/>
                </xsl:with-param>
                <xsl:with-param name="groupid" select="'0'" />
                <xsl:with-param name="imagesrc" select="$expandImage" />
                <xsl:with-param name="alttext">
                  <xsl:choose>
                    <xsl:when test="$Collapse">
                      <xsl:value-of select="$Rows/@resource.wss.expand"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$Rows/@resource.wss.collapse"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="altname" select="$expandText"/>
                <xsl:with-param name="RowCount" select="@*[name() = concat($fieldtitle, '.COUNT.group')]"/>
                <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
              </xsl:call-template>
              <!--aggregate -->
              <xsl:if test="$XmlDefinition/Aggregations/FieldRef">
                <tbody id="aggr{$ViewCounter}-{@*[name() = concat($fieldtitle, '.groupindex')]}_">
                  <xsl:if test="$Collapse">
                    <xsl:attribute name="style">display:none</xsl:attribute>
                  </xsl:if>
                  <tr>
                    <xsl:if test="$HasExtraColumn">
                      <td/>
                    </xsl:if>
                    <xsl:if test="$InlineEdit">
                      <td width="1%"/>
                    </xsl:if >
                    <xsl:apply-templates mode="aggregate" select="$XmlDefinition/ViewFields/FieldRef[not(@Explicit='TRUE')]">
                      <xsl:with-param name="Rows" select="."/>
                      <xsl:with-param name="GroupLevel" select="1"/>
                    </xsl:apply-templates>
                  </tr>
                </tbody>
              </xsl:if>
              <xsl:call-template name="NewTBody">
                <xsl:with-param name="groupindex" select="@*[name() = concat($fieldtitle, '.groupindex')]"/>
                <xsl:with-param name="Collapse" select="$Collapse"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="NewTBody">
    <xsl:param name="groupindex"/>
    <xsl:param name="groupindex2"/>
    <xsl:param name="Collapse"/>
    <xsl:variable name="loadText">
      <xsl:choose>
        <xsl:when test="$Collapse and not($NoAJAX) and not($InlineEdit)">false</xsl:when>
        <xsl:otherwise>true</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tbody id="tbod{$ViewCounter}-{$groupindex}{$groupindex2}_" isLoaded="{$loadText}"/>
  </xsl:template>
  <xsl:template name="NewTR">
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="EmptyLine" select="0"/>
    <xsl:text disable-output-escaping="yes">&lt;tr</xsl:text>
    <xsl:if test="$Collapse">
      <xsl:text disable-output-escaping="yes"> style=&quot;display:none&quot;</xsl:text>
    </xsl:if>
    <xsl:if test="$EmptyLine">
      <xsl:text disable-output-escaping ="yes"> style=&quot;font-size: 6px&quot;</xsl:text>
    </xsl:if>
    <xsl:text disable-output-escaping ="yes">&gt;</xsl:text>
  </xsl:template>
  <xsl:template name="NewTRJumbo">
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Collapse" select="."/>
    <xsl:choose>
      <xsl:when test="$Position mod 2 = 0">
        <xsl:text disable-output-escaping="yes">&lt;/tr&gt;</xsl:text>
        <xsl:call-template name="NewTR">
          <xsl:with-param name="Collapse" select="$Collapse"/>
          <xsl:with-param name="EmptyLine" select="1"/>
        </xsl:call-template>
        <xsl:text disable-output-escaping="yes">&lt;td&gt;&amp;nbsp;&lt;/td&gt;&lt;/tr&gt;</xsl:text>
        <xsl:call-template name="NewTR">
          <xsl:with-param name="Collapse" select="$Collapse"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <td width="1.5%">
          <xsl:text ddwrt:nbsp-preserve="yes" disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- *********************************************** -->
  <!-- *                                             * -->
  <!-- *  View Templates                             * -->
  <!-- *                                             * -->
  <!-- *********************************************** -->
  <!-- Default -->
  <xsl:template match="View" mode="full">
    <xsl:param name="ShowSelectAllCheckbox" select="'True'"/>
    <xsl:variable name="ViewStyleID">
      <xsl:value-of select="ViewStyle/@ID"/>
    </xsl:variable>
    <xsl:variable name="dirClass">
      <xsl:choose>
        <xsl:when test="$XmlDefinition/List/@Direction='rtl'"> ms-vhrtl</xsl:when>
        <xsl:otherwise> ms-vhltr</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr>
      <xsl:apply-templates mode="aggregate" select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
        <xsl:with-param name="Rows" select="$AllRows"/>
        <xsl:with-param name="GroupLevel" select="0"/>
      </xsl:apply-templates>
    </tr>
    <tr valign="top" class="{concat('ms-viewheadertr',$dirClass)}">
        <xsl:if test="$MasterVersion=4 and $TabularView='1'">
          <!-- ViewStyleID ''=Default / ViewStyleID 17=Shaded -->
          <xsl:if test="($ViewStyleID = '' or $ViewStyleID = '17') and $ShowSelectAllCheckbox = 'True'">
            <th class="ms-vh-icon" scope="col"><input type="checkbox" title="{$select_deselect_all}" onclick="ToggleAllItems(event,this,{$ViewCounter})" onfocus="EnsureSelectionHandlerOnFocus(event,this,{$ViewCounter})" /></th>
          </xsl:if>
        </xsl:if>
        <xsl:if test="$InlineEdit"><th class="ms-vh2 ms-vh-inlineedit"/></xsl:if>
        <xsl:if test="not($GroupingRender)">
          <xsl:apply-templates mode="header" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
        </xsl:if>
    </tr>
    <xsl:apply-templates select="." mode="RenderView" />
    <xsl:apply-templates mode="footer" select="." />
  </xsl:template>
  <xsl:template match="View[@BaseViewID='0']" mode="full">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <xsl:call-template name="CTXGeneration"/>
      <tr>
        <td>
        <xsl:if test="not($NoAJAX)">
          <iframe src="javascript:false;" id="FilterIframe{$ViewCounter}" name="FilterIframe{$ViewCounter}" style="display:none" height="0" width="0" FilterLink="{$FilterLink}"></iframe>
        </xsl:if>
          <table id="{$List}-{$View}" summary="{List/@title} {List/@description}" xmlns:o="urn:schemas-microsoft-com:office:office"
                 o:WebQuerySourceHref="{$HttpPath}&amp;XMLDATA=1&amp;RowLimit=0&amp;List={$List}&amp;View={$View}"
                 class="ms-summarystandardbody" width="100%" cellspacing="0" cellpadding="1" border="0" dir="{$XmlDefinition/List/@Direction}">
            <xsl:if test="not(List/@TemplateType='104' or List/@TemplateType='103' or List/@TemplateType='106')">
              <tr class="ms-viewheadertr" valign="TOP">
                <xsl:for-each select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
                  <xsl:apply-templates mode="header" select="." />
                </xsl:for-each>
              </tr>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="$dvt_RowCount != 0">
                <xsl:apply-templates select="." mode="RenderView" />
              </xsl:when>
              <xsl:otherwise>
                <!-- No list entries -->
                <xsl:call-template name="EmptyTemplate" />
                <tr>
                  <td height="5">
                    <img src="/_layouts/images/blank.gif" width="1" height="5" alt="" />
                  </td>
                </tr>
              </xsl:otherwise>
            </xsl:choose>
          </table>
          <script type='text/javascript'><xsl:value-of select ="concat('HideListViewRows(&quot;', $List, '-', $View, '&quot;);')"/></script>          
        </td>
      </tr>
    </table>
    <xsl:apply-templates mode="footer" select="." />
  </xsl:template>
  <xsl:template match="View[@BaseViewID='0' and List/@TemplateType='103']" mode="full">
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <xsl:call-template name="CTXGeneration"/>
      <tr>
        <td>
          <table id="{$List}-{$View}" summary="{List/@title} {List/@description}" xmlns:o="urn:schemas-microsoft-com:office:office"
                 o:WebQuerySourceHref="{$HttpPath}&amp;XMLDATA=1&amp;RowLimit=0&amp;List={$List}&amp;View={$View}"
                 class="ms-summarycustombody" style="margin-bottom: 5px;" cellspacing="0" cellpadding="0" border="0">
            <xsl:choose>
              <xsl:when test="$dvt_RowCount != 0">
                <xsl:apply-templates select="." mode="RenderView" />
              </xsl:when>
              <xsl:otherwise>
                <!-- No list entries -->
                <xsl:call-template name="EmptyTemplate" />
                <tr>
                  <td height="5">
                    <img src="/_layouts/images/blank.gif" width="1" height="5" alt="" />
                  </td>
                </tr>
              </xsl:otherwise>
            </xsl:choose>
          </table>
        </td>
      </tr>
    </table>
    <xsl:apply-templates mode="footer" select="." />
  </xsl:template>
  <!-- BaseViewID='0' and TemplateType='101' is Home Page view for DocumentLibrary -->
  <xsl:template match="View[@BaseViewID='0' and List/@TemplateType='101']" mode="full">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <xsl:call-template name="CTXGeneration"/>
      <script type="text/vbscript">
        On Error Resume Next
        Set EditDocumentButton = CreateObject("SharePoint.OpenDocuments.3")
        If (IsObject(EditDocumentButton)) Then
        fNewDoc3 = true
        Else
        Set EditDocumentButton = CreateObject("SharePoint.OpenDocuments.2")
        If (IsObject(EditDocumentButton)) Then
        fNewDoc2 = true
        Else
        Set EditDocumentButton = CreateObject("SharePoint.OpenDocuments.1")
        End If
        End If
        fNewDoc = IsObject(EditDocumentButton)
      </script>
      <tr>
        <td>
        <xsl:if test="not($NoAJAX)">
          <iframe src="javascript:false;" id="FilterIframe{$ViewCounter}" name="FilterIframe{$ViewCounter}" style="display:none" height="0" width="0" FilterLink="{$FilterLink}"></iframe>
        </xsl:if>
          <table id="onetidDoclibViewTbl{$ViewCounter}" width="100%" class="ms-summarystandardbody" border="0"
              cellspacing="0" cellpadding="1" dir="None" summary="{List/@title} {List/@description}">
            <tr class="ms-viewheadertr" valign="TOP">
              <xsl:for-each select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
                <xsl:apply-templates mode="header" select="." />
              </xsl:for-each>
            </tr>
            <xsl:apply-templates select="." mode="RenderView" />
          </table>
          <script type='text/javascript'><xsl:value-of select ="concat('HideListViewRows(&quot;onetidDoclibViewTbl', $ViewCounter, '&quot;);')"/></script>
        </td>
      </tr>
      <xsl:if test="$dvt_RowCount=0">
        <!-- No list entries -->
        <tr>
          <td class="ms-vb">
            <table class="ms-summarycustombody" cellpadding="0" cellspacing="0" border="0">
              <xsl:call-template name="EmptyTemplate" />
            </table>
          </td>
        </tr>
        <tr>
          <td height="5">
            <img src="/_layouts/images/blank.gif" width="1" height="5" alt="" />
          </td>
        </tr>
      </xsl:if>
    </table>
    <xsl:apply-templates mode="footer" select="."/>
  </xsl:template>
  <!-- BaseViewID='3' and TemplateType='102' is for Survey -->
  <xsl:template match="View[@BaseViewID='3' and List/@TemplateType='102']" mode="RootTemplate">
      <table class="ms-summarystandardbody" cellpadding="0" cellspacing="0" width="600px" style="margin: 10px;" border="0" rules="rows">
        <tr>
          <td class="ms-formlabel" width="190px" id="overview01">
            <xsl:value-of select="$Rows/@resource.wss.survey_name"></xsl:value-of>
          </td>
          <td class="ms-formbody" >
            <xsl:value-of select="$XmlDefinition/List/@title"/>
          </td>
        </tr>
        <tr>
          <td class="ms-formlabel" valign="top" id="overview02">
            <xsl:value-of select="$Rows/@resource.wss.survey_desc"></xsl:value-of>
          </td>
          <td class="ms-formbody">
            <xsl:value-of select="$XmlDefinition/List/@description"/>
          </td>
        </tr>
        <tr>
          <td class="ms-formlabel" id="overview03">
            <xsl:value-of select="$Rows/@resource.wss.time_created"></xsl:value-of>
          </td>
          <td class="ms-formbody">
            <xsl:value-of select="$XmlDefinition/List/@created"/>
          </td>
        </tr>
        <tr>
          <td class="ms-formlabel" id="overview04">
            <xsl:value-of select="$Rows/@resource.wss.number_of_response"></xsl:value-of>
          </td>
          <td class="ms-formbody">
            <xsl:value-of select="$dvt_RowCount"/>
          </td>
        </tr>
        <tr>
          <td>
            <img src="/_layouts/images/blank.gif" width="1" height="1" alt="" />
          </td>
        </tr>
      </table>
      <table border="0" style="margin: 0px 8px 0px 8px;">
        <tr>
          <td>
            <img src="/_layouts/images/blank.gif" width="1" height="4" alt=""/>
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap">
            <img src="/_layouts/images/rect.gif" alt=""/>
            <span class="ms-toolbar">
              <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            </span>
            <a class="ms-toolbar" accesskey="R" id="diidSurveyResults" href="{$ListUrlDir}/summary.aspx">
              <xsl:value-of select="$Rows/@resource.wss.Graphical_Summary_Responses"/>
            </a>
            <span class="ms-toolbar">
              <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            </span>
          </td>
        </tr>
        <tr>
          <td nowrap="nowrap">
            <img src="/_layouts/images/rect.gif" alt=""/>
            <span class="ms-toolbar">
              <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            </span>
            <a class="ms-toolbar" accesskey="U" id="diidResultsByUser" href="{$ListUrlDir}/AllItems.aspx">
              <xsl:value-of select="$Rows/@resource.wss.Show_All_Responses"/>
            </a>
            <span class="ms-toolbar">
              <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            </span>
          </td>
        </tr>
      </table>
  </xsl:template>
  <xsl:template match="FieldRef" mode="aggregate" ddwrt:dvt_mode="body">
    <xsl:param name="Rows" select="."/>
    <xsl:param name="GroupLevel" select="1"/>
    <td class="ms-vb2" colspan="3">
      <xsl:variable name="fieldName" select="@Name"/>
      <xsl:if test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]">
        <xsl:variable name="title">
          <xsl:choose>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='COUNT'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalCount"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='SUM'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalSum"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='AVG'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalAverage"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='MAX'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalMaximum"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='MIN'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalMinimum"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='STDEV'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalStdDeviation"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='VAR'">
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalVariance"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$Rows/../@resource.wss.viewedit_totalCount"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="aggregateLevel">
          <xsl:choose>
            <xsl:when test="$GroupLevel = 1">.agg</xsl:when>
            <xsl:when test="$GroupLevel = 2">.agg2</xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="aggregateName">
          <xsl:choose>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='COUNT'">
              <xsl:value-of select="concat(@Name, '.COUNT', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='SUM'">
              <xsl:value-of select="concat(@Name, '.SUM', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='AVG'">
              <xsl:value-of select="concat(@Name, '.AVG', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='MAX'">
              <xsl:value-of select="concat(@Name, '.MAX', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='MIN'">
              <xsl:value-of select="concat(@Name, '.MIN', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='STDEV'">
              <xsl:value-of select="concat(@Name, '.STDEV', $aggregateLevel)"/>
            </xsl:when>
            <xsl:when test="$XmlDefinition/Aggregations/FieldRef[@Name=$fieldName]/@Type='VAR'">
              <xsl:value-of select="concat(@Name, '.VAR', $aggregateLevel)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(@Name, '.COUNT', $aggregateLevel)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:if test="not($title='')">
          <nobr>
            <b>
              <i>
                Found <xsl:value-of select="$Rows/@*[name()=$aggregateName]"/> Position Description(s):
              </i>
            </b>
          </nobr>
        </xsl:if>
      </xsl:if>
    </td>
  </xsl:template>
  <xsl:template match="View[@BaseViewID='8' and List/@TemplateType='109']" mode="RenderView">
    <xsl:for-each select="$AllRows">
      <xsl:variable name="thisNode" select="."/>
      <xsl:variable name="ID">
        <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
      </xsl:variable>
      <xsl:variable name="FSObjType">
        <xsl:choose>
          <xsl:when test="$EntityName != ''">0</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$thisNode/@FSObjType"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <script type="text/javascript">
        <xsl:variable name="url">
          <xsl:call-template name="EncodedAbsUrl">
            <xsl:with-param name="thisNode" select ="$thisNode"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="@Created_x0020_Date.ifnew='1'">fNewItem = true;</xsl:when>
          <xsl:otherwise>fNewItem = false;</xsl:otherwise>
        </xsl:choose>
        InsertItem("<xsl:value-of select='$url'/>" ,"<xsl:value-of select='$ID'/>", "<xsl:value-of select='$thisNode/@FileLeafRef.Name'/>",
        "<xsl:value-of select='$thisNode/@FileLeafRef.Suffix'/>", "<xsl:value-of select='$thisNode/@ImageWidth'/>", "<xsl:value-of select='$thisNode/@ImageHeight'/>",
        "<xsl:value-of select='$thisNode/@Title.urlencoded'/>", "<xsl:value-of select='$thisNode/@Description.urlencoded'/>", "<xsl:value-of select='$FSObjType'/>",
        "/_layouts/images/<xsl:value-of select='$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico'/>", fNewItem);
        items[<xsl:value-of select='$ID'/>].createdDate = "<xsl:value-of select ='$thisNode/@ImageCreateDate'/>";
      </script>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="View[@BaseViewID='8' and List/@TemplateType='109']" mode="footer" ddwrt:ghost="always">
    <span id="selectionCacheMgr" class="userdata"></span>
    <span id="DebugBox"></span>
    <script type="text/javascript">
      strSeperator = "&amp;";
      if (ctx.displayFormUrl.indexOf("?") == -1)
            strSeperator = "?";
      urlCmdForDisplay = ctx.displayFormUrl + strSeperator + "RootFolder=<xsl:value-of select ='List/@RootFolder'/>";
      RecursiveViewHeaderScript("slideshow", "<xsl:value-of select='List/@ImageWidth'/>", "<xsl:value-of select='List/@ImageHeight'/>",
      "<xsl:value-of select='List/@ThumbnailSize'/>");
      currentPicture = 0;
      RecursiveViewFooterScript();
    </script>
  </xsl:template>
  <!-- BaseViewID='3' and TemplateType='101' is web folder view for DocumentLibrary -->
  <!-- BaseViewID='3' and TemplateType='109' is web folder view for PictureLibrary -->
  <!-- BaseViewID='3' and TemplateType='115' is web folder view for XMLForm Library -->
  <!-- BaseViewID='8' and TemplateType='119' is web folder view for WebPageLibrary -->
  <xsl:template name="RenderExplorerView" match="View[(@BaseViewID='3' and (List/@TemplateType='101' or List/@TemplateType='109' or List/@TemplateType='115' or List/@TemplateType='1302')) or (@BaseViewID='8' and List/@TemplateType='119')]" mode="full" ddwrt:ghost="always">
    <xsl:variable name="urldestination">
      <xsl:choose>
        <xsl:when test="List/@RootFolder=''" ddwrt:cf_ignore="1"><xsl:value-of select="$ListUrlDir"/></xsl:when>
        <xsl:otherwise ddwrt:cf_ignore="1"><xsl:value-of select="$HttpHost"/><xsl:value-of select="List/@RootFolder"/>/</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <iframe id="expFrame" width="100%" height="500px" name="expFrame" src="/_layouts/blank.htm"></iframe>
    <script>
      function navtoframe()
      {
      }
      function navtoframe2()
      {
      NavigateHttpFolderIfSupported("<xsl:value-of select="$urldestination" />", "expFrame");
      }
      var _spBodyOnLoadFunctionNames;
      if (_spBodyOnLoadFunctionNames == null)
      {
      _spBodyOnLoadFunctionNames = new Array();
      }
      _spBodyOnLoadFunctionNames.push("navtoframe2");
    </script>
  </xsl:template>
  <!-- newsletter (noline or not) -->
  <xsl:template match="View[ViewStyle/@ID='15']" mode="full">
    <xsl:variable name="Fields" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
    <xsl:variable name="NumColumns" select="count($Fields[not(@Type='Note' or preceding-sibling::*[@Type='Note'])])"/>
    <tr valign="top" class="ms-viewheadertr">
      <xsl:if test="not($GroupingRender)">
        <xsl:apply-templates mode="header" select="$Fields[position() &lt;= $NumColumns]"/>
      </xsl:if>
    </tr>
    <xsl:apply-templates select="." mode="RenderView" />
    <xsl:apply-templates mode="footer" select="." />
  </xsl:template>
  <xsl:template match="View[ViewStyle/@ID='16']" mode="full">
    <xsl:variable name="Fields" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
    <tr valign="top" class="ms-viewheadertr">
      <xsl:if test="not($GroupingRender)">
        <xsl:if test="$MasterVersion=4 and $TabularView='1'">
          <th class="ms-vh-icon" scope="col"><input type="checkbox" title="{$select_deselect_all}" onclick="ToggleAllItems(event,this,{$ViewCounter})" onfocus="EnsureSelectionHandlerOnFocus(event,this,{$ViewCounter})" /></th>
        </xsl:if>
        <xsl:apply-templates mode="header" select="$Fields"/>
      </xsl:if>
    </tr>
    <xsl:apply-templates select="." mode="RenderView" />
    <xsl:apply-templates mode="footer" select="." />
  </xsl:template>
  <!-- Boxed and Boxed No Labels -->
  <!-- Issues Boxed and Issues Boxed No Labels -->
  <xsl:template match="View[ViewStyle/@ID='12' or ViewStyle/@ID='13' or ViewStyle/@ID='18' or ViewStyle/@ID='19']" mode="full">
    <tr>
      <td colspan="3">
        <table border="0" cellPadding="0" cellSpacing="0" width="100%">
          <tr valign="top" class="ms-viewheadertr">
            <xsl:if test="not($GroupingRender)">
              <xsl:apply-templates mode="header" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
            </xsl:if>
          </tr>
        </table>
      </td>
    </tr>
    <xsl:apply-templates select="." mode="RenderView" />
  </xsl:template>
  <!-- Document Details -->
  <xsl:template match="View[ViewStyle/@ID='14']" mode="full" ddwrt:ghost="always">
    <xsl:apply-templates select="." mode="RenderView" />
  </xsl:template>
  <!-- Preview Pane     -->
  <xsl:template match="View[ViewStyle/@ID='20']" mode="full">
    <script>
      function showpreview<xsl:value-of select="$ViewCounter"/>(o) { 
      count = 1;
      for(i = 0; i &lt; o.childNodes.length; i++)
      {
      var child = o.childNodes[i];
      if (child.style.display == "none" &amp;&amp; child.tagName == "DIV")
      {
          f = document.getElementById("n" + count + "<xsl:value-of select ="$WPQ"/>");
          f.innerHTML =  unescape(child.innerHTML) + '&amp;nbsp;';
          count ++;
        }
      }
     }
    </script>
    <div id="previewpaneerror{$ViewCounter}"></div>
    <table width="100%" cellspacing="0" cellpadding="0" border="0" style="" id="previewpanetable{$ViewCounter}" dir="{List/@Direction}">
      <xsl:choose>
        <xsl:when test="not($dvt_RowCount=0)">
          <tr>
            <td valign="top">
              <div class="ms-ppleft">
                <table width="100%" cellspacing="0" cellpadding="0" border="0">
                  <xsl:apply-templates select="." mode="RenderView"/>
                </table>
              </div>
            </td>
            <td valign="top">
              <div id="preview1" class="ms-ppright">
                <table class="ms-formtable" border="0" cellpadding="0" cellspacing="0" width="100%">
                  <!-- Add a preview cell for each of the visible fields -->
                  <xsl:for-each select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
                    <tr>
                      <td nowrap="nowrap" valign="top" width="190px"  class="ms-formlabel">
                        <nobr>
                          <xsl:value-of select="@DisplayName"/>
                        </nobr>
                      </td>
                      <td valign="top" class="ms-formbody" width="400px" id="n{position()}{$WPQ}">
                        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </tr>
                  </xsl:for-each>
                </table>
              </div>
            </td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
          <!-- No list entries -->
          <tr>
            <td class="ms-vb">
              <table class="ms-summarycustombody" cellpadding="0" cellspacing="0" border="0">
                <xsl:call-template name="EmptyTemplate" />
              </table>
            </td>
          </tr>
          <tr>
            <td height="5">
              <img src="/_layouts/images/blank.gif" width="1" height="5" alt="" />
            </td>
          </tr>    
        </xsl:otherwise>
      </xsl:choose>      
    </table>
  </xsl:template>
  <!-- *********************************************** -->
  <!-- *                                             * -->
  <!-- *  Row Templates                              * -->
  <!-- *                                             * -->
  <!-- *********************************************** -->
  <!-- default -->
  <xsl:template mode="Item" match="Row">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Last" select="1" />
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FSObjType">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">0</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./@FSObjType"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="altClass">
      <xsl:choose>
        <xsl:when test="$Position mod 2 = 0">ms-alternating</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hoverClass">
      <xsl:choose>
        <xsl:when test="($TabularView='1' and $MasterVersion=4) or $InlineEdit">ms-itmhover</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="EditMode" select="$dvt_form_key = @ID or $dvt_form_key = @BdcIdentity"/>
    <tr>
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:value-of select="normalize-space(concat($altClass, ' ', $hoverClass))"/>
      </xsl:attribute>
      <xsl:if test="($TabularView='1' and $MasterVersion=4) or $InlineEdit">
        <xsl:attribute name="iid">
          <xsl:value-of select="$ViewCounter"/>,<xsl:value-of select="$ID"/>,<xsl:value-of select="$FSObjType"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$EditMode">
        <xsl:attribute name="automode">
          <xsl:value-of select ="$ViewCounter"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$TabularView='1' and $MasterVersion=4">
        <td class="ms-vb-itmcbx ms-vb-firstCell"><input type="checkbox" class="s4-itm-cbx"/></td>
      </xsl:if>
      <xsl:if test="$InlineEdit">
        <xsl:call-template name="AutoModeHeader"/>
      </xsl:if>
      <xsl:for-each select="$Fields">
        <xsl:choose>
          <xsl:when test="$EditMode and not(@ReadOnly='TRUE') and not(@FieldType='Recurrence') and not(@FieldType='CrossProjectLink')">
            <xsl:call-template name="AutoModeForm">
              <xsl:with-param name="thisNode" select="$thisNode" />
              <xsl:with-param name="Position" select="$Position"/>
              <xsl:with-param name="Fields" select="$Fields"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </tr>
  </xsl:template>
  <xsl:template name="FieldRef_printTableCell_EcbAllowed" match="FieldRef" mode="printTableCellEcbAllowed" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="class" />
    <td>
      <xsl:if test="@ClassInfo='Menu' or @ListItemMenu='TRUE'">
        <xsl:attribute name="height">100%</xsl:attribute>
        <xsl:attribute name="onmouseover">OnChildItem(this)</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:call-template name="getTDClassValue">
          <xsl:with-param name="class" select="$class" />
          <xsl:with-param name="Type" select="@Type"/>
          <xsl:with-param name="ClassInfo" select="@ClassInfo"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="PrintFieldWithECB">
        <xsl:with-param name="thisNode" select="$thisNode"/>
      </xsl:apply-templates>
    </td>
  </xsl:template>
  <xsl:template name="FieldRef_printTableCell_NoEcb" match="FieldRef" mode="printTableCellNoEcb" ddwrt:dvt_mode="body">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="class" />
    <td>
      <xsl:if test="@ClassInfo='Menu' or @ListItemMenu='TRUE'">
        <xsl:attribute name="height">100%</xsl:attribute>
        <xsl:attribute name="onmouseover">OnChildItem(this)</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:call-template name="getTDClassValue">
          <xsl:with-param name="class" select="$class" />
          <xsl:with-param name="Type" select="@Type"/>
          <xsl:with-param name="ClassInfo" select="@ClassInfo"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
        <xsl:with-param name="thisNode" select="$thisNode"/>
      </xsl:apply-templates>
    </td>
  </xsl:template>
  <xsl:template name="AutoModeHeader">
    <xsl:param name="mode"/>
    <xsl:param name="hidden"/>
    <td width="1%" style="vertical-align: top; padding-top:3px;">
      <xsl:if test="not($TabularView='1' and $MasterVersion=4)">
        <xsl:attribute name="class">ms-vb-firstCell</xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="$dvt_form_key = @ID or $dvt_form_key = @BdcIdentity or $mode='Edit'">
          <nobr>
          <a href="javascript: {ddwrt:GenFireServerEvent('__commit')}">
            <img src="/_layouts/images/saveitem.gif" border="0" alt="{$Rows/@resource.wss.htmledit_save}"/>
          </a>
          <span style="height:16px;width:16px;position:relative;display:inline-block;overflow:hidden;" class="s4-clust"><a href="javascript: {ddwrt:GenFireServerEvent('__cancel')}" style="height:16px;width:16px;display:inline-block;" ><img src="/_layouts/images/fgimg.png" alt="{$Rows/@resource.wss.viewedit_cancel}" style="left:-0px !important;top:-138px !important;position:absolute;" border="0" /></a></span>
          </nobr>
        </xsl:when>
        <xsl:when test="$mode='Insert'">
          <xsl:attribute name="class">s4-itm-hdrcol</xsl:attribute>
          <xsl:if test="$hidden">
            <xsl:attribute name="style">display:none</xsl:attribute>
          </xsl:if>
          <span style="height:10px;width:10px;position:relative;display:inline-block;overflow:hidden;" class="s4-clust"><a href="javascript: {ddwrt:GenFireServerEvent('__cancel;dvt_form_key={-1}')}" style="height:10px;width:10px;display:inline-block;" ><img src="/_layouts/images/fgimg.png" alt="{$Rows/@resource.wss.lstsetng_pagetitle_new}" style="left:-0px !important;top:-128px !important;position:absolute;" border="0" /></a></span>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="requiresCheckout">
              <xsl:call-template name="EditRequiresCheckout">
                <xsl:with-param name="thisNode" select ="."/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:if test="$requiresCheckout = 1">
                <xsl:attribute name="requiresCheckout"></xsl:attribute>
            </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>
  <xsl:template name="AutoModeForm">
    <xsl:param name="thisNode" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Fields" select="."/>
    <xsl:param name="mode"/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="$thisNode"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="IDField">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">BdcIdentity</xsl:when>
        <xsl:otherwise>ID</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <td class="ms-vb" onkeydown="CoreInvoke('HandleInlineEditKeyDown',this)">
      <xsl:choose>
        <xsl:when test="$mode='Insert'">
          <SharePoint:FormField runat="server" id="ff{count($Fields) - position()}{$Position}" ControlMode="New" FieldName="{@RealFieldName}"
                                __designer:bind="{ddwrt:DataBind('i',concat('ff', string(count($Fields)-position()), $Position),'Value','ValueChanged',string($IDField),'', string(@RealFieldName))}"/>
        </xsl:when>
        <xsl:otherwise>
          <SharePoint:FormField runat="server" id="ff{count($Fields) - position()}{$Position}" ControlMode="Edit" FieldName="{@RealFieldName}" ItemIdAsString="{$ID}"
                                __designer:bind="{ddwrt:DataBind('u',concat('ff', string(count($Fields)-position()), $Position),'Value','ValueChanged',string($IDField),ddwrt:EscapeDelims(string($ID)), string(@RealFieldName))}"/>
        </xsl:otherwise>
      </xsl:choose>
      <SharePoint:FieldDescription runat="server" id="ff{count($Fields) - position()}description{$Position}" FieldName="{@RealFieldName}" ControlMode="Edit"/>
    </td>
  </xsl:template>
  <!-- BaseViewID='0' and TemplateType='104' is Home Page View for Announcements List -->
  <xsl:template mode="Item" match="Row[../../@BaseViewID='0' and ../../@TemplateType='104']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Last" select="1" />
    <xsl:variable name="thisNode" select="."/>
    <tr>
      <td width="80%" class="ms-vb" style="padding-bottom: 3px">
        <span class="ms-announcementtitle">
          <a onfocus="OnLink(this)"
             href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}"
             onclick="GoToLink(this);return false;" target="_self">
            <xsl:value-of select="$thisNode/@Title"/>
          </a>
          <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
            <xsl:call-template name="NewGif">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:call-template name="FieldRef_Attachments_body">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
          <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        </span>
        <br />
        <xsl:value-of select="$Rows/@resource.wss.searchresults_by"/>
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of disable-output-escaping="yes" select="$thisNode/@Author.span"/>
      </td>
      <td width="20%" align="right" nowrap="nowrap" class="ms-vb">
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of select="$thisNode/@Modified"/>
      </td>
    </tr>
    <tr>
      <td colspan="2" class="ms-vb">
        <div>
          <xsl:value-of select="$thisNode/@Body" disable-output-escaping ="yes"/>
        </div>
        <!-- output the remaining fields -->
        <xsl:for-each select="$Fields[not(@Name='Title' or @Name='Modified' or @Name='Author' or @Name='Body' or @Name='Attachments')]">
          <br />
          <xsl:value-of select="@DisplayName"/>:
          <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </td>
    </tr>
    <tr>
      <td>
        <font size="1">
          <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        </font>
      </td>
    </tr>
  </xsl:template>
  <!-- BaseViewID='0' and TemplateType='106' is Home Page View for Events List -->
  <xsl:template mode="Item" match="Row[../../@BaseViewID='0' and ../../@TemplateType='106']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Last" select="1" />
    <xsl:variable name="thisNode" select="."/>
    <tr>
      <td nowrap="nowrap" align="top" class="ms-vb">
        <nobr>
          <xsl:value-of select="$thisNode/@EventDate"/>
        </nobr>
      </td>
      <td>
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
      </td>
      <td width="90%" align="top" class="ms-vb" style="padding-bottom:3px;">
        <a onfocus="OnLink(this)"
           href="{$FORM_DISPLAY}&amp;ID={$thisNode/@ID}"
           onclick="GoToLink(this);return false;"
           target="_self">
          <xsl:value-of select="$thisNode/@Title"/>
        </a>
        <xsl:if test="$thisNode/@Created_x0020_Date.ifnew='1'">
          <xsl:call-template name="NewGif">
            <xsl:with-param name="thisNode" select="$thisNode"/>
          </xsl:call-template>
        </xsl:if>
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        <div>
          <xsl:value-of disable-output-escaping="yes" select="$thisNode/@Description"/>
        </div>
      </td>
    </tr>
  </xsl:template>
  <!-- BaseViewID='0' and TemplateType='104' is Home Page View for Links List -->
  <xsl:template mode="Item" match="Row[../../@BaseViewID='0' and ../../@TemplateType='103']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Last" select="1" />
    <xsl:variable name="thisNode" select="."/>
    <tr>
      <td style="padding-bottom: 5px" class="ms-vb">
        <img src="/_layouts/images/square.gif" alt="" />
        <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
      </td>
      <td style="padding-bottom: 5px;padding-left: 5px;" class="ms-vb">
        <xsl:call-template name="FieldRef_Computed_URLwMenu_body">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:call-template>
      </td>
    </tr>
  </xsl:template>
  <!--  0 = Basic Table -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='0']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1" />
    <xsl:param name="Last" select="1" />
    <xsl:variable name="thisNode" select="."/>
    <tr>
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>    
      <xsl:attribute name="class">
        <xsl:if test="$Position mod 2 = 0">ms-alternating</xsl:if>
      </xsl:attribute>
      <xsl:for-each select="$Fields">
        <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </tr>
  </xsl:template>
  <!--  6 = Picture Library Details -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='6']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="url">
      <xsl:call-template name="EncodedAbsUrl">
        <xsl:with-param name="thisNode" select ="$thisNode"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$url = ''">
        <tr valign="top">
          <xsl:if test="$Collapse">
            <xsl:attribute name="style">display:none</xsl:attribute>
          </xsl:if>
          <xsl:for-each select="$Fields">
            <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:for-each>
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr valign="top" id="row{@ID}">
          <xsl:if test="$Collapse">
            <xsl:attribute name="style">display:none</xsl:attribute>
          </xsl:if>
          <script>
            <xsl:choose>
              <xsl:when test="@Created_x0020_Date.ifnew='1'">fNewItem = true;</xsl:when>
              <xsl:otherwise>fNewItem = false;</xsl:otherwise>
            </xsl:choose>
            InsertItem("<xsl:value-of select='$url'/>" ,"<xsl:value-of select='@ID'/>", "<xsl:value-of select='@FileLeafRef.Name'/>",
            "<xsl:value-of select='@FileLeafRef.Suffix'/>", "<xsl:value-of select='@ImageWidth'/>", "<xsl:value-of select='@ImageHeight'/>",
            "<xsl:value-of select='@Title.urlencoded'/>", "<xsl:value-of select='@Description.urlencoded'/>", "<xsl:value-of select='@FSObjType'/>",
            "/_layouts/images/<xsl:value-of select='@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico'/>", fNewItem);
          </script>
          <xsl:for-each select="$Fields">
            <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:for-each>
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- 12 = Boxed No Labels -->
  <!-- 13 = Boxed -->
  <!-- 18 = Issues Boxed -->
  <!-- 19 = Issues Boxed No Lines -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='12' or ../../@ViewStyleID='13' or ../../@ViewStyleID='18' or ../../@ViewStyleID='19']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="ShowLabels">
      <xsl:choose>
        <xsl:when test="../../@ViewStyleID='13' or ../../@ViewStyleID='18'">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FSObjType">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="./@FSObjType"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="labelWidth">
      <xsl:choose>
        <xsl:when test='$ShowLabels=1'>20%</xsl:when>
        <xsl:otherwise>20px</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bodyWidth">
      <xsl:choose>
        <xsl:when test='$ShowLabels=1'>80%</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <td valign="top" width="50%" class="ms-stylebox">
      <table border="0" width="100%">
        <xsl:for-each select="$Fields">
          <tr>
            <td class="ms-stylelabel">
              <xsl:attribute name="width"><xsl:value-of select="$labelWidth"/></xsl:attribute>
              <xsl:if test='$ShowLabels=1'>
                <xsl:value-of select="@DisplayName"/>
              </xsl:if>
            </td>
            <td class="ms-stylebody">
              <xsl:attribute name="width"><xsl:value-of select="$bodyWidth"/></xsl:attribute>
              <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:apply-templates>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </td>
    <xsl:call-template name="NewTRJumbo">
      <xsl:with-param name="Position" select="$Position"/>
      <xsl:with-param name="Collapse" select="$Collapse"/>
    </xsl:call-template>
  </xsl:template>
  <!-- 14 = Document Details -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='14']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FSObjType">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="./@FSObjType"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="targetUrl">
      <xsl:choose>
        <!-- this is a URL from the links list, so we should dump in the displayform url instead -->
        <xsl:when test="substring(@FileRef, string-length(@FileRef) - 4) = '_.000'">
          <xsl:value-of select="$FORM_DISPLAY"/>&amp;ID=<xsl:value-of select="$ID"/>
        </xsl:when>
        <!-- regular files just use the file ref -->
        <xsl:otherwise>
          <xsl:value-of select="@FileRef"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <table border="0" width="100%" cellspacing="0">
        <tr class="ms-styleheader">
          <td class="ms-detailhdricon" width="10%">
            <xsl:choose>
              <xsl:when test="@FSObjType='1'">
                <xsl:variable name="alttext">
                  <xsl:value-of select="../@listformtitle_folder"/>: <xsl:value-of select="@FileLeafRef"/>
                </xsl:variable>
                <!-- This is a folder -->
                <xsl:variable name="mapico" select="$thisNode/@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico"/>
                <xsl:variable name="folderIconPath">
                  <xsl:call-template name="GetFolderIconSourcePath">
                    <xsl:with-param name="thisNode" select="$thisNode"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$RecursiveView='1'">
                    <img border="0" alt="{$alttext}" src="{$folderIconPath}" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:variable name="FolderCTID">
                      <xsl:value-of select="$PagePath" />?RootFolder=<xsl:value-of select="@FileRef.urlencode" />&amp;FolderCTID=<xsl:value-of select="@ContentTypeId" />
                    </xsl:variable>
                    <a tabindex="-1" href="{$FolderCTID}" onclick="javascript:EnterFolder(&quot;{$FolderCTID}&quot;);javascript:return false;">
                      <img border="0" alt="{$alttext}" title="{$alttext}" src="{$folderIconPath}" />
                    </a>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <!-- Not a Folder -->
                  <xsl:choose>
                    <xsl:when test="not (@CheckoutUser.id) or @CheckoutUser.id =''">
                      <img border="0" alt="{@FileLeafRef}" title="{@FileLeafRef}" src="/_layouts/images/{@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico}" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:variable name="alttext">
                        <xsl:value-of select="@FileLeafRef"/>&#10;<xsl:value-of select="../@managecheckedoutfiles_header_checkedoutby"/>: <xsl:value-of select="@CheckoutUser.title"/>
                      </xsl:variable>
                      <img border="0" alt="{$alttext}" title="{$alttext}" src="/_layouts/images/{@HTML_x0020_File_x0020_Type.File_x0020_Type.mapico}" />
                      <img src="/_layouts/images/checkoutoverlay.gif" class="ms-vb-icon-overlay" alt="{$alttext}" title="{$alttext}" />
                    </xsl:otherwise>
                  </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </td>
          <td colspan="2" class="ms-detailhdrmid" width="80%">
            <a onfocus="OnLink(this)" href="{$targetUrl}" onmousedown="return VerifyHref(this,event,'{$XmlDefinition/List/@DefaultItemOpen}','{@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','')" 
            onclick="return DispEx(this,event,'','','','','{$XmlDefinition/List/@DefaultItemOpen}','{@HTML_x0020_File_x0020_Type.File_x0020_Type.mapcon}','{@HTML_x0020_File_x0020_Type}','','{@CheckoutUser.id}','{$Userid}','{$XmlDefinition/List/@ForceCheckout}','{@IsCheckedoutToLocal}','{@PermMask}')">
              <xsl:value-of select='@FileLeafRef.Name'/>
            </a>
            <xsl:if test="@Created_x0020_Date.ifnew='1'">
              <xsl:call-template name="NewGif">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:call-template>
            </xsl:if>
          </td>
          <td align="right" class="ms-detailhdredit" width="10%">
            <xsl:call-template name="FieldRef_Edit_body">
              <xsl:with-param name="thisNode" select="."/>
            </xsl:call-template>
          </td>
        </tr>
        <xsl:for-each select="$Fields[not(@Name='Edit') and not(@Name='LinkFilenameNoMenu') and not(@Name='DocIcon')]">
          <tr>
            <td><xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text></td>
            <td class="ms-detailbtitle" width="25%">
              <span class="ms-stylelabel">
                <xsl:value-of select="@DisplayName"/>
              </span>
            </td>
            <td class="ms-stylebody" width="75%">
              <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:apply-templates>
            </td>
            <td><xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text></td>
          </tr>
        </xsl:for-each>
      </table>
  </xsl:template>
  <!-- 15 = Newsletter -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='15']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="NumColumns" select="count($Fields[not(@Type='Note' or preceding-sibling::*[@Type='Note'])])"/>
    <xsl:variable name="thisNode" select="."/>
    <!-- only create item separator for non-No Line viewstyle.-->
    <xsl:if test="../../@ViewStyleID='15'">
      <tr>
        <td class="ms-newsletterline" colspan="{$NumColumns}">
          <img src="/_layouts/images/blank.gif" width="100%" height="4" alt="" />
        </td>
      </tr>
    </xsl:if>
    <tr>
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>    
      <xsl:if test="$Position mod 2 = 1">
        <xsl:attribute name="class">ms-alternating ms-newsletteralt</xsl:attribute>
      </xsl:if>
      <xsl:for-each select="$Fields[position() &lt;= $NumColumns]">
        <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </tr>
    <xsl:for-each select="$Fields[position() &gt; $NumColumns]">
      <tr>
        <td class = "ms-vb-tall" colspan="{$NumColumns}">
          <xsl:if test="not(@Type='Note')">
            <xsl:value-of select="@DisplayName"/>:
          </xsl:if>
          <xsl:choose>
            <xsl:when test="@Type='User'">
              <xsl:value-of select="$thisNode/@*[name()=concat(current()/@Name, '.span')]" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
                <xsl:with-param name="thisNode" select="$thisNode"/>
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </xsl:for-each>
    <!-- hasbody-->
    <xsl:if test="$NumColumns &lt; count($Fields)">
      <tr>
        <td colspan="{$NumColumns}">
          <img src="/_layouts/images/blank.gif" width="100%" height="4" alt="" />
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
  <!-- 16 = Newsletter NoLine-->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='16']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FSObjType">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">0</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./@FSObjType"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr>
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="isEcb">TRUE</xsl:attribute>    
      <xsl:if test="$Position mod 2 = 1">
        <xsl:attribute name="class">ms-alternating ms-newsletteralt</xsl:attribute>
      </xsl:if>
      <xsl:if test="($TabularView='1' and $MasterVersion=4)">
        <xsl:attribute name="iid">
          <xsl:value-of select="$ViewCounter"/>,<xsl:value-of select="$ID"/>,<xsl:value-of select="$FSObjType"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$TabularView='1' and $MasterVersion=4">
        <td class="ms-vb-itmcbx ms-vb-firstCell"><input type="checkbox" class="s4-itm-cbx"/></td>
      </xsl:if>
      <xsl:for-each select="$Fields">
        <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </tr>
  </xsl:template>
  <!-- 17 = Shaded -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='17']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="1"/>
    <xsl:param name="Last" select="1"/>
    <xsl:variable name="thisNode" select="."/>
    <xsl:variable name="ID">
      <xsl:call-template name="ResolveId"><xsl:with-param name="thisNode" select ="."/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="FSObjType">
      <xsl:choose>
        <xsl:when test="$EntityName != ''">0</xsl:when>
        <xsl:otherwise><xsl:value-of select="./@FSObjType"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="altClass">
      <xsl:choose>
        <xsl:when test="$Position mod 2 = 0">ms-alternatingstrong</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hoverClass">
      <xsl:choose>
        <xsl:when test="($TabularView='1' and $MasterVersion=4) or $InlineEdit">ms-itmhover</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr>
      <xsl:if test="$Collapse">
        <xsl:attribute name="style">display:none</xsl:attribute>
      </xsl:if>    
      <xsl:attribute name="class">
        <xsl:value-of select="normalize-space(concat($altClass, ' ', $hoverClass))"/>
      </xsl:attribute>
      <xsl:if test="($TabularView='1' and $MasterVersion=4) or $InlineEdit">
        <xsl:attribute name="iid">
          <xsl:value-of select="$ViewCounter"/>,<xsl:value-of select="$ID"/>,<xsl:value-of select="$FSObjType"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$TabularView='1' and $MasterVersion=4">
        <td class="ms-vb-itmcbx ms-vb-firstCell"><input type="checkbox" class="s4-itm-cbx"/></td>
      </xsl:if>
      <xsl:for-each select="$Fields">
        <xsl:apply-templates select="." mode="printTableCellEcbAllowed">
          <xsl:with-param name="thisNode" select="$thisNode"/>
        </xsl:apply-templates>
      </xsl:for-each>
    </tr>
  </xsl:template>
  <!-- 20 = Preview Pane -->
  <xsl:template mode="Item" match="Row[../../@ViewStyleID='20']">
    <xsl:param name="Fields" select="."/>
    <xsl:param name="Collapse" select="."/>
    <xsl:param name="Position" select="0" />
    <xsl:param name="Last" select="100000" />
    <xsl:variable name="thisNode" select="."/>
    <tr>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="$Position mod 2 = 0">ms-ppanerow</xsl:when>
          <xsl:otherwise>ms-alternating ms-ppanerowalt</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <td class="ms-vb-title" onmouseover="OnChildItem(this);showpreview{$ViewCounter}(this)" onfocus="OnChildItem(this);showpreview{$ViewCounter}(this)">
        <xsl:choose>
          <xsl:when test="$Fields[@ListItemMenu='TRUE']">
            <xsl:apply-templates select="$Fields[@ListItemMenu='TRUE'][last()]" mode="PrintFieldWithECB">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="$Fields[1]" mode="PrintFieldWithECB">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="$Fields">
          <div style="display:none">
            <xsl:apply-templates select="." mode="PrintFieldWithDisplayFormLink">
              <xsl:with-param name="thisNode" select="$thisNode"/>
            </xsl:apply-templates>
          </div>
        </xsl:for-each>
      </td>
    </tr>
  </xsl:template>
  <!-- document details -->
  <xsl:template match="View[ViewStyle/@ID='14']" mode="RenderView">
    <!-- total first -->
    <xsl:if test="Aggregations[not(@Value='Off')]/FieldRef">
      <tr>
        <xsl:if test="$InlineEdit">
          <td width="1%"/>
        </xsl:if >
        <xsl:apply-templates mode="aggregate" select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
          <xsl:with-param name="Rows" select="$AllRows"/>
          <xsl:with-param name="GroupLevel" select="0"/>
        </xsl:apply-templates>
      </tr>
    </xsl:if>
    <xsl:variable name="Fields" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
    <xsl:variable name="Groups" select="Query/GroupBy/FieldRef"/>
    <xsl:variable name="Collapse" select="Query/GroupBy[@Collapse='TRUE']"/>
    <xsl:variable name="GroupCount" select="count($Groups)"/>
    <xsl:for-each select="$AllRows">
      <xsl:variable name="thisNode" select="."/>
      <!-- how do we handle grouping in document details view? -->
      <!--
      <xsl:if test="$GroupCount &gt; 0">
        <xsl:call-template name="GroupTemplate">
          <xsl:with-param name="Groups" select="$Groups"/>
          <xsl:with-param name="Collapse" select="$Collapse"/>
        </xsl:call-template>
      </xsl:if>
      -->
      <xsl:variable name="Position" select="position()" />
      <!-- work on every other row -->
      <!-- this code will pick up the -->
      <xsl:if test="$Position mod 2 = 1">
        <!-- start of new row -->
        <tr>
          <td valign="top" width="49%" class="ms-stylebox">
            <xsl:apply-templates mode="Item" select="$thisNode">
              <xsl:with-param name="Fields" select="$Fields"/>
              <xsl:with-param name="Collapse" select="$Collapse"/>
              <xsl:with-param name="Position" select="position()"/>
              <xsl:with-param name="Last" select="last()"/>
            </xsl:apply-templates>
          </td>
         <td width="1.5%">
          <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
        </td>
        <xsl:choose>
          <xsl:when test="$Position != last()">
            <td valign="top" width="49%" class="ms-stylebox">
              <xsl:apply-templates mode="Item" select="$AllRows[$Position + 1]">
                <xsl:with-param name="Fields" select="$Fields"/>
                <xsl:with-param name="Collapse" select="$Collapse"/>
                <xsl:with-param name="Position" select="position()"/>
                <xsl:with-param name="Last" select="last()"/>
              </xsl:apply-templates>
            </td>
          </xsl:when>
          <xsl:otherwise>
            <td valign="top" width="49%">
              <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
            </td>
          </xsl:otherwise>
        </xsl:choose>
        </tr>
        <tr><td><xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text></td></tr>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="View" mode="RenderView">
    <xsl:variable name="ViewStyleID">
      <xsl:value-of select="ViewStyle/@ID"/>
    </xsl:variable>
    <xsl:variable name="HasExtraColumn" select="$TabularView='1' and $MasterVersion=4 and ($ViewStyleID = '' or $ViewStyleID = '17' or $ViewStyleID = '16')"/>
    <!-- total first -->
    <xsl:if test="Aggregations[not(@Value='Off')]/FieldRef">
      <tr>
        <xsl:if test="$HasExtraColumn">
          <td/>
        </xsl:if>
        <xsl:if test="$InlineEdit">
          <td width="1%"/>
        </xsl:if >
        <!--<xsl:apply-templates mode="aggregate" select="ViewFields/FieldRef[not(@Explicit='TRUE')]">
          <xsl:with-param name="Rows" select="$AllRows"/>
          <xsl:with-param name="GroupLevel" select="0"/>
        </xsl:apply-templates>-->
      </tr>
    </xsl:if>
    <xsl:variable name="Fields" select="ViewFields/FieldRef[not(@Explicit='TRUE')]"/>
    <xsl:variable name="Groups" select="Query/GroupBy/FieldRef"/>
    <xsl:variable name="Collapse" select="Query/GroupBy[@Collapse='TRUE']"/>
    <xsl:variable name="GroupCount" select="count($Groups)"/>
    <xsl:for-each select="$AllRows">
      <xsl:variable name="thisNode" select="."/>
      <xsl:if test="$GroupCount &gt; 0">
        <xsl:call-template name="GroupTemplate">
          <xsl:with-param name="Groups" select="$Groups"/>
          <xsl:with-param name="Collapse" select="$Collapse"/>
          <xsl:with-param name="HasExtraColumn" select="$HasExtraColumn"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="not(not($NoAJAX) and not($InlineEdit) and $Collapse and $GroupCount &gt; 0)">
        <xsl:apply-templates mode="Item" select=".">
          <xsl:with-param name="Fields" select="$Fields"/>
          <xsl:with-param name="Collapse" select="$Collapse"/>
          <xsl:with-param name="Position" select="position()"/>
          <xsl:with-param name="Last" select="last()"/>
        </xsl:apply-templates>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="$InlineEdit and not($IsDocLib) and $ListRight_AddListItems = '1'">
      <xsl:call-template name="rowinsert">
        <xsl:with-param name="Fields" select="$Fields"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="rowinsert">
    <xsl:param name="Fields" select="."/>
    <xsl:variable name="ViewStyleID">
      <xsl:value-of select="../ViewStyle/@ID"/>
    </xsl:variable>
    <tr>
      <xsl:attribute name="automode">
        <xsl:value-of select ="$ViewCounter"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="$dvt_form_key = '-1'">
          <xsl:if test="$TabularView='1' and $MasterVersion=4">
            <!-- ViewStyleID ''=Default / ViewStyleID 17=Shaded -->
            <xsl:if test="$ViewStyleID = '' or $ViewStyleID = '17'">
              <td/>
            </xsl:if>
          </xsl:if>
          <xsl:call-template name="AutoModeHeader">
            <xsl:with-param name="mode" select="'Edit'"/>
          </xsl:call-template>
          <xsl:for-each select="$Fields">
            <xsl:choose>
              <xsl:when test="not(@ReadOnly='TRUE') and not(@FieldType='Recurrence') and not(@FieldType='CrossProjectLink')">
                <xsl:call-template name="AutoModeForm">
                  <xsl:with-param name="mode" select="'Insert'"/>
                  <xsl:with-param name="Fields" select="$Fields"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <td class="ms-vb"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="AutoModeHeader">
            <xsl:with-param name="mode" select="'Insert'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
    <xsl:if test="$dvt_form_key = '-1'">
      <tr>
        <xsl:call-template name="AutoModeHeader">
          <xsl:with-param name="mode" select="'Insert'"/>
          <xsl:with-param name="hidden" select="'1'"/>
        </xsl:call-template>
      </tr>
    </xsl:if>
  </xsl:template>
  <!-- *********************************************** -->
  <!-- *                                             * -->
  <!-- *  Footers                                    * -->
  <!-- *                                             * -->
  <!-- *********************************************** -->
  <xsl:template match="View" mode="footer">
  </xsl:template>
  <!-- Homepage view -->
  <xsl:template match="View[@BaseViewID='0']" mode="footer">
    <!-- 
    Footer of homepage view of event list. As it require an recurrence item 
    expanded, so there's no easy way to know whether it has more item or not.
    So here it's using $dvt_nextpagedata, if it has some value, that means there's
    something more than what's shown.
    -->
    <xsl:variable name="thisNode" select="."/>
    <!-- 106 - Events list -->
    <xsl:if test="List/@TemplateType='106' and $dvt_nextpagedata">
      <table class="ms-summarycustombody" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td class="ms-vb">
            <a href="{List/@defaultviewurl}" id="onetidMoreEvts">
              <xsl:value-of select="$Rows/@resource.wss.more_events" />
            </a>
          </td>
        </tr>
        <tr>
          <td height="8">
            <img src="/_layouts/images/blank.gif" width="1" height="8" alt="" />
          </td>
        </tr>
      </table>
    </xsl:if>
    <xsl:if test="List/@itemcount &gt; $RowLimit">
      <table class="ms-summarycustombody" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td class="ms-vb">
            <a href="{List/@defaultviewurl}" id="onetidMoreAnn">
              <xsl:value-of select="$MoreAnnouncements" />
            </a>
          </td>
        </tr>
        <tr>
          <td height="8">
            <img src="/_layouts/images/blank.gif" width="1" height="8" alt="" />
          </td>
        </tr>
      </table>
    </xsl:if>
    <xsl:if test="Toolbar[@Type='Freeform'] or ($MasterVersion=4 and Toolbar[@Type='Standard'])">
      <xsl:call-template name="Freeform">
        <xsl:with-param name="AddNewText" select="$AddNewAnnouncement"/>
        <xsl:with-param name="ID">
          <xsl:choose>
            <xsl:when test="List/@TemplateType='104'">idHomePageNewAnnouncement</xsl:when>
            <xsl:when test="List/@TemplateType='101'">idHomePageNewDocument</xsl:when>
            <xsl:when test="List/@TemplateType='103'">idHomePageNewLink</xsl:when>
            <xsl:when test="List/@TemplateType='106'">idHomePageNewEvent</xsl:when>
            <xsl:when test="List/@TemplateType='119'">idHomePageNewWikiPage</xsl:when>
            <xsl:otherwise>idHomePageNewItem</xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="Freeform">
    <xsl:param name="AddNewText"/>
    <xsl:param name="ID"/>
    <xsl:variable name="Url">
      <xsl:choose>
        <xsl:when test="List/@TemplateType='119'"><xsl:value-of select="$HttpVDir"/>/_layouts/CreateWebPage.aspx?List=<xsl:value-of select="$List"/>&amp;RootFolder=<xsl:value-of select="$XmlDefinition/List/@RootFolder"/></xsl:when>
        <xsl:when test="$IsDocLib"><xsl:value-of select="$HttpVDir"/>/_layouts/Upload.aspx?List=<xsl:value-of select="$List"/>&amp;RootFolder=<xsl:value-of select="$XmlDefinition/List/@RootFolder"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$ENCODED_FORM_NEW"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="HeroStyle">
      <xsl:choose>
        <xsl:when test="Toolbar[@Type='Standard']">display:none</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="$ListRight_AddListItems = '1' and (not($InlineEdit) or $IsDocLib)">
      <table id="Hero-{$WPQ}" width="100%" cellpadding="0" cellspacing="0" border="0" style="{$HeroStyle}">
        <tr>
          <td colspan="2" class="ms-partline">
            <img src="/_layouts/images/blank.gif" width="1" height="1" alt="" />
          </td>          
        </tr>
        <tr>
          <td class="ms-addnew" style="padding-bottom: 3px">
          <span style="height:10px;width:10px;position:relative;display:inline-block;overflow:hidden;" class="s4-clust"><img src="/_layouts/images/fgimg.png" alt="" style="left:-0px !important;top:-128px !important;position:absolute;"  /></span>
          <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
          <xsl:choose>
            <xsl:when test="List/@TemplateType = '115'">
              <a class="ms-addnew" id="{$ID}-{$WPQ}"
                 href="{$Url}"
                 onclick="javascript:NewItem2(event, &quot;{$Url}&quot;);javascript:return false;"
                 target="_self">
                <xsl:value-of select="$AddNewText" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a class="ms-addnew" id="{$ID}"
                 href="{$Url}"
                 onclick="javascript:NewItem2(event, &quot;{$Url}&quot;);javascript:return false;"
                 target="_self">
                <xsl:value-of select="$AddNewText" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
          </td>
        </tr>
        <tr>
          <td>
            <img src="/_layouts/images/blank.gif" width="1" height="5" alt="" />
          </td>
        </tr>
      </table>
      <xsl:choose>
        <xsl:when test="Toolbar[@Type='Standard']">
          <script type='text/javascript'>
            if (typeof(heroButtonWebPart<xsl:value-of select="$WPQ"/>) != "undefined")
            {
                <xsl:value-of select="concat('  var eleHero = document.getElementById(&quot;Hero-', $WPQ, '&quot;);')"/>
                if (eleHero != null)
                    eleHero.style.display = "";
            }
          </script>
        </xsl:when>
        <xsl:otherwise>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="List/@TemplateType = '115'">
          <script type='text/javascript'>
            if (typeof(DefaultNewButtonWebPart<xsl:value-of select="$WPQ"/>) != "undefined")
            {
                <xsl:value-of select="concat('  var eleLink = document.getElementById(&quot;', $ID, '-', $WPQ, '&quot;);')"/>
                if (eleLink != null)
                {
                    DefaultNewButtonWebPart<xsl:value-of select="$WPQ"/>(eleLink);
                }
            }
          </script>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:template match="View[ViewStyle/@ID='6']" mode="footer">
    <xsl:choose>
      <xsl:when test="$dvt_RowCount = 0">
        <span id="selectionCacheMgr" class="userdata"></span>
        <script>
          currentViewGuid = "<xsl:value-of select="$View"/>";
          ViewEmptyScript(<xsl:value-of select='$XmlDefinition/List/@webimagewidth'/>, <xsl:value-of select='$XmlDefinition/List/@webimageheight'/>, <xsl:value-of select='$XmlDefinition/List/@thumbnailsize'/>);
          vCurrentListUrlAsHTML = "<xsl:value-of select='$ListUrlDir'/>";
          vCurrentWebUrl = "<xsl:value-of select='$HttpVDir'/>";
        </script>
      </xsl:when>
      <xsl:otherwise>
        <rect ID="webImageSyncer" style="display:none;width:100;height:100"></rect>
        <span id="selectionCacheMgr" class="userdata" style="display:none"></span>
        <span id="DebugBox" class="ms-selectedtitle" style="display:none"></span>
        <script>
          fImglibDefautlView = true;
          strSeperator = "&amp;";
          if (ctx.displayFormUrl.indexOf("?") == -1)
            strSeperator = "?";
          urlCmdForDisplay = ctx.displayFormUrl + strSeperator + "RootFolder=<xsl:value-of select='$XmlDefinition/List/@RootFolder'/>";
          ViewHeaderScript("", <xsl:value-of select='$XmlDefinition/List/@webimagewidth'/>, <xsl:value-of select='$XmlDefinition/List/@webimageheight'/>, <xsl:value-of select='$XmlDefinition/List/@thumbnailsize'/>);
          currentPicture = 0;
          ViewFooterScript();
        </script>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="GenFireServerEvent" ddwrt:ghost="always">
    <xsl:param name="param" />
    <xsl:param name="apos">"</xsl:param>
    <xsl:value-of select="concat('__doPostBack(', $apos, $WebPartClientID, $apos, ',', $apos, $param, $apos, ')')"/>
  </xsl:template>
  <xsl:template name="CommandFooter">
    <xsl:param name="FirstRow" select="1"/>
    <xsl:param name="LastRow" select="1"/>
    <xsl:param name="dvt_RowCount" select="1"/>
    <xsl:if test="$FirstRow &gt; 1 or $dvt_nextpagedata">
      <xsl:call-template name="Navigation">
        <xsl:with-param name="FirstRow" select="$FirstRow" />
        <xsl:with-param name="LastRow" select="$LastRow" />
        <xsl:with-param name="dvt_RowCount" select="$dvt_RowCount" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="RepairLinksToolbar" ddwrt:ghost="always"/>
  <xsl:template name="ListViewToolbar" ddwrt:ghost="always">
    <table class="ms-menutoolbar" cellpadding="2" cellspacing="0" border="0" width="100%">
      <tr>
        <td class="ms-toolbar" nowrap="nowrap">
          <SharePoint:NewMenu runat="server"></SharePoint:NewMenu>
        </td>
        <xsl:if test="$IsDocLib">
          <td class="ms-toolbar">|</td>
          <td class="ms-toolbar" nowrap="nowrap">
            <SharePoint:UploadMenu runat="server" />
          </td>
        </xsl:if>
        <td class="ms-toolbar">|</td>
        <td class="ms-toolbar" nowrap="nowrap">
          <SharePoint:ActionsMenu runat="server"></SharePoint:ActionsMenu>
        </td>
        <td class="ms-toolbar">|</td>
        <td class="ms-toolbar" nowrap="nowrap">
          <SharePoint:SettingsMenu runat="server"></SharePoint:SettingsMenu>
        </td>
        <td width="99%" class="ms-toolbar" nowrap="nowrap"/>
        <td nowrap="nowrap" class="ms-toolbar">
          <table border="0" cellpadding="0" cellspacing="0" style="margin-right: 4px">
            <tr>
              <td class="ms-listheaderlabel" nowrap="nowrap">
                View:
                <xsl:text disable-output-escaping="yes" ddwrt:nbsp-preserve="yes">&amp;nbsp;</xsl:text>
              </td>
              <td nowrap="nowrap" class="ms-viewselector" id="onetViewSelector" onmouseover="this.className='ms-viewselectorhover'" onmouseout="this.className='ms-viewselector'" runat="server">
                <SharePoint:ViewSelectorMenu MenuAlignment="Right" AlignToParent="true" runat="server" id="ViewSelectorMenu" />
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  <xsl:template name="Navigation">
    <xsl:param name="FirstRow" select="1"/>
    <xsl:param name="LastRow" select="1"/>
    <xsl:param name="dvt_RowCount" select="1"/>
    <xsl:variable name="LastRowValue">
        <xsl:choose>
            <xsl:when test="$EntityName = '' or $LastRow &lt; $RowTotalCount">
              <xsl:value-of select="$LastRow"/>	
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$RowTotalCount"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="NextRow">
      <xsl:value-of select="$LastRowValue + 1"/>
    </xsl:variable>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ms-bottompaging">
      <tr>
        <td class="ms-bottompagingline1">
          <img src="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
      <tr>
        <td class="ms-bottompagingline2">
          <img src="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
      <tr>
        <td class="ms-vb" id="bottomPagingCell{$WPQ}">
          <xsl:if test="not($GroupingRender)">
            <xsl:attribute name="align">center</xsl:attribute>
          </xsl:if>
          <table>
            <tr>
              <xsl:if test="$FirstRow &lt;= $LastRowValue">
                  <td class="ms-paging">
                    Displaying <xsl:value-of select="$FirstRow" /> - <xsl:value-of select="$LastRowValue" /> of <xsl:value-of select="$AllRows/@*[name()='Title.COUNT']" />
                  </td>
              </xsl:if>
              <xsl:if test="$dvt_firstrow &gt; 1">
                <td>
                  <a class="ms-paging">
                    <xsl:choose>
                      <xsl:when test="$dvt_RowCount = 0 and not($NoAJAX)">
                        <xsl:attribute name="onclick">
                          javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$ShowWebPart"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;
                        </xsl:attribute>
                        <xsl:attribute name="href">javascript:</xsl:attribute>
                        <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idRewind}" />
                        <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idRewind}" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:variable name="RealRowLimit">
                          <xsl:choose>
                            <xsl:when test="$XmlDefinition/Query/GroupBy[@Collapse='TRUE']/@GroupLimit">
                              <xsl:value-of select ="$XmlDefinition/Query/GroupBy[@Collapse='TRUE']/@GroupLimit"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select = "$XmlDefinition/RowLimit"/>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:variable>
                        <xsl:choose>
                          <xsl:when test="not($NoAJAX)">
                            <xsl:attribute name="onclick">
                              javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_prevpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026PageFirstRow=<xsl:value-of select="$FirstRow - $RealRowLimit"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;
                            </xsl:attribute>
                            <xsl:attribute name="href">javascript:</xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name="href">
                              javascript: <xsl:call-template name="GenFireServerEvent">
                                <xsl:with-param name="param" select="concat('dvt_firstrow={',$FirstRow - $XmlDefinition/RowLimit,'};dvt_startposition={',$dvt_prevpagedata,'}')"/>
                              </xsl:call-template>
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                        [Prev <xsl:value-of select="$dvt_RowCount" />]<!--<img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idPrevious}" valign="sub" />-->
                      </xsl:otherwise>
                    </xsl:choose>
                  </a>
                </td>
              </xsl:if>
              <td> </td>
              <td> </td>
              <td> </td>
              <xsl:if test="$LastRowValue &lt; $dvt_RowCount or string-length($dvt_nextpagedata)!=0">
                <td>
                  <a class="ms-paging">
                    <xsl:choose>
                      <xsl:when test="not($NoAJAX)">
                        <xsl:attribute name="onclick">javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_nextpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026PageFirstRow=<xsl:value-of select="$NextRow"/>\u0026<xsl:value-of select='$FieldSortParam'/><xsl:value-of select='$SortQueryString'/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;</xsl:attribute>
                        <xsl:attribute name="href">javascript:</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="href">javascript: <xsl:call-template name="GenFireServerEvent">
                            <xsl:with-param name="param" select="concat('dvt_firstrow={',$NextRow,'};dvt_startposition={',$dvt_nextpagedata,'}')"/>
                          </xsl:call-template>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    [Next <xsl:value-of select="$dvt_RowCount" />]<!--<img src="/_layouts/{$LCID}/images/next.gif" border="0" alt="{$Rows/@tb_nextpage}" valign="sub" />-->
                  </a>
                </td>
              </xsl:if>
              <td> </td>
              <td> </td>
              <td> </td>
              <td>
                <a id="listAllResults" class="ms-paging" href="#">
                  [List All Results]
                </a>
                <script type="text/javascript">
				  $(document).ready(function(){
				    $("#listAllResults").click(function(){
			            $("#WebPartWPQ1").hide();
			            $("#WebPartWPQ2").show();
				    });
				  });
				</script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="ms-bottompagingline3">
          <img src="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
    </table>
    <xsl:if test="not($GroupingRender)">
    <script>
      var topPagingCell = document.getElementById("topPagingCell<xsl:value-of select='$WPQ'/>");
      var bottomPagingCell = document.getElementById("bottomPagingCell<xsl:value-of select='$WPQ'/>");
      if (topPagingCell != null &amp;&amp; bottomPagingCell != null)
      {
      topPagingCell.innerHTML = bottomPagingCell.innerHTML;
      }
    </script>
    </xsl:if>
  </xsl:template>
  <!-- 
  Current Event view of events list require special logif for paging. It's not row basis, but
  it's time basis. So just showing Previous and Next link with time information.
  -->
  <xsl:template name="CalendarExpandedRecurrenceFooter">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ms-bottompaging">
      <tr>
        <td class="ms-bottompagingline1">
          <img src="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
      <tr>
        <td class="ms-bottompagingline2">
          <img src="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
      <tr>
        <!-- having image and text in separate cells, so this can be correctly rendered in RTL environment -->
        <td class="ms-vb" id="bottomPagingCell{$WPQ}" align="center">
          <table width="100%">
            <tr>
              <xsl:if test="$dvt_prevpagedata">
                <td class="ms-paging"><!-- prev arrow image-->
                  <a>
                    <xsl:attribute name="onclick">javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_prevpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;</xsl:attribute>
                    <xsl:attribute name="href">javascript:</xsl:attribute>
                    <img src="/_layouts/{$LCID}/images/prev.gif" border="0" alt="{$Rows/@idPrevious}" />
                  </a>
                </td>
                <td class="ms-paging"><!-- prev text-->
                  <a>
                    <xsl:attribute name="onclick">javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_prevpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;</xsl:attribute>
                    <xsl:attribute name="href">javascript:</xsl:attribute>
                    <xsl:value-of select="$Rows/@idPrevious"/>
                  </a>
                </td>
              </xsl:if>
              <td class="ms-paging" width="100%">
              </td>
              <xsl:if test="$dvt_nextpagedata">
                <td class="ms-paging"><!-- next text-->
                  <a>
                    <xsl:attribute name="onclick">javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_nextpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;</xsl:attribute>
                    <xsl:attribute name="href">javascript:</xsl:attribute>
                    <xsl:value-of select="$Rows/@tb_nextpage"/>
                  </a>
                </td>
                <td class="ms-paging"><!-- next arrow image-->
                  <a>
                    <xsl:attribute name="onclick">javascript:RefreshPageTo(event, "<xsl:value-of select="$PagePath"/>?<xsl:value-of select="$dvt_nextpagedata"/><xsl:value-of select="$ShowWebPart"/>\u0026View=<xsl:value-of select="$View"/>");javascript:return false;</xsl:attribute>
                    <xsl:attribute name="href">javascript:</xsl:attribute>
                    <img src="/_layouts/{$LCID}/images/next.gif" border="0" alt="{$Rows/@tb_nextpage}" />
                  </a>
                </td>
              </xsl:if>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="ms-bottompagingline3">
          <img SRC="/_layouts/images/blank.gif" width="1" height="1" alt=""/>
        </td>
      </tr>
    </table>
    <script>
      var topPagingCell = document.getElementById("topPagingCell<xsl:value-of select='$WPQ'/>");
      var bottomPagingCell = document.getElementById("bottomPagingCell<xsl:value-of select='$WPQ'/>");
      if (topPagingCell != null &amp;&amp; bottomPagingCell != null)
      {
      topPagingCell.innerHTML = bottomPagingCell.innerHTML;
      }
    </script>
  </xsl:template>
  <xsl:template name="pagingButtons">
    <xsl:choose>
      <!--
        For Events list views which have RecurrenceRowset flag true, those need
        different logic for paging.
      -->
      <xsl:when test="$XmlDefinition/List/@TemplateType = 106 and $XmlDefinition/@RecurrenceRowset='TRUE'">
        <xsl:if test="$dvt_nextpagedata or $dvt_prevpagedata">
          <xsl:call-template name="CalendarExpandedRecurrenceFooter"/>
        </xsl:if>
      </xsl:when>
      <!-- For other paged views, use default logic -->
      <xsl:otherwise>
      <xsl:if test="$XmlDefinition/RowLimit[@Paged='TRUE']">
        <xsl:call-template name="CommandFooter">
          <xsl:with-param name="FirstRow" select="$FirstRow" />
          <xsl:with-param name="LastRow" select="$LastRow" />
          <xsl:with-param name="dvt_RowCount" select="$dvt_RowCount" />
        </xsl:call-template>
      </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="getTDClassValue" ddwrt:ghost="always">
    <xsl:param name="class"/>
    <xsl:param name="Type" />
    <xsl:param name="ClassInfo"/>
    <xsl:choose>
      <xsl:when test="$ClassInfo='Menu' or @ListItemMenu='TRUE'">ms-vb-title</xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$ClassInfo='Icon'">ms-vb-icon</xsl:when>
          <xsl:when test="$class!=''">
            <xsl:value-of select="$class"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="($Type='User' or $Type='UserMulti') and $PresenceEnabled='1'">ms-vb-user</xsl:when>
              <xsl:otherwise>ms-vb2</xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="EmptyTemplate">
    <tr>
      <td class="ms-vb" colspan="99">
		Your query produced no results.
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
