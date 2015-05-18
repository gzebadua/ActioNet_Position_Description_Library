using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using System.Text;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Security;

namespace PDLibrary.Features.Volpe_PD_Library_Feature
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("a4b2592a-1999-438f-a09a-be665e7a39ef")]
    public class Volpe_PD_Library_FeatureEventReceiver : SPFeatureReceiver
    {
        //// Uncomment the method below to handle the event raised after a feature has been activated.

        //public override void FeatureActivated(SPFeatureReceiverProperties properties)
        //{
        //}


         //Uncomment the method below to handle the event raised before a feature is deactivated.

        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            using (SPSite site = new SPSite(SPContext.Current.Web.Url))
            {

                using (SPWeb web = site.OpenWeb())
                {

                    try
                    {

                        web.AllowUnsafeUpdates = true;
                        List<int> toDelete = new List<int>();
                        SPList list = site.GetCatalog(SPListTemplateType.WebPartCatalog);

                        foreach (SPListItem item in list.Items)
                        {
                            if (item["Name"].ToString() == "Edit PD Form.webpart" ||
                                item["Name"].ToString() == "New PD Form.webpart" ||
                                item["Name"].ToString() == "PD Feedback Form.webpart" ||
                                item["Name"].ToString() == "Search PD Form.webpart"
                                )
                            {
                                toDelete.Add(item.ID);
                            }
                        }

                        foreach (int i in toDelete)
                        {
                            SPListItem item = list.GetItemById(i);
                            item.Delete();
                        }

                        list.Update();
                        web.AllowUnsafeUpdates = false;

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


        // Uncomment the method below to handle the event raised after a feature has been installed.

        //public override void FeatureInstalled(SPFeatureReceiverProperties properties)
        //{
        //}


         //Uncomment the method below to handle the event raised before a feature is uninstalled.

        //public override void FeatureUninstalling(SPFeatureReceiverProperties properties)
        //{
            
        //}

        // Uncomment the method below to handle the event raised when a feature is upgrading.

        //public override void FeatureUpgrading(SPFeatureReceiverProperties properties, string upgradeActionName, System.Collections.Generic.IDictionary<string, string> parameters)
        //{
        //}
    }
}
