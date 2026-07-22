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
using System.Net.Mail;
using System.Text;
using System.Linq.Expressions;
using System.Net;

namespace Tickets2
{
    public partial class Solicitudes : System.Web.UI.Page
    {
        private dcTicketsDataContext dcDatos;
        Usuario objUser = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();

            if (Session["objUser"] != null)
            {
                objUser = (Usuario)Session["objUser"];
                if (!this.IsPostBack)
                {
                    lblUsuario.Text = objUser.Persona.per_ID.ToString();
                    lbNombre.Text = objUser.Persona.per_Nombre + " " + objUser.Persona.per_ApePat + " " + objUser.Persona.per_ApeMat;
                    LbEmail.Text = objUser.Persona.per_Email;
                    LbTele.Text = objUser.Persona.per_ExtTelefono;

                    //-------------------------------------
                    //    Cargar combo area
                    //------------------------------------

                    CargarCmbArea();

                    //-------------------------------------
                    //    Cargar combo equipos
                    //-------------------------------------

                    CargarCmbEquipos();

                    //----------------------------------------------------------------------------------
                    //                  CARGAR COMBO DE ASIGNAR A
                    //----------------------------------------------------------------------------------
                    var consultaAsignarA = from d in dcDatos.Departamento
                                           where d.dep_AtiendeServicios == true
                                           select new
                                           {
                                               ID = d.dep_ID,
                                               Departamento = d.dep_Departamento
                                           };
                    cmbAsignar.DataSource = consultaAsignarA.ToList();
                    cmbAsignar.DataValueField = "ID";
                    cmbAsignar.DataTextField = "Departamento";
                    cmbAsignar.DataBind();

                    if (cmbAsignar.Items.Count > 0)
                        cmbAsignar.SelectedIndex = -1;

                    if (cmbAsignar.SelectedValue == "1")
                    {
                        cmbArea.Enabled = false;
                        cmbEquipo.Enabled = false;
                    }

                    //////////////////////////////////
                    //--------CARGAR GRIDS---------//
                    /////////////////////////////////
                    CargarGrids();
                }
            }
            else
            {
                Response.Redirect("PaginaLogin.aspx");
            }
        }

        private void CargarCmbArea()
        {
            SqlConnection con = new SqlConnection("Data Source=tcp:192.168.123.6,1433;Initial Catalog=GAB_Irapuato;Persist Security Info=True;User ID=sa;Password=Gabira2026$");
            SqlCommand cmd = new SqlCommand("select distinct area_equipo from tb_man_cat_equipos where area_equipo != '                    '", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            cmbArea.DataSource = ds;
            cmbArea.DataTextField = "area_equipo";
            cmbArea.DataValueField = "area_equipo";
            cmbArea.DataBind();
        }

        private void CargarCmbEquipos()
        {
            SqlConnection con = new SqlConnection("Data Source=tcp:192.168.123.6,1433;Initial Catalog=GAB_Irapuato;Persist Security Info=True;User ID=sa;Password=Gabira2026$");
            SqlCommand cmd = new SqlCommand("select nom_equipo from tb_man_cat_equipos where (area_equipo ='" + cmbArea.SelectedValue + "') ORDER BY nom_equipo", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            cmbEquipo.DataSource = ds;
            cmbEquipo.DataTextField = "nom_equipo";
            cmbEquipo.DataValueField = "nom_equipo";
            cmbEquipo.DataBind();
        }

        void SaveFile(HttpPostedFile file)
        {
            // Specify the path to save the uploaded file to.
            string savePath = "~/FotosManto/";
            savePath = Server.MapPath(savePath);

            var existe = Directory.Exists(savePath);

            if (!Directory.Exists(savePath))
            {
                System.IO.Directory.CreateDirectory(savePath);
            }


            // Get the name of the file to upload.
            string fileName = "";


            var consultaNewID = from row in dcDatos.Servicio
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.ser_ID)
                                };

            if (consultaNewID.First() != null)
                fileName = Convert.ToString(consultaNewID.First().newID + 1);
            else
                fileName = Convert.ToString(11);

            HttpFileCollection uploadedFiles = Request.Files;

            if (uploadedFiles.Count < 6)
            {
                for (int i = 0; i < uploadedFiles.Count; i++)
                {
                    HttpPostedFile userPostedFile = uploadedFiles[i];
                    try
                    {
                        if (userPostedFile.ContentLength > 0)
                        {
                            //userPostedFile.SaveAs(savePath + Path.GetFileName(fileName) + (i + 1) + ".jpg");
                            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(userPostedFile.InputStream);
                            System.Drawing.Image objImage = ScaleImage(bmpPostedImage, 405);
                            objImage.Save(savePath + Path.GetFileName(fileName) + (i + 1) + ".jpg", ImageFormat.Jpeg);
                        }
                    }
                    catch (Exception Ex)
                    {
                        MessageBox.Show("Error " + Ex.Message);
                    }
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Usuario objUser = (Usuario)Session["objUser"];
            try
            {
                #region VALIDACIONES DE DATOS
                if (string.IsNullOrEmpty(txtIncidente.Text))
                {
                    MessageBox.Show("Capture el incidente del servicio.");
                    //Validar caja de texto del incidente
                    txtIncidente.Text = "";
                    txtIncidente.Focus();
                    return;
                }
                if (cmbAsignar.SelectedIndex == -1)
                {
                    MessageBox.Show("Seleccione un Departamento.");
                    cmbAsignar.Focus();
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

                Servicio objServ = new Servicio();

                var consultaNewID = from row in dcDatos.Servicio
                                    group row by true into s
                                    select new
                                    {
                                        newID = s.Max(id => id.ser_ID)
                                    };
                try
                {
                    if (consultaNewID.First() != null)
                        objServ.ser_ID = consultaNewID.First().newID + 1;
                    else
                        objServ.ser_ID = 1;
                }
                catch
                {
                    objServ.ser_ID = 1;
                }


                objServ.sere_ID = (int)enumServicioEstado.Solicitado;
                objServ.per_ID_Levanto = objUser.Persona.per_ID; //este dato lo obtienes de la variable de sesion del usuario logueado
                objServ.ser_Incidente = txtIncidente.Text;
                if (cmbAsignar.SelectedValue == "5")
                {
                    objServ.ser_Area = cmbArea.SelectedValue;
                    objServ.ser_Equipo = cmbEquipo.SelectedValue;
                }

                // Call a helper method routine to save the file.
                if (FileUploadFoto.HasFile)
                {
                    SaveFile(FileUploadFoto.PostedFile);
                    //objServ.ser_Num_Fotos = uploadedFiles.Count;
                }

                objServ.ser_FechaIngreso = DateTime.Now;
                objServ.ser_FechaUltimoE = objServ.ser_FechaIngreso;
                objServ.ser_DeptoQueAtiende = int.Parse(cmbAsignar.SelectedValue);
                EnviarCorreo();

                dcDatos.Servicio.InsertOnSubmit(objServ);
                dcDatos.SubmitChanges();
                CargarGrids();

                MessageBox.Show("Su servicio ha sido levantado.");
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
            //Validar caja de texto del incidente
            txtIncidente.Text = "";
        }

        public void EnviarCorreo()
        {
            Servicio objServ = new Servicio();

            var consultaNewID = from row in dcDatos.Servicio
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.ser_ID)
                                };
            try
            {
                if (consultaNewID.First() != null)
                    objServ.ser_ID = consultaNewID.First().newID + 1;
                else
                    objServ.ser_ID = 1;
            }
            catch
            {
                objServ.ser_ID = 1;
            }


            Persona persona = this.dcDatos.Persona.Where<Persona>((Expression<Func<Persona, bool>>)(p => p.dep_ID == int.Parse(this.cmbAsignar.SelectedValue))).First<Persona>();
            MailMessage message = new MailMessage();
            //message.To.Add(persona.per_Email);
            message.Subject = "Sistema de Tickets";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            if (this.objUser.Persona.per_copia != "" && this.objUser.Persona.per_copia != null)
            {
                message.CC.Add(this.objUser.Persona.per_copia);
            }
            /*if (this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat == "Materia Prima")
            {
                message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "Vigilancia")
            {
                message.CC.Add("jcgarcia@mrlucky.com.mx");
            }


            if (this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + " " + this.objUser.Persona.per_ApeMat == "JOSE MANUEL PRIETO RANGEL" || this.objUser.Persona.per_Nombre.Trim() + " " + this.objUser.Persona.per_ApePat.Trim() + " " + this.objUser.Persona.per_ApeMat.Trim() == "Jose Manuel Prieto Rangel")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, aaleman@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + " " + this.objUser.Persona.per_ApeMat == "HECTOR GUSTAVO CAMPA ALVARADO" || this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + " " + this.objUser.Persona.per_ApeMat == "Hector Gustavo Campa Alvarado")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, agarcia@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "ensaladas")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, aaleman@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "fresco")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, agarcia@mrlucky.com.mx");
            }
            */

            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "SISTEMAS")
                message.To.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, jgalvan@mrlucky.com.mx, elizabeth@mrlucky.com.mx");
            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "MANTENIMIENTO")
                message.To.Add("mantenimiento@mrlucky.com.mx, aldosoto@mrlucky.com.mx, admin.mtto@mrlucky.com.mx");
            string str = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + objServ.ser_ID.ToString() + "</td></tr><tr><td>Reporto: </td><td>" + this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + "</td></tr><tr><td>Descripcion: </td><td>" + this.txtIncidente.Text + "</td></tr><tr><td>Liga local: </td><td>http://192.168.123.4:81/Tickets2/Administrador.aspx</td></tr><tr><td>Liga Internet: </td><td>http://189.206.160.206:81/Tickets2/Administrador.aspx</td></tr></table>";
            message.Body = str;
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

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session["objUser"] = null;
            Response.Redirect("PaginaLogin.aspx");
        }

        protected void btnComentarioUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                #region Validar cajas
                if (string.IsNullOrEmpty(txtIdServicioUsuario.Text))
                {
                    MessageBox.Show("Ingrese id del servicio a comentar.");
                    //limpiar caja
                    txtIdServicioUsuario.Text = "";
                    txtIdServicioUsuario.Focus();
                    return;
                }

                int ID_Servicio_Comentario;
                if (!int.TryParse(txtIdServicioUsuario.Text, out ID_Servicio_Comentario))
                {
                    MessageBox.Show("Ingrese un numero entero en el Id del servicio por comentar");
                    //limpiar caja
                    txtIdServicioUsuario.Text = "";
                    txtIdServicioUsuario.Focus();
                    return;
                }

                if (string.IsNullOrEmpty(txtComentarioUsuario.Text))
                {
                    MessageBox.Show("Ingrese el comentario.");
                    //limpiar caja
                    txtComentarioUsuario.Text = "";
                    txtComentarioUsuario.Focus();
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
                        txtIdServicioUsuario.Text = "";
                        return;
                    }
                }
                else
                {
                    MessageBox.Show("No existe el servicio.");
                    return;
                }

                if (objSerValida.per_ID_Levanto != objUser.Persona.per_ID)
                {
                    MessageBox.Show("El servicio " + ID_Servicio_Comentario.ToString()
                        + " no es uno de tus servicios solicitados.");
                    txtIdServicioUsuario.Text = "";
                    return;
                }
                #endregion

                Comentario objComen = new Comentario();

                //CALCULAR EL SIG. ID
                var queryComentarUsu =
                        from row in dcDatos.Comentario
                        group row by true into s
                        select new
                        {
                            newID = s.Max(id => id.com_ID)
                        };
                if (queryComentarUsu.First() != null)
                    objComen.com_ID = queryComentarUsu.First().newID + 1;
                else
                    objComen.com_ID = 1;

                objComen.ser_ID = ID_Servicio_Comentario;
                objComen.com_Comentario = txtComentarioUsuario.Text;
                objComen.com_FechaCom = DateTime.Now;
                objComen.per_ID = objUser.per_ID;

                dcDatos.Comentario.InsertOnSubmit(objComen);
                dcDatos.SubmitChanges();
                CargarGrids();
                MessageBox.Show("Comentario ingresado correctamente.");
                EnviarCorreoComentario(Convert.ToString(objSerValida.ser_Incidente), Convert.ToString(objSerValida.ser_Nombre_Atiende));

                //limpiar caja
                txtIdServicioUsuario.Text = "";
                txtComentarioUsuario.Text = "";
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


        public void EnviarCorreoComentario(string incidencia, string atiende)
        {
            Servicio objServ = new Servicio();

            var consultaNewID = from row in dcDatos.Servicio
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.ser_ID)
                                };
            try
            {
                if (consultaNewID.First() != null)
                    objServ.ser_ID = consultaNewID.First().newID + 1;
                else
                    objServ.ser_ID = 1;
            }
            catch
            {
                objServ.ser_ID = 1;
            }


            Persona persona = this.dcDatos.Persona.Where<Persona>((Expression<Func<Persona, bool>>)(p => p.dep_ID == int.Parse(this.cmbAsignar.SelectedValue))).First<Persona>();
            MailMessage message = new MailMessage();
            //message.To.Add(persona.per_Email);
            message.Subject = "Sistema de Tickets - Respuesta Comentario";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            if (this.objUser.Persona.per_copia != "" && this.objUser.Persona.per_copia != null)
            {
                message.CC.Add(this.objUser.Persona.per_copia);
            }
            /*if (this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat == "Materia Prima")
            {
                message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "Vigilancia")
            {
                message.CC.Add("jcgarcia@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre.Trim() + " " + this.objUser.Persona.per_ApePat.Trim() + " " + this.objUser.Persona.per_ApeMat.Trim() == "JOSE MANUEL PRIETO RANGEL" || this.objUser.Persona.per_Nombre.Trim() + " " + this.objUser.Persona.per_ApePat.Trim() + " " + this.objUser.Persona.per_ApeMat.Trim() == "Jose Manuel Prieto Rangel")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + " " + this.objUser.Persona.per_ApeMat == "HECTOR GUSTAVO CAMPA ALVARADO"  || this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + " " + this.objUser.Persona.per_ApeMat == "Hector Gustavo Campa Alvarado")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "ensaladas")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.per_Nombre == "fresco")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }*/

            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "SISTEMAS")
                message.To.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, jgalvan@mrlucky.com.mx, elizabeth@mrlucky.com.mx");
            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "MANTENIMIENTO")
                message.To.Add("mantenimiento@mrlucky.com.mx, aldosoto@mrlucky.com.mx, admin.mtto@mrlucky.com.mx");
            string str = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + txtIdServicioUsuario.Text.ToString() + "</td></tr><tr><td>Reporto: </td><td>" + this.objUser.Persona.per_Nombre + " " + this.objUser.Persona.per_ApePat + "</td></tr><tr><td>Descripcion: </td><td>" + incidencia + "</td></tr></tr><tr><td>Servicio Atendido Por: </td><td>" + atiende + "</td></tr></tr><tr><td>Comentario: </td><td>" + this.txtComentarioUsuario.Text + "</td></tr></table>";
            message.Body = str;
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





        private void CargarGrids()
        {
            ///////////////////////////////////////////////////////////////////////
            //                  SOLICITADOS
            //////////////////////////////////////////////////////////////////////
            var consulta1 = from s in dcDatos.Servicio
                            join pl in dcDatos.Persona on s.per_ID_Levanto equals pl.per_ID
                            join dep in dcDatos.Departamento on s.ser_DeptoQueAtiende equals dep.dep_ID
                            where s.sere_ID == (int)enumServicioEstado.Solicitado && pl.per_ID == objUser.Persona.per_ID
                            orderby s.ser_ID descending
                            select new
                            {
                                ID = s.ser_ID,
                                Fecha = s.ser_FechaIngreso,
                                Nombre = pl.per_ApePat + " " + pl.per_Nombre,
                                Solicitado_A = dep.dep_Departamento,
                                Area = s.ser_Area,
                                Equipo = s.ser_Equipo,
                                Incidente = s.ser_Incidente,
                                Estado = "Solicitado"
                            };

            dgSolicitados.DataSource = consulta1;
            dgSolicitados.DataBind();

            //----------------------------------------------------------------------------------
            //                  ASIGNADOS
            //----------------------------------------------------------------------------------
            var consulta2 = dcDatos.sp_Get_ServiciosAsignados(objUser.per_ID, 0);

            dgAbiertos.DataSource = consulta2;
            dgAbiertos.DataBind();

            //----------------------------------------------------------------------------------
            //                  FINALIZADOS
            //----------------------------------------------------------------------------------

            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(objUser.per_ID, 0);
            dgFinalizados.DataSource = consulta3;
            dgFinalizados.DataBind();

        }

        protected void BtnCambiarContra_Click(object sender, EventArgs e)
        {
            #region Validar Cajas
            if (string.IsNullOrEmpty(txtContraAct.Text))
            {
                MessageBox.Show("Ingrese su contraseña actual.");
                //limpiar caja
                txtContraAct.Text = "";
                txtContraAct.Focus();
                return;
            }
            if (string.IsNullOrEmpty(txtNuevaContra.Text))
            {
                MessageBox.Show("Ingrese su nueva contraseña.");
                //limpiar caja
                txtNuevaContra.Text = "";
                txtNuevaContra.Focus();
                return;
            }
            if (string.IsNullOrEmpty(txtConfirmContra.Text))
            {
                MessageBox.Show("Ingrese la confirmación de su nueva contraseña.");
                //limpiar caja
                txtConfirmContra.Text = "";
                txtConfirmContra.Focus();
                return;
            }
            //Validar si el password actual del usuario coincide con el ingresado en la caja de texto
            Usuario objUsuValida = (from s in dcDatos.Usuario
                                    where s.usu_ID == objUser.usu_ID
                                    select s).SingleOrDefault();
            if (objUsuValida.usu_Password != txtContraAct.Text)
            {
                MessageBox.Show("Contraseña Actual incorrecta");
                //limpiar caja
                txtContraAct.Text = "";
                txtContraAct.Focus();
                return;
            }
            //Validar que haya confirmado bien la contraseña
            if (txtNuevaContra.Text != txtConfirmContra.Text)
            {
                MessageBox.Show("Favor de confirmar bien su contraseña");
                return;
            }

            #endregion
            try
            {
                Usuario queryCambiarContra =
                    (from ord in dcDatos.Usuario
                     where ord.usu_ID == objUser.usu_ID
                     select ord).SingleOrDefault();

                queryCambiarContra.usu_Password = txtNuevaContra.Text;
                dcDatos.SubmitChanges();
                MessageBox.Show("Nueva Contraseñan guardada");
            }
            catch (ChangeConflictException)
            {
                foreach (ObjectChangeConflict occ in dcDatos.ChangeConflicts)
                {
                    // All database values overwrite current values.
                    occ.Resolve(RefreshMode.OverwriteCurrentValues);
                    MessageBox.Show("Contraseña modificada por otro usuario");
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
            //limpiar cajas
            txtContraAct.Text = "";
            txtNuevaContra.Text = "";
            txtConfirmContra.Text = "";
        }

        protected void cmbAsignar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbAsignar.SelectedValue == "5")
            {
                cmbArea.Enabled = true;
                cmbEquipo.Enabled = true;
            }
            else
            {
                cmbArea.Enabled = false;
                cmbEquipo.Enabled = false;
            }
        }

        protected void cmbArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Data Source=tcp:192.168.123.6,1433;Initial Catalog=GAB_Irapuato;Persist Security Info=True;User ID=sa;Password=Gabira2026$");
            SqlCommand cmd = new SqlCommand("select nom_equipo from tb_man_cat_equipos where area_equipo ='" + cmbArea.SelectedValue + "' ORDER BY nom_equipo", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            cmbEquipo.DataSource = ds;
            cmbEquipo.DataTextField = "nom_equipo";
            cmbEquipo.DataValueField = "nom_equipo";
            cmbEquipo.DataBind();
        }

        protected void dgFinalizados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(objUser.per_ID, 0);

            dgFinalizados.PageIndex = e.NewPageIndex;

            dgFinalizados.DataSource = consulta3;
            dgFinalizados.DataBind();
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
