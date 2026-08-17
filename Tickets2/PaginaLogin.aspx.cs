using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Datos; // Asegúrese de que la siguiente directiva using esté presente
// y que el tipo dcTicketsDataContext exista en el espacio de nombres Datos.

namespace Tickets2
{
    public partial class PaginaLogin : System.Web.UI.Page
    {
        dcTicketsDataContext dcDatos;

        protected void Page_Load(object sender, EventArgs e)
        {
            dcDatos = new dcTicketsDataContext();
            Session["objUser"] = null;
            Session["objAdmin"] = null;
            Session["objAdminMan"] = null;
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            if (cmbRol.SelectedValue == "user") //Trabajador
            {
                var consulta = from u in dcDatos.Usuarios
                               join p in dcDatos.Personas on u.Per_ID equals p.Per_ID
                               join t in dcDatos.Trabajadors on p.Per_ID equals t.Per_ID
                               where u.Usu_Usuario == txtUsuario.Text
                                    && u.Usu_Password == txtPass.Text
                                    && p.Per_IsActivo == true
                               select u;

                if (consulta != null)
                {
                    if (consulta.Count() > 0)
                    {
                        Session["objUser"] = consulta.First();
                        Response.Redirect("Usuario.aspx");
                    }
                    else
                    {
                        MessageBox.Show("Su usuario y/o contraseña no son validos.");
                    }
                }
                else
                {
                    MessageBox.Show("Su usuario y/o contraseña no son validos.");
                }

            }
            else if (cmbRol.SelectedValue == "adminsis")
            {
                var consulta = from u in dcDatos.Usuarios
                               join p in dcDatos.Personas on u.Per_ID equals p.Per_ID
                               join t in dcDatos.Administradors on p.Per_ID equals t.Per_ID
                               where u.Usu_Usuario == txtUsuario.Text
                                    && u.Usu_Password == txtPass.Text
                                    && p.Dep_ID == 1
                                    && p.Per_IsActivo == true
                               select u;

                if (consulta != null)
                {
                    if (consulta.Count() > 0)
                    {
                        Session["objAdmin"] = consulta.First();
                        Response.Redirect("Administrador.aspx");
                    }
                    else
                    {
                        MessageBox.Show("Su usuario y/o contraseña no son validos.");
                    }
                }
                else
                {
                    MessageBox.Show("Su usuario y/o contraseña no son validos.");
                }
            }
            else if (cmbRol.SelectedValue == "adminman")
            {
                var consulta = from u in dcDatos.Usuarios
                               join p in dcDatos.Personas on u.Per_ID equals p.Per_ID
                               join t in dcDatos.Administradors on p.Per_ID equals t.Per_ID
                               where u.Usu_Usuario == txtUsuario.Text
                                    && u.Usu_Password == txtPass.Text
                                    && p.Dep_ID == 5
                                    && p.Per_IsActivo == true
                               select u;

                if (consulta != null)
                {
                    if (consulta.Count() > 0)
                    {
                        Session["objAdminMan"] = consulta.First();
                        Response.Redirect("AdminManto.aspx");
                    }
                    else
                    {
                        MessageBox.Show("Su usuario y/o contraseña no son validos.");
                    }
                }
                else
                {
                    MessageBox.Show("Su usuario y/o contraseña no son validos.");
                }
            }
        }
    }
}