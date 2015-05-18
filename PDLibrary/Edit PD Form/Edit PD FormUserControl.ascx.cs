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
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.WebControls;

namespace PDLibrary.Edit_PD_Form
{
    public partial class Edit_PD_FormUserControl : UserControl
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
                return;
            }


            if (!IsPostBack)
            {

                //hide unused Current files labels
                divCurrentWordFile.Visible = false;
                divCurrentPDFFile.Visible = false;
                divCurrentCoversheetFile.Visible = false;
                divCurrentJAFFile.Visible = false;
                divCurrentWSRVQFile.Visible = false;
                divCurrentKSAFile.Visible = false;
                divCurrentSEFFile.Visible = false;
                divCurrentOtherFile.Visible = false;

                if (Request.QueryString["PDID"] != "" && Request.QueryString["PDID"] != null)
                {

                    using (SPSite site = new SPSite(SPContext.Current.Web.Url))
                    {

                        using (SPWeb web = site.OpenWeb())
                        {

                            try
                            {

                                SPList PDList = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionDescriptions");

                                int PDID = 0;

                                try
                                {
                                    PDID = Convert.ToInt32(Request.QueryString["PDID"]);
                                }
                                catch
                                {
                                    Response.Redirect("Home.aspx");
                                }

                                //Get item from List
                                SPListItem PDItem = PDList.GetItemByIdAllFields(PDID);
                                if (PDItem == null && PDID == 0)
                                {
                                    Response.Redirect("Home.aspx");
                                }

                                //Load dynamic dropdowns
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

                                listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/OccupationalSeries");
                                ddSeries.DataSource = listForDropdown.Items;
                                ddSeries.DataValueField = "Title";
                                ddSeries.DataTextField = "Title";
                                ddSeries.DataBind();
                                ddSeries.Items.Insert(0, new ListItem("Select one", String.Empty));

                                listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionTypes");
                                ddPositionType.DataSource = listForDropdown.Items;
                                ddPositionType.DataValueField = "Title";
                                ddPositionType.DataTextField = "Title";
                                ddPositionType.DataBind();
                                ddPositionType.Items.Insert(0, new ListItem("Select one", String.Empty));

                                listForDropdown = web.GetList(SPContext.Current.Web.Url + "/Lists/Organizations");
                                ddOrganization.DataSource = listForDropdown.Items;
                                ddOrganization.DataValueField = "Title";
                                ddOrganization.DataTextField = "Title";
                                ddOrganization.DataBind();
                                ddOrganization.Items.Insert(0, new ListItem("Select one", String.Empty));
                            
                                // Load Data
                                txtHiddenID.Text = PDItem["ID"].ToString();
                                txtPDNumber.Text = (String)PDItem["PDNumber"];
                                ddJobTitle.SelectedValue = (String)PDItem["Title"];
                                ddGrade.SelectedValue = (String)PDItem["PayGrade"];
                                ddSeries.SelectedValue = (String)PDItem["OccupationalSeries"];
                                ddPositionType.SelectedValue = (String)PDItem["PositionType"];
                                ddOrganization.SelectedValue = (String)PDItem["Organization"];
                                //rdblSupervisoryPosition.SelectedValue = (String) item["Supervisory"];
                                string tempNotesString = null;
                                tempNotesString = (String)PDItem["Notes"];
                                txtNotes.Text = SPHttpUtility.ConvertSimpleHtmlToText(tempNotesString, tempNotesString.Length);
                                ddActions.SelectedValue = (String)PDItem["Visibility"];

                                //Get current document urls
                                string SubFolderUrl = SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/";
                                SPFolder SubFolder = web.GetFolder(SubFolderUrl);

                                string searchString = txtPDNumber.Text;
                                SPQuery query = new SPQuery();
                                //query.Query = "<Where><Contains><FieldRef Name=\"PDNumber\" /><Value Type=\"Text\">" + searchString + "</Value></Contains></Where>";
                                query.Query = "";
                                query.Folder = SubFolder;  // This should restrict the query to the subfolder

                                SPDocumentLibrary docList = SubFolder.DocumentLibrary;
                                SPListItemCollection files = docList.GetItems(query);

                                foreach (SPListItem docItem in files)
                                {
                                    if (docItem.FileSystemObjectType == SPFileSystemObjectType.File)
                                    {
                                        if ((String)docItem["FileType"] == "WORD")
                                        {
                                            hlkWordFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkWordFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentWordFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "PDF")
                                        {
                                            hlkPDFFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkPDFFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentPDFFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "OF8")
                                        {
                                            hlkCoversheetFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkCoversheetFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentCoversheetFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "JAF")
                                        {
                                            hlkJAFFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkJAFFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentJAFFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "WSRVQ")
                                        {
                                            hlkWSRVQFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkWSRVQFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentWSRVQFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "KSA")
                                        {
                                            hlkKSAFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkKSAFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentKSAFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "SEF")
                                        {
                                            hlkSEFFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkSEFFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentSEFFile.Visible = true;
                                        }

                                        if ((String)docItem["FileType"] == "OTHER")
                                        {
                                            hlkOtherFile.Text = site.Url + "/" + docItem.File.Url;
                                            hlkOtherFile.NavigateUrl = site.Url + "/" + docItem.File.Url;
                                            divCurrentOtherFile.Visible = true;
                                        }
                                    }
                                }

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

        }

        protected void savePD(object send, EventArgs e)
        {
            errorDiv.Visible = false;

            using(SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {
                    
                    try
                    {
    
                        SPList PDList = web.GetList(SPContext.Current.Web.Url + "/Lists/PositionDescriptions");
                        
                        //Get item from List for update
                        SPListItem PDItem = PDList.GetItemByIdAllFields(Convert.ToInt32(txtHiddenID.Text));
                        
                        if (PDItem == null)
                        {
                            errorDiv.Visible = true;
                            lblErrorMessage.Text = "The PD you are trying to edit doesn't seem to exist in the library anymore. Did someone else deleted it while you were trying to change it?";
                            return;
                        }

                        //Save data to list library
                        PDItem["PDNumber"] = txtPDNumber.Text;
                        PDItem["Title"] = ddJobTitle.SelectedValue;
                        PDItem["Organization"] = ddOrganization.SelectedValue;
                        PDItem["OccupationalSeries"] = ddSeries.SelectedValue;
                        PDItem["PayGrade"] = ddGrade.SelectedValue;
                        PDItem["PositionType"] = ddPositionType.SelectedValue;
                        //item["SupervisoryPositiong"] = rdblSupervisoryPosition.SelectedValue;
                        PDItem["Notes"] = txtNotes.Text;
                        PDItem["Visibility"] = ddActions.SelectedValue;

                        PDItem.Update();

                        EnsureParentFolder(web, SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/dummyFile.txt"); //dummyFile is used to get the underlying method to work (it looks for the parent folder)

                        string SubFolderUrl = SPContext.Current.Web.Url + "/PDDocuments/" + txtPDNumber.Text + "/";
                        SPFolder SubFolder = web.GetFolder(SubFolderUrl);

                        string searchString = txtPDNumber.Text;
                        SPQuery query = new SPQuery();
                        //query.Query = "<Where><Contains><FieldRef Name=\"PDNumber\" /><Value Type=\"Text\">" + searchString + "</Value></Contains></Where>";
                        query.Query = "";
                        query.Folder = SubFolder;  // This should restrict the query to the subfolder

                        SPDocumentLibrary docList = SubFolder.DocumentLibrary;
                        SPListItemCollection files = docList.GetItems(query);

                        //delete the old document (if any) if you are uploading a new one
                        foreach (SPListItem docItem in files)
                        {
                            if (docItem.FileSystemObjectType == SPFileSystemObjectType.File)
                            {
                                
                                switch((String)docItem["FileType"])
                                {
                                    case "WORD":
                                        if(fuWordFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "PDF":
                                        if(fuPDFFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "OF8":
                                        if(fuOF8File.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "JAF":
                                        if (fuJAFFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "WSRVQ":
                                        if (fuWSRVQFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "KSA":
                                        if (fuKSAFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "SEF":
                                        if (fuSEFFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    case "OTHER":
                                        if (fuOtherFile.HasFile) { docItem.Delete(); } else { break; }
                                        break;
                                    default:
                                        break;
                                }
                                
                            }
                        }

                        //now upload replacement files

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
                            currentFile.Item["FileType"] = "OTHER";
                            currentFile.Item.Update();
                        }

                        ////finally show the hidden div that contains the link to open the folder as explorer
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

                SPFolder parentFolder = parentSite.GetFolder(parentFolderUrl);

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
