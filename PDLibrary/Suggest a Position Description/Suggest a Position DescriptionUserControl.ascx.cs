using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.WebControls;

namespace PDLibrary.Suggest_a_Position_Description
{
    public partial class Suggest_a_Position_DescriptionUserControl : UserControl
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            
            lblUsername.Text = SPContext.Current.Web.CurrentUser.Name;

            // determine if page is in Edit mode or New Mode
            if (SPContext.Current.FormContext.FormMode == SPControlMode.Edit || SPContext.Current.FormContext.FormMode == SPControlMode.New)
            {
                rfvJobTitle.Visible = false;
                rfvGrade.Visible = false;
                rfvSeries.Visible = false;
                rfvComments.Visible = false;
                rfvPDFile.Visible = false;
                //ValidationSummary1.EnableClientScript = false;
            }

            if (!IsPostBack)
            {

            }

        }

        protected void sendPD(object send, EventArgs e)
        {
            //Send email 

            //DONT FORGET THE FILE ATTACHMENT
            Response.Redirect("Home.aspx");
        }

        protected void clearFields(object send, EventArgs e)
        {
            txtJobTitle.Text = "";
            txtSeries.Text = "";
            txtGrade.Text = "";
            txtComments.Text = "";
            fuPDFile.Dispose();
        }
    }
}
