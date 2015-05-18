<%@ Assembly Name="PDLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=5b5fdee18bf6e293" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Search PDUserControl.ascx.cs" Inherits="PDLibrary.Search_PD.Search_PDUserControl" %>
<style type="text/css">
    .mainDiv 
    {
        width:100%;
    }
    
    .actionsDiv
    {
        float:right;
        top:50px;
        left:57%;
        width:370px;
        text-align:center;
        border:1px solid black;
        padding: 15px 0px 15px 0px;
    }
    
    .documentsLinkDiv 
    {
        width:100%;
        text-align:left;
    }
    
    .lnkFiles
    {
        font-size:18px;
    }
    
    .saveMessage
    {
        font-size:12pt; 
        font-weight:bold;
        color:Red;
    }
    
    .bolded
    {
        font-weight:bold;
    }
    
    .noteWarning
    {
        color:Orange;
        font-style:italic;
    }
    
    .errorMessage 
    {
        color:Red;
        font-style:italic;
    }
    
    .button
    {
          color: #fff; 
          text-decoration: none;
          font-weight:bold;
          font-size: 13px;
          text-align: center;
          vertical-align: middle;
          padding: 3px;
          padding-left: 5px;
          padding-right: 5px;
         /*width: 85px !important;*/
          background-color: #94B367;
          display: inline-block;
    }
    
    .input
    {
        vertical-align:top;
        width:90%;
        height:70px;
    }
    
    td.ms-addnew
    {
        display:none;
    }
    
    td.ms-partline 
    {
        display:none;
    }
</style>
<script type="text/javascript" src="/SiteAssets/jquery-2.1.3.min.js"></script>
<script type="text/javascript">
    //if(QueryString has #listAll) then hide Paged (WebPartWPQ1) on ready
    $(document).ready(function () {
        if (window.location.href.indexOf("#listAll") > -1) {
            $("#WebPartWPQ1").hide();
            $("#WebPartWPQ2").show();
        } else {
            $("#WebPartWPQ1").show();
            $("#WebPartWPQ2").hide();
        }
    });
</script>
<div id="main" class="mainDiv">
    <h2>Position Description Library</h2>
    <div id="searchPDForm" runat="server">
        <h2>Search for a Position Description</h2>
        <h3>Search for a Position Description (enter one or more values and click 'Search')</h3>
        <br />
        <label id="lblJobTitle" for="txtJobTitle" class="bolded">Free Form Title Search: </label><br />
        <asp:TextBox ID="txtJobTitle" runat="server" Width="400px" ValidationGroup="searchPD"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <label id="lblOr" for="ddJobTitle"><em>or</em></label>
        <br />
        <br />
        <label id="lblJobTitleDropdown" for="ddJobTitle" class="bolded">Choose a Title from the list: </label><br />
        <asp:DropDownList ID="ddJobTitle" runat="server" Width="400px" ValidationGroup="searchPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <table width="400px">
            <tr>
                <td>
                    <label id="lblGrade" for="ddGrade" class="bolded">Pay Grade: </label><br />
                    <asp:DropDownList ID="ddGrade" runat="server" Width="200px" ValidationGroup="searchPD">
                        <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    <label id="lblPDNumber" for="txtPDNumber" class="bolded">PD #: </label><br />
                    <asp:TextBox ID="txtPDNumber" runat="server" Width="100px" ValidationGroup="searchPD"></asp:TextBox>
                </td>
            </tr>
        </table>
        <br />
        <label id="lblOrganization" for="ddOrganization" class="bolded">Organization: </label><br />
        <asp:DropDownList ID="ddOrganization" runat="server" Width="200px" ValidationGroup="searchPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <br />    
        <br />
        <label id="lblOcupationalSeries" for="ddSeries" class="bolded">Occupational Series: </label><br />
        <asp:DropDownList ID="ddSeries" runat="server" Width="200px" ValidationGroup="searchPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <table width="400px">
            <tr>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button save" TabIndex="2" OnClick="searchPD" ValidationGroup="searchPD" />
                </td>
                <td>
                    &nbsp;
                </td>
<%--                <td>
                    <asp:Button ID="btnReset" runat="server" Text="Clear Fields" CssClass="button reset" TabIndex="3" CausesValidation="false" OnClick="clearFields" />
                </td>--%>
                <td>
                    &nbsp;
                </td>
                <td align="right" valign="bottom" class="noteWarning">
                    <asp:HyperLink ID="hlkShowAllPDs" runat="server" CssClass="noteWarning">[List All P.D.'s]</asp:HyperLink>
                </td>
            </tr>
        </table>
        <div id="errorDiv" runat="server">
            <br />
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="errorMessage" Text=""></asp:Label>
        </div>
        <hr />
    </div>
</div>
