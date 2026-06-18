using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;
using Datos;
using System.IO;
using System.Transactions;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq.Expressions;
using System.Net.Mail;
using System.Text;
using System.Net;

namespace Tickets2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private dcTicketsDataContext dcDatos;
        Usuario objAdmin = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();

                if (Session["objAdmin"] != null)
                {
                    objAdmin = (Usuario)Session["objAdmin"];

                    if (!IsPostBack)
                    {
                        //----------------------------------------------------------------------------------
                        //                  CARGAR COMBO DEL ID DEL DEPARTAMENTO 
                        //----------------------------------------------------------------------------------
                        var consultaDeptoID = from d in dcDatos.Departamento
                                              select new
                                              {
                                                  Id = d.dep_ID,
                                                  Departamentos = d.dep_Departamento
                                              };
                        cmbDepto.DataSource = consultaDeptoID.ToList();
                        cmbDepto.DataValueField = "Id";
                        cmbDepto.DataTextField = "Departamentos";
                        cmbDepto.DataBind();

                        if (cmbDepto.Items.Count > 0)
                            cmbDepto.SelectedIndex = -1;

                        //--------------------------------------------------------------------------------
                        //                  CARGAR COMBO DEL ID DEL ENCARGADO DE ATENDER EL  SERVICIO
                        //---------------------------------------------------------------------------------

                        var consultaAsignarRespon = from d in dcDatos.Persona
                                                    where d.dep_ID == 1 && d.per_IsActivo == true
                                                    select new
                                                    {
                                                        Nombre = d.per_Nombre + " " + d.per_ApePat
                                                    };
                        cmbResponsableServicioSis.DataSource = consultaAsignarRespon.ToList();
                        cmbResponsableServicioSis.DataValueField = "Nombre";
                        cmbResponsableServicioSis.DataTextField = "Nombre";
                        cmbResponsableServicioSis.DataBind();

                        if (cmbResponsableServicioSis.Items.Count > 0)
                            cmbResponsableServicioSis.SelectedIndex = -1;

                        //-------------------------------------------------------------------
                        //-----------CARGAR GRIDS--------------------------------------
                        CargarGridSistemas();
                    }
                }
                else
                {
                    Response.Redirect("PaginaLogin.aspx");
                }  
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["objAdmin"] = null;
            Response.Redirect("PaginaLogin.aspx");
        }

        protected void BtnRegistro_Click(object sender, EventArgs e)
        {
            objAdmin = (Usuario)Session["objAdmin"];
            try
            {
                #region VALIDACIONES DE DATOS
                if (string.IsNullOrEmpty(txtNombre.Text))
                {
                    MessageBox.Show("Capture el nombre de la persona.");
                    txtNombre.Focus();
                    return;
                }
                else if(string.IsNullOrEmpty(txtApellidoP.Text))
                {
                    MessageBox.Show("Capture el apellido paterno de la persona.");
                    txtApellidoP.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(txtApellidoM.Text))
                {
                    MessageBox.Show("Capture el apellido materno de la persona.");
                    txtApellidoM.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(txtEmail.Text))
                {
                    MessageBox.Show("Capture Email de la persona.");
                    txtEmail.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(txtTele.Text))
                {
                    MessageBox.Show("Capture el telefono de la persona.");
                    txtTele.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(txtNombreUsuario.Text))
                {
                    MessageBox.Show("Capture el nombre del usuario.");
                    txtNombreUsuario.Focus();
                    return;
                }
                else if (string.IsNullOrEmpty(txtPasswordUsuario.Text))
                {
                    MessageBox.Show("Capture la contraseña del usuario.");
                    txtPasswordUsuario.Focus();
                    return;
                }

                if (cmbDepto.SelectedIndex == -1)
                {
                    MessageBox.Show("Seleccione un Departamento.");
                    cmbDepto.Focus();
                    return;
                }
                #endregion

                Persona objPer = new Persona();
                var consultaNewPersona = from row in dcDatos.Persona
                                         group row by true into s
                                         select new
                                         {
                                             newID = s.Max(id => id.per_ID)
                                         };
                if (consultaNewPersona.First() != null)
                    objPer.per_ID = consultaNewPersona.First().newID + 1;
                else
                    objPer.per_ID = 1;
                objPer.per_Nombre = txtNombre.Text;
                objPer.per_ApePat = txtApellidoP.Text;
                objPer.per_ApeMat = txtApellidoM.Text;
                objPer.per_Email = txtEmail.Text;
                objPer.per_ExtTelefono = txtTele.Text;
                objPer.per_IsActivo = true;
                objPer.dep_ID = int.Parse(cmbDepto.SelectedValue);

                dcDatos.Persona.InsertOnSubmit(objPer);
                dcDatos.SubmitChanges();

                Usuario objUsu = new Usuario();
                var consultaNewUsuario = from row in dcDatos.Usuario
                                         group row by true into s
                                         select new
                                         {
                                             newID = s.Max(id => id.usu_ID)
                                         };
                if (consultaNewUsuario.First() != null)
                    objUsu.usu_ID = consultaNewUsuario.First().newID + 1;
                else
                    objUsu.usu_ID = 1;
                objUsu.usu_Usuario = txtNombreUsuario.Text;
                objUsu.usu_Password = txtPasswordUsuario.Text;
                objUsu.per_ID = objPer.per_ID;

                dcDatos.Usuario.InsertOnSubmit(objUsu);
                dcDatos.SubmitChanges();

                if (cmbRol.SelectedValue == "cmbUsuario")
                {
                    Trabajador objTrab = new Trabajador();
                    var consultaNewTrabajador = from row in dcDatos.Trabajador
                                             group row by true into s
                                             select new
                                             {
                                                 newID = s.Max(id => id.tra_ID)
                                             };
                    if (consultaNewTrabajador.First() != null)
                        objTrab.tra_ID = consultaNewTrabajador.First().newID + 1;
                    else
                        objTrab.tra_ID = 1;
                    objTrab.per_ID = objPer.per_ID;

                    dcDatos.Trabajador.InsertOnSubmit(objTrab);
                    dcDatos.SubmitChanges();
                }
                else
                {
                    Administrador objAdministrador = new Administrador();
                    var consultaNewAdministrador = from row in dcDatos.Administrador
                                                group row by true into s
                                                select new
                                                {
                                                    newID = s.Max(id => id.adm_ID)
                                                };
                    if (consultaNewAdministrador.First() != null)
                        objAdministrador.adm_ID = consultaNewAdministrador.First().newID + 1;
                    else
                        objAdministrador.adm_ID = 1;
                    objAdministrador.per_ID = objPer.per_ID;

                    dcDatos.Administrador.InsertOnSubmit(objAdministrador);
                    dcDatos.SubmitChanges();
                }
                EnviarCorreoRegistrar();
                MessageBox.Show("Persona Registrada correctamente.");
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
            //LImPIAR CAJAS
            txtNombre.Text = "";
            txtApellidoP.Text = "";
            txtApellidoM.Text = "";
            txtEmail.Text = "";
            txtTele.Text = "";
            txtNombreUsuario.Text = "";
            txtPasswordUsuario.Text = "";
            cmbDepto.SelectedIndex = -1;
        }

        protected void BtnServicioFinSis_Click(object sender, EventArgs e)
        {
            #region Validar cajas
            if (string.IsNullOrEmpty(txtIdServicioFinSis.Text))
            {
                MessageBox.Show("Ingrese el Id del servicio a finalizar.");
                //llimpiar caja
                txtIdServicioFinSis.Text = "";
                txtIdServicioFinSis.Focus();
                return;
            }

            int ID_Servicio_Fin;
            if (!int.TryParse(txtIdServicioFinSis.Text, out ID_Servicio_Fin))
            {
                MessageBox.Show("Ingrese un numero entero en el Id del servicio a finalizar");
                //llimpiar caja
                txtIdServicioFinSis.Text = "";
                txtIdServicioFinSis.Focus();
                return;
            }

            //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
            //TENGA ESTATUS 2 (ASIGNADO)
            Servicio objSerValida = (from s in dcDatos.Servicio
                                     where s.ser_ID == ID_Servicio_Fin
                                     select s).SingleOrDefault();
            if (objSerValida != null)
            {
                if (objSerValida.sere_ID != (int)enumServicioEstado.Abierto)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Fin.ToString()
                        + " no tiene el estatus: Asignado. Por lo que no se puede finalizar el servicio.");
                    //llimpiar caja
                    txtIdServicioFinSis.Text = "";
                    txtIdServicioFinSis.Focus();
                    return;
                }
            }
            else
            {
                MessageBox.Show("No existe el servicio.");
                return;
            }
            if (objSerValida.ser_DeptoQueAtiende != objAdmin.Persona.dep_ID)
            {
                MessageBox.Show("El servicio " + ID_Servicio_Fin.ToString()
                    + " no es uno de tus servicios solicitados.");
                txtIdServicioFinSis.Text = "";
                return;
            }
            #endregion

            var queryFinalizarSerSis =
                    from ord in dcDatos.Servicio
                    where ord.ser_ID == Convert.ToInt32(txtIdServicioFinSis.Text)
                    select ord;
            foreach (Servicio ord in queryFinalizarSerSis)
            {
                ord.sere_ID = 3;
                ord.ser_FechaUltimoE = DateTime.Now;
            }
            try
            {
                dcDatos.SubmitChanges();
                CargarGridSistemas();
                EnviarCorreoFinalizar();
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
            //llimpiar caja
            txtIdServicioFinSis.Text = "";
        }

        protected void btnAsignarServicioSis_Click(object sender, EventArgs e)
        {
            #region Validar cajas
            if (string.IsNullOrEmpty(txtIdServicioResponsableSis.Text))
            {
                MessageBox.Show("Ingrese el Id del servicio a por asignar.");
                //limpiar caja
                txtIdServicioResponsableSis.Text = "";
                txtIdServicioResponsableSis.Focus();
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
            if (!int.TryParse(txtIdServicioResponsableSis.Text, out ID_Servicio_Responsable))
            {
                MessageBox.Show("Ingrese un numero entero en el Id del servicio por asignar");
                //limpiar caja
                txtIdServicioResponsableSis.Text = "";
                txtIdServicioResponsableSis.Focus();
                return;
            }
            if (cmbResponsableServicioSis.SelectedIndex == -1)
            {
                MessageBox.Show("Seleccione un responsable del servicio.");
                cmbResponsableServicioSis.Focus();
                return;
            }
            //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
            //TENGA ESTATUS 2 (ASIGNADO)
            Servicio objSerValida = (from s in dcDatos.Servicio
                                     where s.ser_ID == ID_Servicio_Responsable
                                     select s).SingleOrDefault();
            if (objSerValida != null)
            {
                if (objSerValida.sere_ID != (int)enumServicioEstado.Solicitado)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Responsable.ToString()
                        + " no tiene el estatus: Solicitado. Por lo que no se puede asignar un responsable al servicio.");
                    //llimpiar caja
                    txtIdServicioResponsableSis.Text = "";
                    txtIdServicioResponsableSis.Focus();
                    return;
                }
            }
            else
            {
                MessageBox.Show("No existe el servicio.");
                return;
            }
            if (objSerValida.ser_DeptoQueAtiende != objAdmin.Persona.dep_ID)
            {
                MessageBox.Show("El servicio " + ID_Servicio_Responsable.ToString()
                    + " no es uno de tus servicios solicitados.");
                txtIdServicioResponsableSis.Text = "";
                return;
            }
            #endregion
            try
            {
                Servicio objSer = (from s in dcDatos.Servicio
                                   where s.ser_ID == ID_Servicio_Responsable
                                   select s).SingleOrDefault();
                if (objSer != null)
                {
                    string[] fecha = datetimepicker4.Text.Split('/');

                    objSer.ser_Nombre_Atiende = cmbResponsableServicioSis.SelectedValue;
                    objSer.ser_FechaUltimoE = DateTime.Now;
                    objSer.sere_ID = (int)enumServicioEstado.Abierto;
                    objSer.ser_FechaEstimadaFin = Convert.ToDateTime(fecha[1] + "/" +fecha[0] + "/" + fecha[2]);
                    dcDatos.SubmitChanges();
                    //Actualizar grid
                    CargarGridSistemas();
                    EnviarCorreoAsignacion();
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
            txtIdServicioResponsableSis.Text = "";
            cmbResponsableServicioSis.SelectedIndex = -1;
        }

        protected void btnComentarioSis_Click(object sender, EventArgs e)
        {
            try
            {
                #region Validar cajas
                if (string.IsNullOrEmpty(txtIdServicioSis.Text))
                {
                    MessageBox.Show("Ingrese id del servicio a comentar.");
                    //limpiar caja
                    txtIdServicioSis.Text = "";
                    txtIdServicioSis.Focus();
                    return;
                }

                int ID_Servicio_Comentario;
                if (!int.TryParse(txtIdServicioSis.Text, out ID_Servicio_Comentario))
                {
                    MessageBox.Show("Ingrese un numero entero en el Id del servicio por comentar");
                    //limpiar caja
                    txtIdServicioSis.Text = "";
                    txtIdServicioSis.Focus();
                    return;
                }

                if (string.IsNullOrEmpty(txtComentarioSis.Text))
                {
                    MessageBox.Show("Ingrese el comentario.");
                    //limpiar caja
                    txtComentarioSis.Text = "";
                    txtComentarioSis.Focus();
                    return;
                }

                //VALIDAR QUE EL EL SERVICIO PROPORCIONADO
                //ESTE CON ESTATUS 2 (ASIGNADO) y 3(FINALIZADO)
                Servicio objSerValida = (from s in dcDatos.Servicio
                                         where s.ser_ID == ID_Servicio_Comentario
                                         select s).SingleOrDefault();
                if (objSerValida != null)
                {
                    if (objSerValida.sere_ID == (int)enumServicioEstado.Solicitado)
                    {
                        MessageBox.Show("El servicio " + ID_Servicio_Comentario.ToString()
                            + " tiene el estatus: Solicitado. Por lo que no se puede comentar.");
                        txtComentarioSis.Text = "";
                        return;
                    }
                }
                else
                {
                    MessageBox.Show("No existe el servicio.");
                    return;
                }
                if (objSerValida.ser_DeptoQueAtiende != objAdmin.Persona.dep_ID)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Comentario.ToString()
                        + " no es uno de tus servicios solicitados.");
                    txtComentarioSis.Text = "";
                    return;
                }
                #endregion

                Comentario objComen = new Comentario();

                //CALCULAR EL SIG. ID
                var queryComentarSis =
                        from row in dcDatos.Comentario
                        group row by true into s
                        select new
                        {
                            newID = s.Max(id => id.com_ID)
                        };
                try
                {
                    if (queryComentarSis.First() != null)
                        objComen.com_ID = queryComentarSis.First().newID + 1;
                    else
                        objComen.com_ID = 1;
                }
                catch {
                    objComen.com_ID = 1;
                }
                

                objComen.ser_ID = ID_Servicio_Comentario;
                objComen.com_Comentario = txtComentarioSis.Text;
                objComen.com_FechaCom = DateTime.Now;
                objComen.per_ID = objAdmin.per_ID;

                dcDatos.Comentario.InsertOnSubmit(objComen);
                dcDatos.SubmitChanges();
                CargarGridSistemas();
                EnviarCorreoComentario();
                MessageBox.Show("Comentario ingresado correctamente.");

                //limpiar caja
                txtIdServicioSis.Text = "";
                txtComentarioSis.Text = "";
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
            txtComentarioSis.Text = "";
            txtIdServicioSis.Text = "";
        }

        private void CargarGridSistemas()
        {
            var consulta1 = dcDatos.sp_Get_ServiciosSolicitados(0, 1);
            dgSolicitados.DataSource = consulta1;
            dgSolicitados.DataBind();

            var consulta2 = dcDatos.sp_Get_ServiciosAsignados(0, 1);
            dgAbiertosSis.DataSource = consulta2;
            dgAbiertosSis.DataBind();

            //var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(0, 1);
            //dgFinalizadosxis.DataSource = consulta3;
            //dgFinalizadosxis.DataBind();
        }

        protected void dgFinalizadosSis_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(0, 1);
            dgFinalizadosxis.PageIndex = e.NewPageIndex;
            dgFinalizadosxis.DataSource = consulta3;
            dgFinalizadosxis.DataBind();
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
                Servicio objSerValida = (from s in dcDatos.Servicio
                                         where s.ser_ID == ID_Servicio_foto
                                         select s).SingleOrDefault();
                if (objSerValida != null)
                {
                    if (objSerValida.sere_ID == (int)enumServicioEstado.Solicitado)
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
                if (objSerValida.ser_DeptoQueAtiende != objAdmin.Persona.dep_ID)
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

                string savePath = "~/FotosManto/";
                savePath = Server.MapPath(savePath);

                var existe = Directory.Exists(savePath);

                if (!Directory.Exists(savePath))
                {
                    System.IO.Directory.CreateDirectory(savePath);
                }
                string fileName = ID_Servicio_foto.ToString();
                int numfotos = 0;

                var consultaNewID = from row in dcDatos.Servicio
                                    where row.ser_ID == ID_Servicio_foto
                                    select new
                                    {
                                        Nofotos = row.ser_Num_Fotos
                                    };

                if (consultaNewID.First() != null)
                    numfotos = Convert.ToInt32(consultaNewID.First().Nofotos);
                else
                    numfotos = Convert.ToInt32(0);

                Servicio objSer = (from s in dcDatos.Servicio
                                   where s.ser_ID == ID_Servicio_foto
                                   select s).SingleOrDefault();
                if (objSer != null)
                {
                    objSer.ser_Num_Fotos = numfotos + uploadedFiles.Count;

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


        public void EnviarCorreoAsignacion()
        {
            string mensaje = "";
            string correodestino = "";
            var consulta = from u in dcDatos.Servicio
                           join p in dcDatos.Persona
                           on new { u.per_ID_Levanto} equals
                           new { per_ID_Levanto = p.per_ID} into sr
                           from x in sr.DefaultIfEmpty()
                           where u.ser_ID == Convert.ToInt32(txtIdServicioResponsableSis.Text)
                           select new
                           {
                               descripcion = u.ser_Incidente,
                               horaingreso = u.ser_FechaIngreso,
                               levanto = x.per_Nombre + " " + x.per_ApePat + " " + x.per_ApeMat,
                               correo = x.per_Email,
                               copiacorreo = x.per_copia
                           };
            string html = "";
            string html2 = "";

            MailMessage message = new MailMessage();

            if (consulta.Count() > 0)
            {
                foreach (var i in consulta)
                {
                    mensaje = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + txtIdServicioResponsableSis.Text.Trim() + "</td></tr><tr><td>Reporto: </td><td>" + i.levanto + "</td></tr><tr><td>Descripcion: </td><td>" + i.descripcion + "</td></tr><tr><td>Fecha Estimada de finalizacion: </td><td>" + datetimepicker4.Text + "</td></tr><tr><td>Servicio Atendido Por: </td><td>" + cmbResponsableServicioSis.Text + "</td></tr><tr><td>Liga local: </td><td>http://192.168.123.4:81/Tickets2/Administrador.aspx</td></tr><tr><td>Liga Internet: </td><td>http://189.206.160.206:81/Tickets2/Administrador.aspx</td></tr></table>";
                    correodestino = i.correo;
                    if (i.copiacorreo != "" && i.copiacorreo != null)
                    {
                        message.CC.Add(i.copiacorreo);
                    }

                    #region CodigoAnteriorValidaCorreo
                    /*

                    if (i.levanto == "Materia Prima .")
                    {
                        message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
                    }

                    if (i.levanto == "Vigilancia . .")
                    {
                        message.CC.Add("jcgarcia@mrlucky.com.mx");
                    }

                    if (i.levanto == "JOSE MANUEL PRIETO RANGEL" || i.levanto.Trim() == "Jose Manuel Prieto Rangel")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "HECTOR GUSTAVO CAMPA ALVARADO" || i.levanto.Trim() == "Hector Gustavo Campa Alvarado")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "ensaladas")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "fresco")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }*/
                    #endregion
                }
            }

            
            
            message.To.Add(correodestino);
            message.Subject = "Sistema de Tickets - Asignacion";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            var correodes = from d in dcDatos.Persona
                         where d.dep_ID == 1 && d.per_IsActivo == true 
                         select new
                         {
                             correo = d.per_Email 
                         };
            if (correodes.Count() > 0)
              foreach (var i in correodes)
                   //message.CC.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, aescamilla@mrlucky.com.mx, ivan@mrlucky.com.mx");
                    message.CC.Add(i.correo);
            message.Body = mensaje;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;
            message.From = new MailAddress("sistemas@mrlucky.com.mx");
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Credentials = (ICredentialsByHost)new NetworkCredential("sistemas", "sisgab");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Host = "mail1.mrlucky.com.mx";
            try
            {
                smtpClient.Send(message);
            }
            catch (SmtpException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }


        public void EnviarCorreoComentario()
        {
            string mensaje = "";
            string correodestino = "";
            var consulta = from u in dcDatos.Servicio
                           join p in dcDatos.Persona
                           on new { u.per_ID_Levanto } equals
                           new { per_ID_Levanto = p.per_ID } into sr
                           from x in sr.DefaultIfEmpty()
                           where u.ser_ID == Convert.ToInt32(txtIdServicioSis.Text)
                           select new
                           {
                               atiende = u.ser_Nombre_Atiende,
                               descripcion = u.ser_Incidente,
                               horaingreso = u.ser_FechaIngreso,
                               levanto = x.per_Nombre + " " + x.per_ApePat + " " + x.per_ApeMat,
                               correo = x.per_Email,
                               copiacorreo = x.per_copia
                           };
            string html = "";
            string html2 = "";
            MailMessage message = new MailMessage();
            if (consulta.Count() > 0)
            {
                foreach (var i in consulta)
                {
                    mensaje = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + txtIdServicioSis.Text.Trim() + "</td></tr><tr><td>Reporto: </td><td>" + i.levanto + "</td></tr><tr><td>Descripcion: </td><td>" + i.descripcion + "</td></tr><tr><td>Servicio Atendido Por: </td><td>" + i.atiende + "</td></tr><tr><td>Comentario: </td><td>" + txtComentarioSis.Text + "</td></tr></table>";
                    correodestino = i.correo;
                    if (i.copiacorreo != "" && i.copiacorreo != null)
                    {
                        message.CC.Add(i.copiacorreo);
                    }

                    /*if (i.levanto == "Materia Prima .")
                    {
                        message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
                    }

                    if (i.levanto == "Vigilancia . .")
                    {
                        message.CC.Add("jcgarcia@mrlucky.com.mx");
                    }

                    if (i.levanto == "JOSE MANUEL PRIETO RANGEL" || i.levanto.Trim() == "Jose Manuel Prieto Rangel")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "HECTOR GUSTAVO CAMPA ALVARADO" || i.levanto.Trim() == "Hector Gustavo Campa Alvarado")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "ensaladas")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto == "fresco")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }*/
                }
            }
            //MessageBox.Show(correodestino);
           
            message.To.Add(correodestino);
            message.Subject = "Sistema de Tickets - Comentario";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            var correodes = from d in dcDatos.Persona
                            where d.dep_ID == 1 && d.per_IsActivo == true
                            select new
                            {
                                correo = d.per_Email
                            };
            if (correodes.Count() > 0)
                foreach (var i in correodes)
                    //message.CC.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, aescamilla@mrlucky.com.mx, ivan@mrlucky.com.mx");
                    message.CC.Add(i.correo);
            //message.CC.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, dmunoz@mrlucky.com.mx, aescamilla@mrlucky.com.mx, andrea@mrlucky.com.mx");
            message.Body = mensaje;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;
            message.From = new MailAddress("sistemas@mrlucky.com.mx");
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Credentials = (ICredentialsByHost)new NetworkCredential("sistemas", "sisgab");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Host = "mail1.mrlucky.com.mx";
            try
            {
                smtpClient.Send(message);
            }
            catch (SmtpException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void EnviarCorreoFinalizar()
        {
            string mensaje = "";
            string correodestino = "";
            var consulta = from u in dcDatos.Servicio
                           join p in dcDatos.Persona
                           on new { u.per_ID_Levanto } equals
                           new { per_ID_Levanto = p.per_ID } into sr
                           from x in sr.DefaultIfEmpty()
                           where u.ser_ID == Convert.ToInt32(txtIdServicioFinSis.Text)
                           select new
                           {
                               atiende = u.ser_Nombre_Atiende,
                               descripcion = u.ser_Incidente,
                               horaingreso = u.ser_FechaIngreso,
                               levanto = x.per_Nombre + " " + x.per_ApePat + " " + x.per_ApeMat,
                               correo = x.per_Email,
                               copiacorreo = x.per_copia
                           };
            string html = "";
            string html2 = "";
            MailMessage message = new MailMessage();
            if (consulta.Count() > 0)
            {
                foreach (var i in consulta)
                {
                    mensaje = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + txtIdServicioFinSis.Text.Trim() + "</td></tr><tr><td>Reporto: </td><td>" + i.levanto + "</td></tr><tr><td>Descripcion: </td><td>" + i.descripcion + "</td></tr><tr><td>Servicio Atendido Por: </td><td>" + i.atiende + "</td></tr><tr><td td colspan='2' style='padding:.75pt .75pt .75pt .75pt'><h3>EL SERVICIO FUE FINALIZADO Y CERRADO</h3></td></tr><tr><td colspan='2' style='background:black;padding:.75pt .75pt .75pt .75pt'><h3>Toma un minuto de tu tiempo y contesta la siguiente Encuesta, es para poder brindarte un mejor Servicio</h3></td></tr><tr><td><h4>Liga local: </h4></td><td><h4>http://192.168.123.4:81/encuesta/encuesta.htm?folio=" + txtIdServicioFinSis.Text.Trim() + "</h4></td></tr><tr><td><h4>Liga Internet: </h4></td><td><h4>http://189.206.160.206:81/encuesta/encuesta.htm?folio=" + txtIdServicioFinSis.Text.Trim() + "</h4></td></tr></table>";
                    correodestino = i.correo;
                    if (i.copiacorreo != "" && i.copiacorreo != null)
                    {
                        message.CC.Add(i.copiacorreo);
                    }
                    /*
                    if (i.levanto == "Materia Prima .")
                    {
                        message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
                    }

                    if (i.levanto == "Vigilancia . .")
                    {
                        message.CC.Add("jcgarcia@mrlucky.com.mx");
                    }

                    if (i.levanto.Trim() == "JOSE MANUEL PRIETO RANGEL" || i.levanto.Trim() == "Jose Manuel Prieto Rangel")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto.Trim() == "HECTOR GUSTAVO CAMPA ALVARADO" || i.levanto.Trim() == "Hector Gustavo Campa Alvarado")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto.Trim() == "ensaladas")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }

                    if (i.levanto.Trim() == "fresco")
                    {
                        message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
                    }*/
                }
            }

            
            message.To.Add(correodestino);
            message.Subject = "Sistema de Tickets - Servicio Finalizado";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            var correodes = from d in dcDatos.Persona
                            where d.dep_ID == 1 && d.per_IsActivo == true
                            select new
                            {
                                correo = d.per_Email
                            };
            if (correodes.Count() > 0)
                foreach (var i in correodes)
                    //message.CC.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, aescamilla@mrlucky.com.mx, ivan@mrlucky.com.mx");
                    message.CC.Add(i.correo);
            //message.CC.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, dmunoz@mrlucky.com.mx, aescamilla@mrlucky.com.mx, andrea@mrlucky.com.mx");
            message.Body = mensaje;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;
            message.From = new MailAddress("sistemas@mrlucky.com.mx");
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Credentials = (ICredentialsByHost)new NetworkCredential("sistemas", "sisgab");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Host = "mail1.mrlucky.com.mx";
            try
            {
                smtpClient.Send(message);
            }
            catch (SmtpException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void EnviarCorreoRegistrar()
        {
            string mensaje = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>REGISTRO AL SISTEMA DE TICKETS EXITOSO</td></tr><tr><td>USUARIO: </td><td>" + txtNombreUsuario.Text + "</td></tr><tr><td>Password: </td><td>" + txtPasswordUsuario.Text + "</td></tr><tr><td>Nombre Del usuario: </td><td>" + txtNombre.Text + " " + txtApellidoP.Text + " " + txtApellidoM.Text + "</td></tr><tr><td>Liga local: </td><td>http://192.168.123.4:81/Tickets2/Administrador.aspx</td></tr><tr><td>Liga Internet: </td><td>http://189.206.160.206:81/Tickets2/Administrador.aspx</td></tr></table>";
            string correodestino = "";
 
            MailMessage message = new MailMessage();
            message.To.Add(txtEmail.Text);
            message.Subject = "Sistema de Tickets - Registro Finalizado";
            message.Body = mensaje;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;
            message.From = new MailAddress("sistemas@mrlucky.com.mx");
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Credentials = (ICredentialsByHost)new NetworkCredential("sistemas", "sisgab");
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.Host = "mail1.mrlucky.com.mx";
            try
            {
                smtpClient.Send(message);
            }
            catch (SmtpException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

    }
}