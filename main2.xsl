<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema" xmlns:d="http://schemas.microsoft.com/sharepoint/dsp" version="1.0" exclude-result-prefixes="xsl msxsl ddwrt" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:asp="http://schemas.microsoft.com/ASPNET/20" xmlns:__designer="http://schemas.microsoft.com/WebParts/v2/DataView/designer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:SharePoint="Microsoft.SharePoint.WebControls" xmlns:ddwrt2="urn:frontpage:internal">
  <xsl:import href="../SiteAssets/fldtypes2.xsl"/>
  <xsl:import href="../SiteAssets/vwstyles2.xsl"/>
  <xsl:output method="html" indent="no"/>
  <xsl:decimal-format NaN=""/>
  <xsl:param name="NavigateForFormsPages" />
  <xsl:param name="MasterVersion" select="3"/>
  <xsl:param name="TabularView"/>
  <xsl:param name="NoAJAX"/>
  <xsl:param name="WPQ"/>
  <xsl:param name="RowLimit" select="5"/>
  <xsl:param name="dvt_sortdir" select="'ascending'"/>
  <xsl:param name="dvt_sortfield" />
  <xsl:param name="WebPartClientID"/>
  <xsl:param name="dvt_filterfields" />
  <xsl:param name="dvt_partguid" />
  <xsl:param name="dvt_firstrow" select="1"/>
  <xsl:param name="dvt_nextpagedata" />
  <xsl:param name="dvt_prevpagedata" />
  <xsl:param name="XmlDefinition" select="."/>
  <xsl:param name="ViewCounter" select="'1'"/>
  <xsl:param name="View" />
  <xsl:param name="ListUrlDir"/>
  <xsl:param name="List" />
  <xsl:param name="Project"/>
  <xsl:param name="WebTitle"/>
  <xsl:param name="ListTitle"/>
  <xsl:param name="FORM_DISPLAY"/>
  <xsl:param name="FORM_DISPLAY_HTMLURLATTRIBUTEENCODED"/>
  <xsl:param name="FORM_EDIT"/>
  <xsl:param name="FORM_NEW"/>
  <xsl:param name="ENCODED_FORM_NEW"/>
  <xsl:param name="Userid" select="-1"/>
  <xsl:param name="PagePath"/>
  <xsl:param name="PagePathFinal" select="concat($PagePath,'?')"/>
  <xsl:param name="HttpVDir"/>
  <xsl:param name="HttpVDirUniEncoded"/>
  <xsl:param name="HttpPath"/>
  <xsl:param name="HttpHost"/>
  <xsl:param name="PresenceEnabled"/>
  <xsl:param name="FilterLink"/>
  <xsl:param name="FilterLinkNoHost"/>
  <xsl:param name="RecursiveView"/>
  <xsl:param name="WebEditorPreview"/>
  <xsl:param name="NoAnnouncements"/>
  <xsl:param name="NoAnnouncementsHowTo"/>
  <xsl:param name="MoreAnnouncements"/>
  <xsl:param name="AddNewAnnouncement"/>
  <xsl:param name="FreeForm" select="0"/>
  <xsl:param name="OpenMenuKeyAccessible"/>
  <xsl:param name="open_menu"/>
  <xsl:param name="select_deselect_all"/>
  <xsl:param name="IsGhosted" select="'0'"/>
  <xsl:param name="Filter" select="'0'"/>
  <xsl:param name="IsDocLib"/>
  <xsl:param name="WorkspaceAltString"/>
  <xsl:param name="NewGifAltString"/>
  <xsl:param name="LCID"/>
  <xsl:param name="ByText"/>
  <xsl:param name="Modified"/>
  <xsl:param name="Modified_By"/>
  <xsl:param name="SelectedID"/>
  <xsl:param name="idPresEnabled"/>
  <xsl:param name="dvt_RowCount" select="0" />
  <xsl:param name="HasTitleField" select="$XmlDefinition/ViewFields/FieldRef[@Name='Title']"/>
  <xsl:param name="IsHomePageView" select="0" />
  <xsl:param name="ManualRefresh" />
  <xsl:param name="ListRight_AddListItems"/>
  <xsl:param name="GroupingRender"/>
  <xsl:param name="dvt_form_key"/> <!-- -1 means insert-->
  <xsl:param name="InlineEdit"/>
  <xsl:param name="ServerRelativeUrl"/>
  <xsl:param name="OverrideSelectCommand"/>
  <xsl:param name="OverrideFilterQstring"/>
  <xsl:param name="OverrideScope"/>
  <xsl:param name="EcbMode"/>
  <xsl:param name="FieldSortParam"/>
  <xsl:param name="RootFolderParam"/>
  <xsl:param name="AddServerFilterOperationHash"/>
  <xsl:param name="IsPostBack"/>
  <xsl:param name="ShowWebPart"/>
  <xsl:param name="SortQueryString"/>
  <xsl:param name="NoCTX"/>
  <xsl:param name="ShowAlways"/>
  <xsl:param name="EnableAlert"/>
  <xsl:param name="RootSiteUrl"/>
  <xsl:param name="RenderCTXOnly"/>
  <!-- For Relationships-->
  <xsl:param name="HasRelatedCascadeLists" select="0" />
  <xsl:param name="CascadeDeleteWarningMessage"/>
  <!-- For External Lists-->
  <xsl:param name="EntityName" />
  <xsl:param name="EntityNamespace" />
  <xsl:param name="SpecificFinderName" />
  <xsl:param name="LobSystemInstanceName" />
  <xsl:param name="ExternalDataListPermissions" />
  <xsl:param name="RowTotalCount" select="0"/>
</xsl:stylesheet>
