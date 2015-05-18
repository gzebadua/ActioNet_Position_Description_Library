<%@ Assembly Name="PDLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=5b5fdee18bf6e293" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="New PD FormUserControl.ascx.cs" Inherits="PDLibrary.New_PD_Form.New_PD_FormUserControl" %>
<div id="main" class="mainDiv">
    <h2 class="volpe">Position Description Library Administration</h2>
    <div id="newPDForm" runat="server">
        <h3>New Position Description</h3>
        <br />
        <label id="lblPDNumber" for="txtPDNumber" class="bolded">Position Description Number: </label><br />
        <asp:TextBox ID="txtPDNumber" runat="server" Width="200px" ValidationGroup="NewPD"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPDNumber" runat="server" ErrorMessage="Please type a PD Number" ForeColor="Red" ControlToValidate="txtPDNumber" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <label id="lblJobTitle" for="txtJobTitle" class="bolded">Title: </label>
        <a href="Edit-Title-List.aspx"><asp:Label ID="lblPDTitlesLink" runat="server" Text="(Edit the Title List)" TabIndex="-1"></asp:Label></a><br />
        <asp:DropDownList ID="ddJobTitle" runat="server" Width="400px" ValidationGroup="NewPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvJobTitle" runat="server" ErrorMessage="Please select a Position Title" ForeColor="Red" ControlToValidate="ddJobTitle" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <label id="lblGrade" for="ddGrade" class="bolded">Pay Grade: </label><br />
        <asp:DropDownList ID="ddGrade" runat="server" Width="200px" ValidationGroup="NewPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvGrade" runat="server" ErrorMessage="Please select a Pay Plan and Grade" ForeColor="Red" ControlToValidate="ddGrade" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
        <br />    
        <br />
        <label id="lblOcupationalSeries" for="ddSeries" class="bolded">Occupational Series: </label><br />
        <asp:DropDownList ID="ddSeries" runat="server" Width="200px" ValidationGroup="NewPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvSeries" runat="server" ErrorMessage="Please select an Occupational Series" ForeColor="Red" ControlToValidate="ddSeries" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <label id="lblPositionType" for="ddPositionType" class="bolded">Position type: </label><br />
        <asp:DropDownList ID="ddPositionType" runat="server" Width="200px" ValidationGroup="NewPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <%--<asp:RequiredFieldValidator ID="rfvPositionType" runat="server" ErrorMessage="Please select a Position Type" ForeColor="Red" ControlToValidate="ddPositionType" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>--%>
        <br />
        <br />
        <label id="lblOrganization" for="ddOrganization" class="bolded">Organization: </label><br />
        <asp:DropDownList ID="ddOrganization" runat="server" Width="200px" ValidationGroup="NewPD">
            <asp:ListItem Text="Select one" Value="" Selected="True"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvOrg" runat="server" ErrorMessage="Please select an Organization" ForeColor="Red" ControlToValidate="ddOrganization" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
<%--        <br />
        <br />
        <label id="lblSupervisoryPosition" for="rdblSupervisoryPosition" class="bolded">Is this a supervisory position? </label>
        <asp:RadioButtonList ID="rdblSupervisoryPosition" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" ValidationGroup="NewPD">
            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
            <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
        </asp:RadioButtonList>--%>
        <br />
        <br />
        <label id="lblComments" for="txtNotes" class="bolded">Notes: </label>
        <label id="lblNoteWarning" for="txtNotes" class="noteWarning">(Be sure to add a comment for each Live update!)</label>
        <asp:RequiredFieldValidator ID="rfvNotes" runat="server" ErrorMessage="A note is required" ForeColor="Red" ControlToValidate="txtNotes" ValidationGroup="NewPD">*</asp:RequiredFieldValidator>
        <br />
        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" CssClass="input" ValidationGroup="NewPD"></asp:TextBox>
        <br />
        <br />
        <br />
        <label id="lblWordFile" for="fuWordFile" class="bolded">Position Description (WORD) Upload: </label>
        &nbsp;
        <asp:RegularExpressionValidator ID="revWordFile" runat="server" ControlToValidate="fuWordFile" ValidationGroup="NewPD" ErrorMessage="Please select a Word file" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((d|D)(o|O)(c|C)(x|X))|((d|D)(o|O)(c|C)))$"></asp:RegularExpressionValidator>
        <br />
        <br />
        <asp:FileUpload ID="fuWordFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblPDFFile" for="fuPDFFile" class="bolded">Position Description (PDF) Upload: </label>
        &nbsp;
        <asp:RegularExpressionValidator ID="revPDFFile" runat="server" ControlToValidate="fuPDFFile" ValidationGroup="NewPD" ErrorMessage="Please select a .pdf file" ValidationExpression="^([a-zA-Z].*|[1-9].*)\.(((p|P)(d|D)(f|F)))$"></asp:RegularExpressionValidator>
        <br />
        <br />
        <asp:FileUpload ID="fuPDFFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblCoversheetFile" for="fuOF8File" class="bolded">Coversheet (OF-8) Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuOF8File" runat="server" Width="300px" /><br />
        <br />
        <label id="lblJAFFile" for="fuJAFFile" class="bolded">Job Analysis Form Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuJAFFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblWSRVQFile" for="fuWSRVQFile" class="bolded">Weight and Screenout Report / Vacancy Questions Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuWSRVQFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblKSAFile" for="fuKSAFile" class="bolded">KSA Form Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuKSAFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblSEFFile" for="fuSEFFile" class="bolded">Specialized Experience File Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuSEFFile" runat="server" Width="300px" /><br />
        <br />
        <label id="lblOtherFile" for="fuOtherFile" class="bolded">Other Documents Upload: </label><br />
        <br />
        <asp:FileUpload ID="fuOtherFile" runat="server" Width="300px" /><br />

    </div>
</div>
<div id="actionsDiv" runat="server" class="actionsDiv">
    <label id="lblActions" for="ddActions" class="bolded">Actions:</label><br />
    <br />    
    <asp:DropDownList ID="ddActions" runat="server" Width="220px" ValidationGroup="NewPD">
        <asp:ListItem Text="Save as Live" Value="Live" Selected="True"></asp:ListItem>
        <asp:ListItem Text="Place in Hold" Value="Hold"></asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <br />
    <asp:Button ID="btnReset" runat="server" Text="Clear Fields" CssClass="button reset" TabIndex="3" CausesValidation="false" OnClick="clearFields" />
    &nbsp;
    <asp:Button ID="btnSave" runat="server" Text="Save &amp; add Documents" CssClass="button save" TabIndex="2" OnClick="savePD" ValidationGroup="NewPD" />
    <br />
    <asp:ValidationSummary ID="validationSummary" runat="server" ValidationGroup="NewPD" ForeColor="Red" Font-Italic="true" ShowSummary="true" />
    <div id="errorDiv" runat="server">
        <br />
        <asp:Label ID="lblErrorMessage" runat="server" CssClass="errorMessage" Text=""></asp:Label>
    </div>
</div>
<%--<div id="documentsLinkDiv" runat="server" class="documentsLinkDiv" visible="false">
    <br />
    <label id="saveMessage" for="lnkFiles" class="saveMessage">Position Description saved!</label>
    <br />
    <br />
    <br />
    <asp:LinkButton ID="lnkFiles" runat="server" CssClass="lnkFiles" OnClientClick="window.open('file:\\\\zebaduag03644\\DavWWWRoot\\Shared%20Documents\\New%20folder')">Click here to add files for this Position Description</asp:LinkButton>
    <br />
    <br />
    <br />
    <asp:Button ID="btnGoHome" runat="server" Text="Go Home" CssClass="button" TabIndex="3" CausesValidation="false" OnClick="goHome" />
</div>--%>
