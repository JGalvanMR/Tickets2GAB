using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using Datos;
using System.Data;

namespace Tickets2
{
    public partial class Montito_Tickets : System.Web.UI.Page
    {
        private dcTicketsDataContext dcDatos;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();
            try
            {
                //----------------------------------------------------------------------------------
                //                  SOLICITADOS
                //---------------------------------------------------------------------------------
                var consulta1 = from s in dcDatos.Servicios
                                join pl in dcDatos.Personas on s.Per_ID_Levanto equals pl.Per_ID
                                join dep in dcDatos.Departamentos on s.Ser_DeptoQueAtiende equals dep.Dep_ID
                                where s.Sere_ID == (int)enumServicioEstado.Solicitado
                                orderby s.Ser_ID descending
                                select new
                                {
                                    ID = s.Ser_ID,
                                    Fecha = s.Ser_FechaIngreso,
                                    Nombre = pl.Per_ApePat + " " + pl.Per_Nombre,
                                    Solicitado_A = dep.Dep_Departamento,
                                    Area = s.Ser_Area,
                                    Equipo = s.Ser_Equipo,
                                    Incidente = s.Ser_Incidente,
                                    Estado = "Solicitado"
                                };
                dgSolicitados.DataSource = consulta1;
                dgSolicitados.DataBind();

                //----------------------------------------------------------------------------------
                //                  ASIGNADOS
                //----------------------------------------------------------------------------------
                int ID_Search_Asignados = 0;
                int.TryParse("0", out ID_Search_Asignados);
                var consulta2 = dcDatos.sp_Get_ServiciosAsignados(ID_Search_Asignados, 0);

                dgAbiertos.DataSource = consulta2;
                dgAbiertos.DataBind();

                //----------------------------------------------------------------------------------
                //                  FINALIZADOS
                //----------------------------------------------------------------------------------
                int ID_Search_Finalizados = 0;
                int.TryParse(txtID_Search_Finalizados.Text, out ID_Search_Finalizados);
                var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(ID_Search_Finalizados, 0);

                dgFinalizados.DataSource = consulta3;
                dgFinalizados.DataBind();
            }
            catch (ChangeConflictException)
            {
                foreach (ObjectChangeConflict occ in dcDatos.ChangeConflicts)
                {
                    // All database values overwrite current values.
                    occ.Resolve(RefreshMode.OverwriteCurrentValues);
                    MessageBox.Show("Servicio modificado por otro usuario");
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                MessageBox.Show("Error de SQL: " + ex.Message
                                + "\n" + "Consulte con el administrador del sistema.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ocurrio el siguiente error: " + ex.Message
                                 + "\n" + "Consulte con el administrador del sistema.");
            }
        }

        protected void btnBuscar_Finalizados_Click(object sender, EventArgs e)
        {
            if (txtID_Search_Finalizados.Text.Length == 0)
            {
                //Obtener todos los servicios
                var consulta2 = dcDatos.sp_Get_ServiciosFinalizados(0, 0);

                dgFinalizados.DataSource = consulta2;
                dgFinalizados.DataBind();
            }
            else
            {
                int ID_Search_Finalizados;
                if (!int.TryParse(txtID_Search_Finalizados.Text, out ID_Search_Finalizados))
                {
                    MessageBox.Show("Capture un número entero en la caja de búsqueda");
                    txtID_Search_Finalizados.Focus();
                    return;
                }

                var consulta2 = dcDatos.sp_Get_ServiciosFinalizados(ID_Search_Finalizados, 0);

                dgFinalizados.DataSource = consulta2;
                dgFinalizados.DataBind();
            }
            //limpiar caja
            txtID_Search_Finalizados.Text = "";
        }

        protected void dgFinalizados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            int ID_Search_Finalizados = 0;
            int.TryParse(txtID_Search_Finalizados.Text, out ID_Search_Finalizados);
            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(ID_Search_Finalizados, 0);

            dgFinalizados.PageIndex = e.NewPageIndex;
            dgFinalizados.DataSource = consulta3;
            dgFinalizados.DataBind();
        }
    }
}