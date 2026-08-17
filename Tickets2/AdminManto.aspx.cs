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
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace Tickets2
{
    public partial class AdminManto : System.Web.UI.Page
    {
        private dcTicketsDataContext dcDatos;
        Usuario objAdminMan = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();

            if (Session["objAdminMan"] != null)
            {
                objAdminMan = (Usuario)Session["objAdminMan"];

                if (!IsPostBack)
                {
                    //--------------------------------------------------------------------------------
                    //                  CARGAR COMBO DEL ID DEL ENCARGADO DE ATENDER EL  SERVICIO MANTO
                    //-------------------------------------------------------------------------------
                    CargarCmbResponServicioMan();

                    //-------------------------------------------------------------------
                    //-----------CARGAR GRIDS--------------------------------------
                    CargarGridManto();
                }
            }
            else
            {
                Response.Redirect("PaginaLogin.aspx");
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["objAdminMan"] = null;
            Response.Redirect("PaginaLogin.aspx");
        }

        protected void BtnServicioFinMan_Click(object sender, EventArgs e)
        {
            #region Validar cajas
            if (string.IsNullOrEmpty(txtIdServicioFinMan.Text))
            {
                MessageBox.Show("Ingrese el Id del servicio a finalizar.");
                //limpiar caja
                txtIdServicioFinMan.Text = "";
                txtIdServicioFinMan.Focus();
                return;
            }

            int ID_Servicio_Fin;
            if (!int.TryParse(txtIdServicioFinMan.Text, out ID_Servicio_Fin))
            {
                MessageBox.Show("Ingrese un numero entero en el Id del servicio a finalizar");
                //limpiar caja
                txtIdServicioFinMan.Text = "";
                txtIdServicioFinMan.Focus();
                return;
            }

            //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
            //TENGA ESTATUS 2 (ASIGNADO)
            Servicio objSerValida = (from s in dcDatos.Servicios
                                     where s.Ser_ID == ID_Servicio_Fin
                                     select s).SingleOrDefault();
            if (objSerValida != null)
            {
                if (objSerValida.Sere_ID != (int)enumServicioEstado.Abierto)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Fin.ToString()
                        + " no tiene el estatus: Asignado. Por lo que no se puede finalizar el servicio.");
                    //llimpiar caja
                    txtIdServicioFinMan.Text = "";
                    txtIdServicioFinMan.Focus();
                    return;
                }
            }
            else
            {
                MessageBox.Show("No existe el servicio.");
                return;
            }
            if (objSerValida.Ser_DeptoQueAtiende != objAdminMan.Persona.Dep_ID)
            {
                MessageBox.Show("El servicio " + ID_Servicio_Fin.ToString()
                    + " no es uno de tus servicios solicitados.");
                txtIdServicioFinMan.Text = "";
                return;
            }
            #endregion

            var queryFinalizarSerMan =
                    from ord in dcDatos.Servicios
                    where ord.Ser_ID == Convert.ToInt32(txtIdServicioFinMan.Text)
                    select ord;
            foreach (Servicio ord in queryFinalizarSerMan)
            {
                ord.Sere_ID = 3;
                ord.Ser_FechaUltimoE = DateTime.Now;
            }
            try
            {
                dcDatos.SubmitChanges();
                CargarGridManto();
                MessageBox.Show("Servicio finalizado correctamente.");
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
            //limpiar caja
            txtIdServicioFinMan.Text = "";
        }

        private void CargarGridManto()
        {
            var consulta1 = dcDatos.sp_Get_ServiciosSolicitadosM(0, 5);
            dgSolicitadosMan.DataSource = consulta1;
            dgSolicitadosMan.DataBind();

            var consulta4 = dcDatos.sp_Get_ServiciosAsignadosM(0, 5);
            dgAbiertosMan.DataSource = consulta4;
            dgAbiertosMan.DataBind();

            var consulta5 = dcDatos.sp_Get_ServiciosFinalizadosM(0, 5);
            dgFinalizadosMan.DataSource = consulta5;
            dgFinalizadosMan.DataBind();
        }

        protected void btnComentarioMan_Click(object sender, EventArgs e)
        {
            try
            {
                #region Validar cajas
                if (string.IsNullOrEmpty(txtIdServicioMan.Text))
                {
                    MessageBox.Show("Ingrese id del servicio a comentar.");
                    //limpiar caja
                    txtIdServicioMan.Text = "";
                    txtIdServicioMan.Focus();
                    return;
                }

                int ID_Servicio_Comentario;
                if (!int.TryParse(txtIdServicioMan.Text, out ID_Servicio_Comentario))
                {
                    MessageBox.Show("Ingrese un numero entero en el Id del servicio por comentar");
                    //limpiar caja
                    txtIdServicioMan.Text = "";
                    txtIdServicioMan.Focus();
                    return;
                }

                if (string.IsNullOrEmpty(txtComentarioMan.Text))
                {
                    MessageBox.Show("Ingrese el comentario.");
                    //limpiar caja
                    txtComentarioMan.Text = "";
                    txtComentarioMan.Focus();
                    return;
                }

                //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
                //ESTE CON ESTATUS 2 (ASIGNADO) y 3(FINALIZADO)
                Servicio objSerValida = (from s in dcDatos.Servicios
                                         where s.Ser_ID == ID_Servicio_Comentario
                                         select s).SingleOrDefault();
                if (objSerValida != null)
                {
                    if (objSerValida.Sere_ID == (int)enumServicioEstado.Solicitado)
                    {
                        MessageBox.Show("El servicio " + ID_Servicio_Comentario.ToString()
                            + " tiene el estatus: Solicitado. Por lo que no se puede comentar.");
                        txtComentarioMan.Text = "";
                        return;
                    }
                }
                if (objSerValida.Ser_DeptoQueAtiende != objAdminMan.Persona.Dep_ID)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Comentario.ToString()
                        + " no es uno de tus servicios solicitados.");
                    txtIdServicioMan.Text = "";
                    return;
                }
                #endregion

                Comentario objComen = new Comentario();

                //CALCULAR EL SIG. ID
                var queryComentarMan =
                        from row in dcDatos.Comentarios
                        group row by true into s
                        select new
                        {
                            newID = s.Max(id => id.Com_ID)
                        };
                if (queryComentarMan.First() != null)
                    objComen.Com_ID = queryComentarMan.First().newID + 1;
                else
                    objComen.Com_ID = 1;

                objComen.Ser_ID = ID_Servicio_Comentario;
                objComen.Com_Comentario = txtComentarioMan.Text;
                objComen.Com_FechaCom = DateTime.Now;
                objComen.Per_ID = objAdminMan.Per_ID;

                dcDatos.Comentarios.InsertOnSubmit(objComen);
                dcDatos.SubmitChanges();
                CargarGridManto();
                MessageBox.Show("Comentario ingresado correctamente.");
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
            txtComentarioMan.Text = "";
            txtIdServicioMan.Text = "";
        }

        private void CargarCmbResponServicioMan()
        {
            SqlConnection con = new SqlConnection("Data Source=tcp:192.168.123.6,1433;Initial Catalog=GAB_Irapuato;Persist Security Info=True;User ID=sa;Password=Gabira2026$");
            SqlCommand cmd = new SqlCommand("select nom_empleado from tb_man_cat_empleado where estatus_empleado = 'A'", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            cmbResponsableServicioMan.DataSource = ds;
            cmbResponsableServicioMan.DataTextField = "nom_empleado";
            cmbResponsableServicioMan.DataValueField = "nom_empleado";
            cmbResponsableServicioMan.DataBind();
        }

        protected void btnAsignarServicioMan_Click(object sender, EventArgs e)
        {
            #region Validar cajas
            if (string.IsNullOrEmpty(txtIdServicioResponsableMan.Text))
            {
                MessageBox.Show("Ingrese el Id del servicio a por asignar.");
                //limpiar caja
                txtIdServicioResponsableMan.Text = "";
                txtIdServicioResponsableMan.Focus();
                return;
            }

            if (string.IsNullOrEmpty(datetimepicker4.Text))
            {
                MessageBox.Show("Ingrese fecha estimada de fin de servicio");
                //limpiar caja
                datetimepicker4.Text = "";
                datetimepicker4.Focus();
                return;
            }

            int ID_Servicio_Responsable;
            if (!int.TryParse(txtIdServicioResponsableMan.Text, out ID_Servicio_Responsable))
            {
                MessageBox.Show("Ingrese un numero entero en el Id del servicio por asignar");
                //limpiar caja
                txtIdServicioResponsableMan.Text = "";
                txtIdServicioResponsableMan.Focus();
                return;
            }
            if (cmbResponsableServicioMan.SelectedIndex == -1)
            {
                MessageBox.Show("Seleccione un responsable del servicio.");
                cmbResponsableServicioMan.Focus();
                return;
            }
            //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
            //TENGA ESTATUS 2 (ASIGNADO)
            Servicio objSerValida = (from s in dcDatos.Servicios
                                     where s.Ser_ID == ID_Servicio_Responsable
                                     select s).SingleOrDefault();
            if (objSerValida != null)
            {
                if (objSerValida.Sere_ID != (int)enumServicioEstado.Solicitado)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Responsable.ToString()
                        + " no tiene el estatus: Solicitado. Por lo que no se puede asignar un responsable al servicio.");
                    //llimpiar caja
                    txtIdServicioResponsableMan.Text = "";
                    txtIdServicioResponsableMan.Focus();
                    return;
                }
            }
            else
            {
                MessageBox.Show("No existe el servicio.");
                return;
            }
            if (objSerValida.Ser_DeptoQueAtiende != objAdminMan.Persona.Dep_ID)
            {
                MessageBox.Show("El servicio " + ID_Servicio_Responsable.ToString()
                    + " no es uno de tus servicios solicitados.");
                txtIdServicioResponsableMan.Text = "";
                return;
            }
            #endregion

            try
            {
                Servicio objSer = (from s in dcDatos.Servicios
                                   where s.Ser_ID == ID_Servicio_Responsable
                                   select s).SingleOrDefault();
                if (objSer != null)
                {


                    string[] fecha = datetimepicker4.Text.Split('/');


                    objSer.Ser_Nombre_Atiende = cmbResponsableServicioMan.SelectedValue;
                    objSer.Ser_FechaUltimoE = DateTime.Now;
                    objSer.Sere_ID = (int)enumServicioEstado.Abierto;
                    objSer.Ser_FechaEstimadaFin = Convert.ToDateTime(fecha[1] + "/" + fecha[0] + "/" + fecha[2]);
                    dcDatos.SubmitChanges();
                    //Actualizar grid
                    CargarGridManto();
                    MessageBox.Show("Servicio asignado correctamente a un responsable");
                }
                else
                    MessageBox.Show("No se pudo obtener el servicio con ID " + ID_Servicio_Responsable.ToString());
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
            //limpiar caja
            txtIdServicioResponsableMan.Text = "";
            cmbResponsableServicioMan.SelectedIndex = -1;
        }

        protected void dgFinalizadosMan_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            var consulta5 = dcDatos.sp_Get_ServiciosFinalizadosM(0, 5);
            dgFinalizadosMan.PageIndex = e.NewPageIndex;
            dgFinalizadosMan.DataSource = consulta5;
            dgFinalizadosMan.DataBind();
        }

        protected void btnfotofin_Click(object sender, EventArgs e)
        {
            try
            {
                #region Validar cajas
                if (string.IsNullOrEmpty(idserviciofotos.Text))
                {
                    MessageBox.Show("Ingrese id del servicio donde se cargaran las fotos.");
                    //limpiar caja
                    idserviciofotos.Text = "";
                    idserviciofotos.Focus();
                    return;
                }

                int ID_Servicio_foto;
                if (!int.TryParse(idserviciofotos.Text, out ID_Servicio_foto))
                {
                    MessageBox.Show("Ingrese un numero entero en el Id del servicio donde se cargaran las fotos");
                    //limpiar caja
                    idserviciofotos.Text = "";
                    idserviciofotos.Focus();
                    return;
                }

                if (FileUploadFoto.HasFile == false)
                {
                    MessageBox.Show("Cargue la o las fotos.");
                    return;
                }

                //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
                //ESTE CON ESTATUS 2 (ASIGNADO) y 3(FINALIZADO)
                Servicio objSerValida = (from s in dcDatos.Servicios
                                         where s.Ser_ID == ID_Servicio_foto
                                         select s).SingleOrDefault();
                if (objSerValida != null)
                {
                    if (objSerValida.Sere_ID == (int)enumServicioEstado.Solicitado)
                    {
                        MessageBox.Show("El servicio " + ID_Servicio_foto.ToString()
                            + " tiene el estatus: Solicitado. Por lo que no se puede agregar fotos.");
                        idserviciofotos.Text = "";
                        return;
                    }
                }
                else
                {
                    MessageBox.Show("No existe el servicio.");
                    return;
                }
                if (objSerValida.Ser_DeptoQueAtiende != objAdminMan.Persona.Dep_ID)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_foto.ToString()
                        + " no es uno de tus servicios solicitados.");
                    idserviciofotos.Text = "";
                    return;
                }

                //validar numero de fotos a subir
                HttpFileCollection uploadedFiles = Request.Files;
                if (uploadedFiles.Count > 5)
                {
                    MessageBox.Show("Solo se pueden subir maximo 5 fotos");
                    return;
                }
                #endregion

                string savePath = @"\\Gabira1\FotosManto\Finalizado\";
                string fileName = ID_Servicio_foto.ToString();
                int numfotos = 0;

                var consultaNewID = from row in dcDatos.Servicios
                                    where row.Ser_ID == ID_Servicio_foto
                                    select new
                                    {
                                        Nofotos = row.Ser_Num_Fotos
                                    };

                if (consultaNewID.First() != null)
                    numfotos = Convert.ToInt32(consultaNewID.First().Nofotos);
                else
                    numfotos = Convert.ToInt32(0);

                Servicio objSer = (from s in dcDatos.Servicios
                                   where s.Ser_ID == ID_Servicio_foto
                                   select s).SingleOrDefault();
                if (objSer != null)
                {
                    objSer.Ser_Num_Fotos = numfotos + uploadedFiles.Count;

                    //dcDatos.Servicio.InsertOnSubmit(objServ);
                    dcDatos.SubmitChanges();
                }
                else
                    MessageBox.Show("Error");



                for (int i = 0; i < uploadedFiles.Count; i++)
                {
                    HttpPostedFile userPostedFile = uploadedFiles[i];
                    try
                    {
                        if (userPostedFile.ContentLength > 0)
                        {
                            //userPostedFile.SaveAs(savePath + Path.GetFileName(fileName) + (i + 1 + numfotos) + ".jpg");
                            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(userPostedFile.InputStream);
                            System.Drawing.Image objImage = ScaleImage(bmpPostedImage, 405);
                            objImage.Save(savePath + Path.GetFileName(fileName) + (i + 1 + numfotos) + ".jpg", ImageFormat.Jpeg);
                        }
                    }
                    catch (Exception Ex)
                    {
                        MessageBox.Show("Error " + Ex.Message);
                    }
                }

                MessageBox.Show("Fotos cargadas correctamente.");
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
            //limpiar caja
            idserviciofotos.Text = "";
        }

        public static System.Drawing.Image ScaleImage(System.Drawing.Image image, int maxHeight)
        {
            var ratio = (double)maxHeight / image.Height;
            var newWidth = (int)(image.Width * ratio);
            var newHeight = (int)(image.Height * ratio);
            var newImage = new Bitmap(newWidth, newHeight);
            using (var g = Graphics.FromImage(newImage))
            {
                g.DrawImage(image, 0, 0, newWidth, newHeight);
            }
            return newImage;
        }
    }
}