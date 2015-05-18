using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.WebControls;

namespace PDLibrary.New_PD_Form
{
    public partial class New_PD_FormUserControl : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            // determine if page is in Edit mode or New Mode
            if (SPContext.Current.FormContext.FormMode == SPControlMode.Edit || SPContext.Current.FormContext.FormMode == SPControlMode.New)
            {
                rfvPDNumber.Visible = false;
                rfvJobTitle.Visible = false;
                rfvGrade.Visible = false;
                rfvSeries.Visible = false;
                //rfvPositionType.Visible = false;
                rfvOrg.Visible = false;
                rfvNotes.Visible = false;
                validationSummary.EnableClientScript = false;
            }

            if (!IsPostBack)
            {

                using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                {

                    using (SPWeb web = site.OpenWeb())
                    {

                        try
                        {

                            //Load dynamic dropdowns
                            SPList listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionTitles");
                            ddJobTitle.DataSource = listForDropdown.Items;
                            ddJobTitle.DataValueField = "Title";
                            ddJobTitle.DataTextField = "Title";
                            ddJobTitle.DataBind();
                            ddJobTitle.Items.Insert(0, new ListItem("Select one", String.Empty));
                            ddJobTitle.SelectedIndex = 0;

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PayPlansGrades");
                            ddGrade.DataSource = listForDropdown.Items;
                            ddGrade.DataValueField = "Title";
                            ddGrade.DataTextField = "Title";
                            ddGrade.DataBind();
                            ddGrade.Items.Insert(0, new ListItem("Select one", String.Empty));
                            ddGrade.SelectedIndex = 0;

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/OccupationalSeries");
                            ddSeries.DataSource = listForDropdown.Items;
                            ddSeries.DataValueField = "Title";
                            ddSeries.DataTextField = "Title";
                            ddSeries.DataBind();
                            ddSeries.Items.Insert(0, new ListItem("Select one", String.Empty));
                            ddSeries.SelectedIndex = 0;

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionTypes");
                            ddPositionType.DataSource = listForDropdown.Items;
                            ddPositionType.DataValueField = "Title";
                            ddPositionType.DataTextField = "Title";
                            ddPositionType.DataBind();
                            ddPositionType.Items.Insert(0, new ListItem("Select one", String.Empty));
                            ddPositionType.SelectedIndex = 0;

                            listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/Organizations");
                            ddOrganization.DataSource = listForDropdown.Items;
                            ddOrganization.DataValueField = "Title";
                            ddOrganization.DataTextField = "Title";
                            ddOrganization.DataBind();
                            ddOrganization.Items.Insert(0, new ListItem("Select one", String.Empty));
                            ddOrganization.SelectedIndex = 0;

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
        }

        protected void savePD(object send, EventArgs e)
        {
            errorDiv.Visible = false;

            ////Validate PD data
            //if (!txtPDNumber.Text.Contains("-")) 
            //{
            //}

            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {

                    try
                    {
                        //Validate that the PD Number used here is not used already by a folder
                        if (web.GetFolder(SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/").Exists)
                        {
                            errorDiv.Visible = true;
                            lblErrorMessage.Text = "PD Number already in use in document library. Please correct the mistake and try again.";
                            return;
                        }

                        //Save data to list library

                        SPListItemCollection listItems = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionDescriptions").Items;

                        SPListItem PDItem = listItems.Add();

                        PDItem["PDNumber"] = txtPDNumber.Text;
                        PDItem["Title"] = ddJobTitle.SelectedValue;
                        PDItem["Organization"] = ddOrganization.SelectedValue;
                        PDItem["OccupationalSeries"] = ddSeries.SelectedValue;
                        PDItem["PayGrade"] = ddGrade.SelectedValue;
                        PDItem["PositionType"] = ddPositionType.SelectedValue;
                        //PDItem["SupervisoryPosition"] = rdblSupervisoryPosition.SelectedValue;
                        PDItem["Notes"] = txtNotes.Text;
                        PDItem["Visibility"] = ddActions.SelectedValue;

                        PDItem.Update();

                        //then create the folder for the PD files
                        EnsureParentFolder(web, SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/dummyFile.txt"); //dummyFile is used to get the underlying method to work (it looks for the parent folder)
                        string SubFolderUrl = SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/";

                        //now upload the files from the uploaders
                        Stream fStream;
                        byte[] contents;
                        SPFile currentFile;

                        if (fuWordFile.HasFile)
                        {
                            fStream = fuWordFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuWordFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "WORD";
                            currentFile.Item.Update();
                        }

                        if (fuPDFFile.HasFile)
                        {
                            fStream = fuPDFFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuPDFFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "PDF";
                            currentFile.Item.Update();
                        }

                        if (fuOF8File.HasFile)
                        {
                            fStream = fuOF8File.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuOF8File.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "OF8";
                            currentFile.Item.Update();
                        }

                        if (fuJAFFile.HasFile)
                        {
                            fStream = fuJAFFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuJAFFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "JAF";
                            currentFile.Item.Update();
                        }

                        if (fuWSRVQFile.HasFile)
                        {
                            fStream = fuWSRVQFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuWSRVQFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "WSRVQ";
                            currentFile.Item.Update();
                        }

                        if (fuKSAFile.HasFile)
                        {
                            fStream = fuKSAFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuKSAFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "KSA";
                            currentFile.Item.Update();
                        }

                        if (fuSEFFile.HasFile)
                        {
                            fStream = fuSEFFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuSEFFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "SEF";
                            currentFile.Item.Update();
                        }

                        if (fuOtherFile.HasFile)
                        {
                            fStream = fuOtherFile.PostedFile.InputStream;
                            contents = new byte[fStream.Length];

                            fStream.Read(contents, 0, (int)fStream.Length);
                            fStream.Close();

                            currentFile = web.Files.Add(SubFolderUrl + fuOtherFile.FileName, contents, true);
                            //currentFile.Item["PDNumber"] = txtPDNumber.Text;
                            currentFile.Item["FileType"] = "Other";
                            currentFile.Item.Update();
                        }

                        ////finally show the hidden div thata contains the link to open the folder as explorer

                        //newPDForm.Visible = false;
                        //actionsDiv.Visible = false;
                        //documentsLinkDiv.Visible = true;

                        //Dispose elements section?

                        //Redirect to home page
                        Response.Redirect("Home.aspx");

                    }
                    catch (ArgumentException ex)
                    {
                        errorDiv.Visible = true;
                        lblErrorMessage.Text = "Something went wrong. Contact the system administrator.";
                        SPDiagnosticsService diagSvc = SPDiagnosticsService.Local;
                        diagSvc.WriteTrace(0, new SPDiagnosticsCategory("PDLibrary", TraceSeverity.Monitorable, EventSeverity.Error),
                        TraceSeverity.Monitorable, "PD Library error:  {0}", new object[] { ex.ToString() });
                        return;
                    }
                    catch (Exception ex)
                    {
                        errorDiv.Visible = true;
                        lblErrorMessage.Text = "Something went wrong. Contact the system administrator.";
                        SPDiagnosticsService diagSvc = SPDiagnosticsService.Local;
                        diagSvc.WriteTrace(0, new SPDiagnosticsCategory("PDLibrary", TraceSeverity.Monitorable, EventSeverity.Error),
                        TraceSeverity.Monitorable, "PD Library error:  {0}", new object[] { ex.ToString() });
                        return;
                    }
                }
            }
        }

        public string EnsureParentFolder(SPWeb parentSite, string destinUrl)
        {
            destinUrl = parentSite.GetFile(destinUrl).Url;

            int index = destinUrl.LastIndexOf("/");
            string parentFolderUrl = string.Empty;

            if (index > -1)
            {
                parentFolderUrl = destinUrl.Substring(0, index);

                SPFolder parentFolder
                    = parentSite.GetFolder(parentFolderUrl);

                if (!parentFolder.Exists)
                {
                    SPFolder currentFolder = parentSite.RootFolder;

                    foreach (string folder in parentFolderUrl.Split('/'))
                    {
                        currentFolder
                            = currentFolder.SubFolders.Add(folder);
                    }
                }
            }
            return parentFolderUrl;
        }

        protected void clearFields(object send, EventArgs e)
        {
            txtPDNumber.Text = "";
            ddJobTitle.SelectedValue = "";
            ddSeries.SelectedValue = "";
            ddGrade.SelectedValue = "";
            ddPositionType.SelectedValue = "";
            ddOrganization.SelectedValue = "";
            //rdblSupervisoryPosition.SelectedValue = "No";
            txtNotes.Text = "";
            ddActions.SelectedValue = "Live";
        }

        protected void goHome(object send, EventArgs e)
        {
            //Redirect to home page
            Response.Redirect("Home.aspx");
        }
    }
}
