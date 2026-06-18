<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaginaLogin.aspx.cs" Inherits="Tickets2.PaginaLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tickets Login</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-2.1.3.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/formLogin.css" />

    <style>
        body {
            background:url("fondo.jpg") no-repeat center center fixed; 
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
        div[class="col-xs-12 col-sm-5 col-md-5 col-lg-5"] h1{
            margin-top: 180px;
            font-size: 60px;

            word-wrap: break-word;
            -webkit-hyphens: auto;
            -moz-hyphens: auto;
            -ms-hyphens: auto;
            -o-hyphens: auto;
            hyphens: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="row">
	            <div class="col-xs-12 col-sm-5 col-md-5 col-lg-5">
                    <h1>Sistema de Tickets</h1>
                    <center><a href="MonitorTickets.aspx" class="btn btn-primary btn-lg">Soporte TI <span class="glyphicon glyphicon-cog" aria-hidden="true"></span></a></center>
	            </div>
	            <div class="col-xs-12 col-sm-7 col-md-7 col-lg-7">
		            <div class="login">
			            <div class="container loginbox">
            	            <form id="fLogin" runat="server">
	                            <h1>Ingresar.</h1>
	                            <p>Usuario:</p>
                                <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
	                            <br/><p>Contraseña:</p>
                                <asp:TextBox runat="server" ID="txtPass" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                <br/><p>Rol:</p>
                                <asp:DropDownList ID="cmbRol" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="user" Text="Usuario" Selected="True">Usuario</asp:ListItem>
                                    <asp:ListItem Value="adminsis" Text="Administrador Sistemas"></asp:ListItem>
                                    <asp:ListItem Value="adminman" Text="Administrador Mantenimiento"></asp:ListItem>
                                </asp:DropDownList>
                                <br />
                                <asp:LinkButton runat="server" ID="btnLogIn" Text="Entrar <span class='glyphicon glyphicon-log-in'></span>" CssClass="btn btn-primary btn-lg btn-block" OnClick="btnLogIn_Click"/>
            	            </form>
        	            </div>
		            </div>
	            </div>
	        </div> 
        </header>
    </div>
</body>
</html>
