using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Datos;

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
                var consulta = from u in dcDatos.Usuario
                               join p in dcDatos.Persona on u.per_ID equals p.per_ID
                               join t in dcDatos.Trabajador on p.per_ID equals t.per_ID
                               where u.usu_Usuario == txtUsuario.Text
                                    && u.usu_Password == txtPass.Text
                                    && p.per_IsActivo == true
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
                var consulta = from u in dcDatos.Usuario
                               join p in dcDatos.Persona on u.per_ID equals p.per_ID
                               join t in dcDatos.Administrador on p.per_ID equals t.per_ID
                               where u.usu_Usuario == txtUsuario.Text
                                    && u.usu_Password == txtPass.Text
                                    && p.dep_ID == 1
                                    && p.per_IsActivo == true
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
                var consulta = from u in dcDatos.Usuario
                               join p in dcDatos.Persona on u.per_ID equals p.per_ID
                               join t in dcDatos.Administrador on p.per_ID equals t.per_ID
                               where u.usu_Usuario == txtUsuario.Text
                                    && u.usu_Password == txtPass.Text
                                    && p.dep_ID == 5
                                    && p.per_IsActivo == true
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