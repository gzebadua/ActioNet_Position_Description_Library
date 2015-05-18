<%@ Assembly Name="PDLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=5b5fdee18bf6e293" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PD Feedback Form.ascx.cs" Inherits="PDLibrary.PD_Feedback_Form.PD_Feedback_FormUserControl" %>
<div id="main" class="mainDiv">
    <h2 class="volpe">Feedback Form</h2>
    <p>Please use this form to submit questions or comments about the PD Library. <i>Thank you for your feedback!</i></p>
    <p><i>* - Indicates a required field.</i></p>
    <br />
    <asp:Table ID="tblFeedback" runat="server" Width="100%" CellPadding="2">
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <label id="lblName" for="lblUsername" class="bolded">Name: </label><asp:Label ID="lblUsername" runat="server" Text="" Font-Italic="true" Font-Underline="true"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                &nbsp;
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>
                <label id="lblFeedback" for="txtFeedback" class="bolded">* Your questions or comments (1,000 chars. max): </label>
            </asp:TableCell>
                <asp:TableCell>
                    <asp:RequiredFieldValidator ID="rfvFeedback" runat="server" ErrorMessage="Please give us some feedback" ControlToValidate="txtFeedback" ValidationGroup="PDFeedback" ForeColor="Red"></asp:RequiredFieldValidator>
                </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" width="90%" Height="70px" Rows="5" CssClass="input"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                &nbsp;
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell ColumnSpan="2">
                <asp:Button ID="btnSend" runat="server" Text="Send" CssClass="button" TabIndex="2" OnClick="sendFeedback" ValidationGroup="PDFeedback" />
<%--                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button" TabIndex="3" OnClick="clearFields" CausesValidation="false" />--%>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</div>
