<%@ Assembly Name="PDLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=5b5fdee18bf6e293" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Search PD FormUserControl.ascx.cs" Inherits="PDLibrary.Search_PD_Form.Search_PD_FormUserControl" %>
<div id="main" class="mainDiv">
    <h2 class="volpe">Position Description Library</h2>
    <div id="searchPDForm" runat="server">
        <h2 class="volpe">Search for a Position Description</h2>
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
