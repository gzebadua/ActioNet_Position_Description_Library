using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.WebControls;

namespace PDLibrary.PD_Feedback_Form
{
    public partial class PD_Feedback_FormUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SPContext.Current.Web.CurrentUser.Name.IndexOf(",") == -1){
                lblUsername.Text = SPContext.Current.Web.CurrentUser.Name; 
            } else {
                string userName = SPContext.Current.Web.CurrentUser.Name.Substring(SPContext.Current.Web.CurrentUser.Name.IndexOf(",") + 2) + " " + SPContext.Current.Web.CurrentUser.Name.Substring(0, SPContext.Current.Web.CurrentUser.Name.IndexOf(","));
                userName = userName.Replace(" CTR (VOLPE)", "");
                lblUsername.Text = userName;
            }
            

            // determine if page is in Edit mode or New Mode
            if (SPContext.Current.FormContext.FormMode == SPControlMode.Edit || SPContext.Current.FormContext.FormMode == SPControlMode.New)
            {
                rfvFeedback.Visible = false;
                //ValidationSummary1.EnableClientScript = false;
            }

            if (!IsPostBack)
            {

            }
        }

        protected void sendFeedback(object send, EventArgs e)
        {
            //Send email code through SP Workflow (needs to be defined separately in the library via SP Designer)
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {

                    try
                    {

                        SPListItemCollection listItems = web.GetList(SPContext.Current.Web.Url + "/Lists/PDFeedback").Items;

                        SPListItem feedbackItem = listItems.Add();

                        SPFieldUserValue helpfulUser = new SPFieldUserValue(web, SPContext.Current.Web.CurrentUser.ID, SPContext.Current.Web.CurrentUser.Name);
                        feedbackItem["User"] = helpfulUser;
                        feedbackItem["Feedback"] = txtFeedback.Text;

                        feedbackItem.Update();

                        Response.Redirect("Home.aspx");
                    }
                    catch (Exception ex)
                    {
                        SPDiagnosticsService diagSvc = SPDiagnosticsService.Local;
                        diagSvc.WriteTrace(0, new SPDiagnosticsCategory("PDLibrary", TraceSeverity.Monitorable, EventSeverity.Error),
                        TraceSeverity.Monitorable, "PD Library error:  {0}", new object[] { ex.ToString() });
                    }
                }
            }
        }

        protected void clearFields(object send, EventArgs e)
        {
            txtFeedback.Text = "";
        }
        
    }
}
