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
                    lblUsuario.Text = objUser.Persona.Per_ID.ToString();
                    lbNombre.Text = objUser.Persona.Per_Nombre + " " + objUser.Persona.Per_ApePat + " " + objUser.Persona.Per_ApeMat;
                    LbEmail.Text = objUser.Persona.Per_Email;
                    LbTele.Text = objUser.Persona.Per_ExtTelefono;

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
                    var consultaAsignarA = from d in dcDatos.Departamentos
                                           where d.Dep_AtiendeServicios == true
                                           select new
                                           {
                                               ID = d.Dep_ID,
                                               Departamento = d.Dep_Departamento
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


            var consultaNewID = from row in dcDatos.Servicios
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.Ser_ID)
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

                var consultaNewID = from row in dcDatos.Servicios
                                    group row by true into s
                                    select new
                                    {
                                        newID = s.Max(id => id.Ser_ID)
                                    };
                try
                {
                    if (consultaNewID.First() != null)
                        objServ.Ser_ID = consultaNewID.First().newID + 1;
                    else
                        objServ.Ser_ID = 1;
                }
                catch
                {
                    objServ.Ser_ID = 1;
                }


                objServ.Sere_ID = (int)enumServicioEstado.Solicitado;
                objServ.Per_ID_Levanto = objUser.Persona.Per_ID; //este dato lo obtienes de la variable de sesion del usuario logueado
                objServ.Ser_Incidente = txtIncidente.Text;
                if (cmbAsignar.SelectedValue == "5")
                {
                    objServ.Ser_Area = cmbArea.SelectedValue;
                    objServ.Ser_Equipo = cmbEquipo.SelectedValue;
                }

                // Call a helper method routine to save the file.
                if (FileUploadFoto.HasFile)
                {
                    SaveFile(FileUploadFoto.PostedFile);
                    //objServ.Ser_Num_Fotos = uploadedFiles.Count;
                }

                objServ.Ser_FechaIngreso = DateTime.Now;
                objServ.Ser_FechaUltimoE = objServ.Ser_FechaIngreso;
                objServ.Ser_DeptoQueAtiende = int.Parse(cmbAsignar.SelectedValue);
                EnviarCorreo();

                dcDatos.Servicios.InsertOnSubmit(objServ);
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

            var consultaNewID = from row in dcDatos.Servicios
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.Ser_ID)
                                };
            try
            {
                if (consultaNewID.First() != null)
                    objServ.Ser_ID = consultaNewID.First().newID + 1;
                else
                    objServ.Ser_ID = 1;
            }
            catch
            {
                objServ.Ser_ID = 1;
            }


            Persona persona = this.dcDatos.Personas.Where<Persona>((Expression<Func<Persona, bool>>)(p => p.Dep_ID == int.Parse(this.cmbAsignar.SelectedValue))).First<Persona>();
            MailMessage message = new MailMessage();
            //message.To.Add(persona.Per_Email);
            message.Subject = "Sistema de Tickets";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            if (this.objUser.Persona.Per_copia != "" && this.objUser.Persona.Per_copia != null)
            {
                message.CC.Add(this.objUser.Persona.Per_copia);
            }
            /*if (this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat == "Materia Prima")
            {
                message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "Vigilancia")
            {
                message.CC.Add("jcgarcia@mrlucky.com.mx");
            }


            if (this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + " " + this.objUser.Persona.Per_ApeMat == "JOSE MANUEL PRIETO RANGEL" || this.objUser.Persona.Per_Nombre.Trim() + " " + this.objUser.Persona.Per_ApePat.Trim() + " " + this.objUser.Persona.Per_ApeMat.Trim() == "Jose Manuel Prieto Rangel")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, aaleman@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + " " + this.objUser.Persona.Per_ApeMat == "HECTOR GUSTAVO CAMPA ALVARADO" || this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + " " + this.objUser.Persona.Per_ApeMat == "Hector Gustavo Campa Alvarado")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, agarcia@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "ensaladas")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, aaleman@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "fresco")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx, agarcia@mrlucky.com.mx");
            }
            */

            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "SISTEMAS")
                message.To.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, jgalvan@mrlucky.com.mx, elizabeth@mrlucky.com.mx");
            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "MANTENIMIENTO")
                message.To.Add("mantenimiento@mrlucky.com.mx, aldosoto@mrlucky.com.mx, admin.mtto@mrlucky.com.mx");
            string str = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + objServ.Ser_ID.ToString() + "</td></tr><tr><td>Reporto: </td><td>" + this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + "</td></tr><tr><td>Descripcion: </td><td>" + this.txtIncidente.Text + "</td></tr><tr><td>Liga local: </td><td>http://192.168.123.4:81/Tickets2/Administrador.aspx</td></tr><tr><td>Liga Internet: </td><td>http://189.206.160.206:81/Tickets2/Administrador.aspx</td></tr></table>";
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
                Servicio objSerValida = (from s in dcDatos.Servicios
                                         where s.Ser_ID == ID_Servicio_Comentario
                                         select s).SingleOrDefault();
                if (objSerValida != null)
                {
                    if (objSerValida.Sere_ID == (int)enumServicioEstado.Solicitado)
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

                if (objSerValida.Per_ID_Levanto != objUser.Persona.Per_ID)
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
                        from row in dcDatos.Comentarios
                        group row by true into s
                        select new
                        {
                            newID = s.Max(id => id.Com_ID)
                        };
                if (queryComentarUsu.First() != null)
                    objComen.Com_ID = queryComentarUsu.First().newID + 1;
                else
                    objComen.Com_ID = 1;

                objComen.Ser_ID = ID_Servicio_Comentario;
                objComen.Com_Comentario = txtComentarioUsuario.Text;
                objComen.Com_FechaCom = DateTime.Now;
                objComen.Per_ID = objUser.Per_ID;

                dcDatos.Comentarios.InsertOnSubmit(objComen);
                dcDatos.SubmitChanges();
                CargarGrids();
                MessageBox.Show("Comentario ingresado correctamente.");
                EnviarCorreoComentario(Convert.ToString(objSerValida.Ser_Incidente), Convert.ToString(objSerValida.Ser_Nombre_Atiende));

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

            var consultaNewID = from row in dcDatos.Servicios
                                group row by true into s
                                select new
                                {
                                    newID = s.Max(id => id.Ser_ID)
                                };
            try
            {
                if (consultaNewID.First() != null)
                    objServ.Ser_ID = consultaNewID.First().newID + 1;
                else
                    objServ.Ser_ID = 1;
            }
            catch
            {
                objServ.Ser_ID = 1;
            }


            Persona persona = this.dcDatos.Personas.Where<Persona>((Expression<Func<Persona, bool>>)(p => p.Dep_ID == int.Parse(this.cmbAsignar.SelectedValue))).First<Persona>();
            MailMessage message = new MailMessage();
            //message.To.Add(persona.Per_Email);
            message.Subject = "Sistema de Tickets - Respuesta Comentario";
            message.SubjectEncoding = Encoding.UTF8;
            //message.Bcc.Add("ahernandez@mrlucky.com.mx");
            if (this.objUser.Persona.Per_copia != "" && this.objUser.Persona.Per_copia != null)
            {
                message.CC.Add(this.objUser.Persona.Per_copia);
            }
            /*if (this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat == "Materia Prima")
            {
                message.CC.Add("fjcastrejon@mrlucky.com.mx, cmoreno@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "Vigilancia")
            {
                message.CC.Add("jcgarcia@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre.Trim() + " " + this.objUser.Persona.Per_ApePat.Trim() + " " + this.objUser.Persona.Per_ApeMat.Trim() == "JOSE MANUEL PRIETO RANGEL" || this.objUser.Persona.Per_Nombre.Trim() + " " + this.objUser.Persona.Per_ApePat.Trim() + " " + this.objUser.Persona.Per_ApeMat.Trim() == "Jose Manuel Prieto Rangel")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + " " + this.objUser.Persona.Per_ApeMat == "HECTOR GUSTAVO CAMPA ALVARADO"  || this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + " " + this.objUser.Persona.Per_ApeMat == "Hector Gustavo Campa Alvarado")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "ensaladas")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }

            if (this.objUser.Persona.Per_Nombre == "fresco")
            {
                message.CC.Add("almacen@mrlucky.com.mx, pgonzalez@mrlucky.com.mx");
            }*/

            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "SISTEMAS")
                message.To.Add("sistemas@mrlucky.com.mx, ricardo.cortes@mrlucky.com.mx, jgalvan@mrlucky.com.mx, elizabeth@mrlucky.com.mx");
            if (this.cmbAsignar.SelectedItem.ToString().Trim() == "MANTENIMIENTO")
                message.To.Add("mantenimiento@mrlucky.com.mx, aldosoto@mrlucky.com.mx, admin.mtto@mrlucky.com.mx");
            string str = "<table border='1' width='400px'><tr><td colspan='2'><h3>Sistema de Tickets</h3></td></tr><tr><td>No. de ticket: </td><td>" + txtIdServicioUsuario.Text.ToString() + "</td></tr><tr><td>Reporto: </td><td>" + this.objUser.Persona.Per_Nombre + " " + this.objUser.Persona.Per_ApePat + "</td></tr><tr><td>Descripcion: </td><td>" + incidencia + "</td></tr></tr><tr><td>Servicio Atendido Por: </td><td>" + atiende + "</td></tr></tr><tr><td>Comentario: </td><td>" + this.txtComentarioUsuario.Text + "</td></tr></table>";
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
            var consulta1 = from s in dcDatos.Servicios
                            join pl in dcDatos.Personas on s.Per_ID_Levanto equals pl.Per_ID
                            join dep in dcDatos.Departamentos on s.Ser_DeptoQueAtiende equals dep.Dep_ID
                            where s.Sere_ID == (int)enumServicioEstado.Solicitado && pl.Per_ID == objUser.Persona.Per_ID
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
            var consulta2 = dcDatos.sp_Get_ServiciosAsignados(objUser.Per_ID, 0);

            dgAbiertos.DataSource = consulta2;
            dgAbiertos.DataBind();

            //----------------------------------------------------------------------------------
            //                  FINALIZADOS
            //----------------------------------------------------------------------------------

            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(objUser.Per_ID, 0);
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
            Usuario objUsuValida = (from s in dcDatos.Usuarios
                                    where s.Usu_ID == objUser.Usu_ID
                                    select s).SingleOrDefault();
            if (objUsuValida.Usu_Password != txtContraAct.Text)
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
                    (from ord in dcDatos.Usuarios
                     where ord.Usu_ID == objUser.Usu_ID
                     select ord).SingleOrDefault();

                queryCambiarContra.Usu_Password = txtNuevaContra.Text;
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
            var consulta3 = dcDatos.sp_Get_ServiciosFinalizados(objUser.Per_ID, 0);

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
