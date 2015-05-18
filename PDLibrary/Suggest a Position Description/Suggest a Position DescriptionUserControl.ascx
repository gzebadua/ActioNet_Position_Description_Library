<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Suggest a Position DescriptionUserControl.ascx.cs" Inherits="PDLibrary.Suggest_a_Position_Description.Suggest_a_Position_DescriptionUserControl" %>
<div id="main" class="mainDiv">
    <h2 class="volpe">Suggest a Position Description!</h2>
    <p>If you have a PD you wish to submit for potential inclusion in the Library, simply send it to us. We will review it, and make any necessary edits to ensure it is properly classified before we upload it. We will confirm via email once the PD has been uploaded.</p>
    <p>We appreciate your help in keeping this Library a viable tool!</p>
    <p><i>* - Indicates a required field.</i></p>
    <br />
    <asp:Table ID="tblFeedback" runat="server" Width="100%" CellPadding="2">
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblName" for="lblUsername" class="volpeLabel">Name: </label>
            </asp:TableCell>
            <asp:TableCell>
                <asp:Label ID="lblUsername" runat="server" Text="" Font-Italic="true" Font-Underline="true"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblJobTitle" for="txtJobTitle" class="volpeLabel">* PD Job Title: </label>
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtJobTitle" runat="server" Width="400px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvJobTitle" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtJobTitle" ValidationGroup="SuggestAPD"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblGrade" for="txtGrade" class="volpeLabel">* Pay Grade: </label>
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtGrade" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvGrade" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtGrade" ValidationGroup="SuggestAPD"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblOcupationalSeries" for="txtSeries" class="volpeLabel">* Occupational Series: </label>
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtSeries" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSeries" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtSeries" ValidationGroup="SuggestAPD"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblComments" for="txtComments" class="volpeLabel">* Comments (1,000 chars. max): </label>
                <asp:RequiredFieldValidator ID="rfvComments" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtComments" ValidationGroup="SuggestAPD"></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell>
                    
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" width="90%" Height="70px" Rows="5" CssClass="input"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblPDFileUpload" for="fuPDFile" class="volpeLabel">* Attach your suggested PD file: </label>
                <asp:RequiredFieldValidator ID="rfvPDFile" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="fuPDFile" ValidationGroup="SuggestAPD"></asp:RequiredFieldValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <asp:FileUpload ID="fuPDFile" runat="server" Width="100%" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                &nbsp;
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <asp:Button ID="btnSend" runat="server" Text="Send" CssClass="button" TabIndex="2" OnClick="sendPD" ValidationGroup="SuggestAPD" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" TabIndex="3" CausesValidation="false" OnClick="clearFields" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</div>