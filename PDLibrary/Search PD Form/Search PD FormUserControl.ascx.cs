using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;

namespace PDLibrary.Search_PD_Form
{
    public partial class Search_PD_FormUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            hlkShowAllPDs.NavigateUrl = SPContext.Current.Web.Url + "/" + SPContext.Current.File.Url;

            if (!IsPostBack)
            {

                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {

                    using (SPWeb web = site.OpenWeb())
                    {
                        
                        //Load dynamic dropdowns
                        try
                        {
                            SPList listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionTitles");
                            ddJobTitle.DataSource = listForDropdown.Items;
                            ddJobTitle.DataValueField = "Title";
                            ddJobTitle.DataTextField = "Title";
                            ddJobTitle.DataBind();
                            ddJobTitle.Items.Insert(0, new ListItem("Select one", String.Empty));

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PayPlansGrades");
                            ddGrade.DataSource = listForDropdown.Items;
                            ddGrade.DataValueField = "Title";
                            ddGrade.DataTextField = "Title";
                            ddGrade.DataBind();
                            ddGrade.Items.Insert(0, new ListItem("Select one", String.Empty));

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/Organizations");
                            ddOrganization.DataSource = listForDropdown.Items;
                            ddOrganization.DataValueField = "Title";
                            ddOrganization.DataTextField = "Title";
                            ddOrganization.DataBind();
                            ddOrganization.Items.Insert(0, new ListItem("Select one", String.Empty));

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/OccupationalSeries");
                            ddSeries.DataSource = listForDropdown.Items;
                            ddSeries.DataValueField = "Title";
                            ddSeries.DataTextField = "Title";
                            ddSeries.DataBind();
                            ddSeries.Items.Insert(0, new ListItem("Select one", String.Empty));
                        }
                        catch (Exception ex)
                        {
                            SPDiagnosticsService diagSvc = SPDiagnosticsService.Local;
                            diagSvc.WriteTrace(0, new SPDiagnosticsCategory("PDLibrary", TraceSeverity.Monitorable, EventSeverity.Error),
                            TraceSeverity.Monitorable, "PD Library error:  {0}", new object[] { ex.ToString() });
                        }
                        
                    }
                }

                //Selected what they searched already

                if (Request.QueryString["FilterMultiValue"] != "" && Request.QueryString["FilterMultiValue"] != null)
                {
                    txtJobTitle.Text = Request.QueryString["FilterMultiValue"].Substring(1).Substring(0, Request.QueryString["FilterMultiValue"].Substring(1).Length - 1);
                }

                if (Request.QueryString["FilterField1"] != "" && Request.QueryString["FilterField1"] != null && Request.QueryString["FilterValue1"] != "" && Request.QueryString["FilterValue1"] != null)
                {

                    switch (Request.QueryString["FilterField1"])
                    {
                        case "Title":
                            ddJobTitle.SelectedValue = Request.QueryString["FilterValue1"];
                            break;
                        case "Organization":
                            ddOrganization.SelectedValue = Request.QueryString["FilterValue1"];
                            break;
                        case "OccupationalSeries":
                            ddSeries.SelectedValue = Request.QueryString["FilterValue1"];
                            break;
                        case "PayGrade":
                            ddGrade.SelectedValue = Request.QueryString["FilterValue1"];
                            break;
                        case "PDNumber":
                            txtPDNumber.Text = Request.QueryString["FilterValue1"];
                            break;
                    }
                }

                if (Request.QueryString["FilterField2"] != "" && Request.QueryString["FilterField2"] != null && Request.QueryString["FilterValue2"] != "" && Request.QueryString["FilterValue2"] != null)
                {

                    switch (Request.QueryString["FilterField2"])
                    {
                        case "Title":
                            ddJobTitle.SelectedValue = Request.QueryString["FilterValue2"];
                            break;
                        case "Organization":
                            ddOrganization.SelectedValue = Request.QueryString["FilterValue2"];
                            break;
                        case "OccupationalSeries":
                            ddSeries.SelectedValue = Request.QueryString["FilterValue2"];
                            break;
                        case "PayGrade":
                            ddGrade.SelectedValue = Request.QueryString["FilterValue2"];
                            break;
                        case "PDNumber":
                            txtPDNumber.Text = Request.QueryString["FilterValue2"];
                            break;
                    }
                }

                if (Request.QueryString["FilterField3"] != "" && Request.QueryString["FilterField3"] != null && Request.QueryString["FilterValue3"] != "" && Request.QueryString["FilterValue3"] != null)
                {

                    switch (Request.QueryString["FilterField3"])
                    {
                        case "Title":
                            ddJobTitle.SelectedValue = Request.QueryString["FilterValue3"];
                            break;
                        case "Organization":
                            ddOrganization.SelectedValue = Request.QueryString["FilterValue3"];
                            break;
                        case "OccupationalSeries":
                            ddSeries.SelectedValue = Request.QueryString["FilterValue3"];
                            break;
                        case "PayGrade":
                            ddGrade.SelectedValue = Request.QueryString["FilterValue3"];
                            break;
                        case "PDNumber":
                            txtPDNumber.Text = Request.QueryString["FilterValue3"];
                            break;
                    }
                }

                if (Request.QueryString["FilterField4"] != "" && Request.QueryString["FilterField4"] != null && Request.QueryString["FilterValue4"] != "" && Request.QueryString["FilterValue4"] != null)
                {

                    switch (Request.QueryString["FilterField4"])
                    {
                        case "Title":
                            ddJobTitle.SelectedValue = Request.QueryString["FilterValue4"];
                            break;
                        case "Organization":
                            ddOrganization.SelectedValue = Request.QueryString["FilterValue4"];
                            break;
                        case "OccupationalSeries":
                            ddSeries.SelectedValue = Request.QueryString["FilterValue4"];
                            break;
                        case "PayGrade":
                            ddGrade.SelectedValue = Request.QueryString["FilterValue4"];
                            break;
                        case "PDNumber":
                            txtPDNumber.Text = Request.QueryString["FilterValue4"];
                            break;
                    }
                }

                if (Request.QueryString["FilterField5"] != "" && Request.QueryString["FilterField5"] != null && Request.QueryString["FilterValue5"] != "" && Request.QueryString["FilterValue5"] != null)
                {

                    switch (Request.QueryString["FilterField5"])
                    {
                        case "Title":
                            ddJobTitle.SelectedValue = Request.QueryString["FilterValue5"];
                            break;
                        case "Organization":
                            ddOrganization.SelectedValue = Request.QueryString["FilterValue5"];
                            break;
                        case "OccupationalSeries":
                            ddSeries.SelectedValue = Request.QueryString["FilterValue5"];
                            break;
                        case "PayGrade":
                            ddGrade.SelectedValue = Request.QueryString["FilterValue5"];
                            break;
                        case "PDNumber":
                            txtPDNumber.Text = Request.QueryString["FilterValue5"];
                            break;
                    }
                }
            }
            
        }

        protected void searchPD(object send, EventArgs e)
        {
            errorDiv.Visible = false;

            String searchArguments = "";

            //Validate search field contents
            if (txtJobTitle.Text.Trim().Replace("'","").Length > 0)
            {
                //do search on job title only
                searchArguments = "FilterName=Title&FilterMultiValue=*" + txtJobTitle.Text + "*";
            }
            else
            {
                //do search on all _other_ fields

                int countingFilters = 0;
                
                if (ddJobTitle.SelectedValue != "")
                {
                    countingFilters ++;
                }

                if (ddGrade.SelectedValue != "")
                {
                    countingFilters++;
                }

                if (txtPDNumber.Text.Trim().Replace("'", "").Length > 0)
                {
                    countingFilters++;
                }

                if (ddOrganization.SelectedValue != "")
                {
                    countingFilters++;
                }

                if (ddSeries.SelectedValue != "")
                {
                    countingFilters++;
                }

                int filterNumber = 0;

                //View={2A2B0097-A9BE-47C9-A471-286ED492DAEA}&
                //FilterField1=Title&FilterValue1=Aerospace%20Engineer&FilterField2=Organization&FilterValue2=RVT-1&FilterField3=OccupationalSeries&FilterValue3=0868&FilterField4=PayGrade&FilterValue4=GS-13&FilterField5=PDNumber&FilterValue5=Templ861-13
                
                if (ddJobTitle.SelectedValue != "") {
                    searchArguments += "FilterField" + (filterNumber + 1) + "=Title&FilterValue" + (filterNumber + 1) + "=" + ddJobTitle.SelectedValue;
                    filterNumber++;
                    if (filterNumber < countingFilters)
                    {
                        searchArguments += "&";
                    }
                }

                if (ddOrganization.SelectedValue != "")
                {
                    searchArguments += "FilterField" + (filterNumber + 1) + "=Organization&FilterValue" + (filterNumber + 1) + "=" + ddOrganization.SelectedValue;
                    filterNumber++;
                    if (filterNumber < countingFilters)
                    {
                        searchArguments += "&";
                    }
                }

                if (ddSeries.SelectedValue != "")
                {
                    searchArguments += "FilterField" + (filterNumber + 1) + "=OccupationalSeries&FilterValue" + (filterNumber + 1) + "=" + ddSeries.SelectedValue;
                    filterNumber++;
                    if (filterNumber < countingFilters)
                    {
                        searchArguments += "&";
                    }
                }

                if (ddGrade.SelectedValue != "") {
                    searchArguments += "FilterField" + (filterNumber + 1) + "=PayGrade&FilterValue" + (filterNumber + 1) + "=" + ddGrade.SelectedValue;
                    filterNumber++;
                    if (filterNumber < countingFilters)
                    {
                        searchArguments += "&";
                    }
                }

                if (txtPDNumber.Text.Trim().Replace("'", "").Length > 0)
                {
                    searchArguments += "FilterField" + (filterNumber + 1) + "=PDNumber&FilterValue" + (filterNumber + 1) + "=" + txtPDNumber.Text;
                    filterNumber++;
                    if (filterNumber < countingFilters)
                    {
                        searchArguments += "&";
                    }
                }

            }

            if (searchArguments.Length > 0)
            {
                Response.Redirect(SPContext.Current.Web.Url + "/" + SPContext.Current.File.Url + "?" + searchArguments);
                
            }
            else
            {
                Response.Redirect(SPContext.Current.Web.Url + "/" + SPContext.Current.File.Url);
            }

        }

        protected void clearFields(object send, EventArgs e)
        {
            txtJobTitle.Text = "";
            ddJobTitle.SelectedValue = "";
            ddGrade.SelectedValue = "";
            txtPDNumber.Text = "";
            ddSeries.SelectedValue = "";
            ddOrganization.SelectedValue = "";
        }
    }
}
