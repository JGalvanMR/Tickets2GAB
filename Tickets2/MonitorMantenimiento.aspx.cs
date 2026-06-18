using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using Datos;
using System.Data.SqlClient;
using System.Data;

namespace Tickets2
{
    public partial class MonitorMantenimiento : System.Web.UI.Page
    {
        private dcTicketsDataContext dcDatos;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();
            CargarGridManto();
        }
        private void CargarGridManto()
        {
            //var consulta1 = dcDatos.sp_Get_ServiciosSolicitados(0, 5);
            var consulta1 = dcDatos.sp_Get_ServiciosSolicitadosM(0, 5);
            dgSolicitadosMan.DataSource = consulta1;
            dgSolicitadosMan.DataBind();

            //var consulta4 = dcDatos.sp_Get_ServiciosAsignados(0, 5);
            var consulta4 = dcDatos.sp_Get_ServiciosAsignadosM(0, 5);
            dgAbiertosMan.DataSource = consulta4;
            dgAbiertosMan.DataBind();
        }
    }
}