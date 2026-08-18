<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="Tickets2.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador de Tickets Sistema</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="css/bootstrap.min2.css" rel="stylesheet" />
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="js/fileinput.js" type="text/javascript"></script>
    <script src="js/bootstrap.min2.js" type="text/javascript"></script>
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/FormContactos.css" />
    <link rel="stylesheet" href="css/PaginacionGrid.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.24.0/moment.min.js"></script>
    <script src="js/fancyTable.js"></script>
    <script type="text/javascript">
        // Word genarator
        function rWord(r) { var t, n = "bcdfghjklmnpqrstvwxyz", a = "aeiou", e = function (r) { return Math.floor(Math.random() * r) }, o = ""; r = parseInt(r, 10), n = n.split(""), a = a.split(""); for (t = 0; t < r / 2; t++) { var l = n[e(n.length)], p = a[e(a.length)]; o += 0 === t ? l.toUpperCase() : l, o += 2 * t < r - 1 ? p : "" } return o }

        $(document).ready(function () {

            var fancyTableA = $("#dgFinalizadosxis").fancyTable({
                pagination: true,
                perPage: 15,
                globalSearch: true
            });

        });
    </script>



    <link rel="stylesheet" href="css/bootstrap-datetimepicker.css" />
    <script src="js/moment.js" type="text/javascript"></script>
    <script src="js/bootstrap-datetimepicker.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#tablas a[href="' + activeTab + '"]').tab('show');
            }
        });

        $(function () {
            $('#datetimepicker4').datetimepicker({
                locale: 'es'
            });
        });

        $(document).on("click", "[id*=lnkView]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#foto11").attr('src', 'FotosManto/' + folio + '1.jpg');
            $("#foto12").attr('src', 'FotosManto/' + folio + '2.jpg');
            $("#foto13").attr('src', 'FotosManto/' + folio + '3.jpg');
            $("#foto14").attr('src', 'FotosManto/' + folio + '4.jpg');
            $("#foto15").attr('src', 'FotosManto/' + folio + '5.jpg');
        });

        $(document).on("click", "[id*=lnkView2]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#Img1").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
            $("#Img2").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
            $("#Img3").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
            $("#Img4").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
            $("#Img5").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');
        });

    </script>
    <style type="text/css">
        .table-striped > tbody > tr:nth-child(odd), .table-striped > tbody > tr:nth-child(odd) {
            background-color: #bfd8eb;
        }

        .table-hover > tbody > tr:hover {
            background-color: #9fb8cb;
        }

        /* Estilos mejorados para la card y la tabla */
        .card-modern {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            background: #ffffff;
        }

            .card-modern .card-header-custom {
                background: linear-gradient(135deg, #1e3a5f 0%, #2a4d7a 100%);
                color: #ffffff;
                border-radius: 12px 12px 0 0;
                padding: 1.2rem 1.5rem;
                border-bottom: none;
            }

                .card-modern .card-header-custom h5 {
                    margin: 0;
                    font-weight: 600;
                    font-size: 1.3rem;
                    letter-spacing: 0.5px;
                }

                .card-modern .card-header-custom small {
                    color: #cbd5e0;
                    font-weight: 300;
                }

            .card-modern .table-responsive {
                padding: 0 15px 15px 15px;
            }

        /* Tabla */
        .table-modern {
            width: 100%;
            table-layout: fixed;
            word-wrap: break-word;
            background: #fff;
        }

            .table-modern thead th {
                background-color: #f8fafc;
                color: #2c3e50;
                font-weight: 600;
                border-bottom: 2px solid #dee2e6;
                padding: 12px 8px;
                text-align: left;
                vertical-align: middle;
                white-space: normal;
            }

            .table-modern tbody td {
                padding: 10px 8px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
                white-space: normal;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .table-modern tbody tr:hover {
                background-color: #e9f2fa;
            }

        /* Columna ID */
        .col-id {
            width: 5%;
        }

        .col-nombre {
            width: 12%;
        }

        .col-incidente {
            width: 13%;
        }

        .col-comentarios {
            width: 15%;
        }

        .col-asignado {
            width: 10%;
        }

        .col-estado {
            width: 8%;
        }

        .col-fechaingreso {
            width: 10%;
        }

        .col-ultimoestado {
            width: 10%;
        }

        .col-duracion {
            width: 7%;
        }

        .col-cumplimiento {
            width: 12%;
        }

        .col-evidencia {
            width: 10%;
        }

        /* Badge para estado Finalizado */
        .badge-finalizado {
            background-color: #28a745;
            color: #fff;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Iconos de cumplimiento */
        .cumplimiento-icon {
            font-size: 1.5rem;
            color: #f39c12;
        }

            .cumplimiento-icon.fa-grin-alt {
                color: #28a745;
            }

            .cumplimiento-icon.fa-meh {
                color: #f39c12;
            }

            .cumplimiento-icon.fa-sad-cry {
                color: #e74c3c;
            }

        /* Botones de evidencia */
        .btn-evidencia {
            border-radius: 20px;
            padding: 3px 10px;
            font-size: 0.8rem;
            transition: all 0.2s;
        }

            .btn-evidencia:hover {
                transform: translateY(-1px);
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
    </style>
</head>
<body>
    <form runat="server">
        <div class="container col-xs-0 col-sm-0 col-md-0 col-lg-1">
        </div>
        <div class="container col-xs-12 col-sm-12 col-md-12 col-lg-10">
            <div class="row">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center>
                        <img src="MrLucky.jpeg" class="img-responsive img-circle" alt="mrlucky" /></center>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <center>
                        <h1>Administrador de Tickets de Sistemas</h1>
                    </center>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center>
                        <img src="gab.jpg" class="img-responsive" alt="mrlucky" /></center>
                </div>
            </div>
            <br />
            <ul class="nav nav-tabs" id="tablas">
                <li class="active"><a href="#sis" data-toggle="tab">Servicios Sistemas <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></a></li>
                <li><a href="#reg" data-toggle="tab">Registrar Usuarios <span class="glyphicon glyphicon-user" aria-hidden="true"></span></a></li>
                <li><a href="Administrador.aspx" class="btn btn-success">Refrescar <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a></li>
                <li>
                    <asp:LinkButton ID="btnSalir" runat="server" CssClass="btn btn-primary"
                        Text="Salir <span class='glyphicon glyphicon-log-out'></span>"
                        OnClick="btnSalir_Click" />
                </li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade" id="reg">
                    <h2>Registrar Usuario</h2>
                    <center>
                        <div class="ibody">
                            <div class="jumbotron">
                                <h1>Registro</h1>
                            </div>
                            <div class="fcontacto">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3>Datos de la persona</h3>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Nombre:</label>
                                        <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                                        <label>Apellido Paterno:</label>
                                        <asp:TextBox runat="server" ID="txtApellidoP" CssClass="form-control" placeholder="ApellidoP"></asp:TextBox>
                                        <label>Apellido Materno:</label>
                                        <asp:TextBox runat="server" ID="txtApellidoM" CssClass="form-control" placeholder="ApellidoM"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label>E-mail:</label>
                                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="E-mail"></asp:TextBox>
                                        <label>Telefono Ext:</label>
                                        <asp:TextBox runat="server" ID="txtTele" CssClass="form-control" placeholder="Telefono"></asp:TextBox>
                                        <label>Departamento:</label>
                                        <asp:DropDownList ID="cmbDepto" runat="server" AutoPostBack="false" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-12">
                                        <h3>Datos del usuario</h3>
                                    </div>
                                    <div class="col-md-6">
                                        <label>Nombre del Usuario:</label>
                                        <asp:TextBox runat="server" ID="txtNombreUsuario" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                                        <label>Rol:</label>
                                        <asp:DropDownList ID="cmbRol" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="cmbUsuario" Text="Usuario" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="cmbAdministrador" Text="Administrador"></asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:LinkButton ID="BtnRegistro" runat="server" CssClass="btn btn-primary"
                                            Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="BtnRegistro_Click" />
                                    </div>
                                    <div class="col-md-6">
                                        <label>Contraseña:</label>
                                        <asp:TextBox runat="server" ID="txtPasswordUsuario" CssClass="form-control" placeholder="Contraseña"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                    </center>
                </div>
                <div class="tab-pane fade in active " id="sis">
                    <h3>Servicios Solicitados</h3>
                    <asp:GridView runat="server" ID="dgSolicitados" CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso"></asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <asp:BoundField HeaderText="Solicitado A" DataField="Asignado_A"></asp:BoundField>
                            <%--<asp:BoundField HeaderText="Area" DataField="Area"></asp:BoundField>
                            <asp:BoundField HeaderText="Equipo" DataField="Equipo"></asp:BoundField>--%>
                            <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                            <asp:BoundField HeaderText="Estado" DataField="Estado"></asp:BoundField>
                            <asp:TemplateField HeaderText="Foto">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkView" CssClass="btn btn-primary" Text="Foto" runat="server"
                                        data-toggle="modal" data-target="#myModal">
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">


                                        <ol class="carousel-indicators">
                                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                                            <li data-target="#carousel-example-generic" data-slide-to="4"></li>
                                        </ol>


                                        <div class="carousel-inner">
                                            <div class="item active">
                                                <center>
                                                    <img class="img-responsive" id="foto11" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto12" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto13" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto14" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto15" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                        </div>


                                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                            <span class="glyphicon glyphicon-chevron-left"></span>
                                        </a>
                                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                            <span class="glyphicon glyphicon-chevron-right"></span>
                                        </a>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="modal fade bs-example-modal-lg" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="H1">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carousel-example-generic2" class="carousel slide" data-ride="carousel" data-interval="false">


                                        <ol class="carousel-indicators">
                                            <li data-target="#carousel-example-generic2" data-slide-to="0" class="active"></li>
                                            <li data-target="#carousel-example-generic2" data-slide-to="1"></li>
                                            <li data-target="#carousel-example-generic2" data-slide-to="2"></li>
                                            <li data-target="#carousel-example-generic2" data-slide-to="3"></li>
                                            <li data-target="#carousel-example-generic2" data-slide-to="4"></li>
                                        </ol>


                                        <div class="carousel-inner">
                                            <div class="item active">
                                                <center>
                                                    <img class="img-responsive" id="Img1" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img2" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img3" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img4" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img5" src=""></center>
                                                <div class="carousel-caption">
                                                </div>
                                            </div>
                                        </div>


                                        <a class="left carousel-control" href="#carousel-example-generic2" role="button" data-slide="prev">
                                            <span class="glyphicon glyphicon-chevron-left"></span>
                                        </a>
                                        <a class="right carousel-control" href="#carousel-example-generic2" role="button" data-slide="next">
                                            <span class="glyphicon glyphicon-chevron-right"></span>
                                        </a>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr />
                    <h3>Asignar resposable y fecha estimada de finalización del servicio</h3>
                    <div class="row">
                        <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <label>Id del Servicio: </label>
                            <asp:TextBox runat="server" ID="txtIdServicioResponsableSis" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                            <label>Responsable del servicio: </label>
                            <asp:DropDownList ID="cmbResponsableServicioSis" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3">
                            <label>Fecha estimada de finalización: </label>
                            <asp:TextBox ID='datetimepicker4' runat="server" type="text" CssClass="form-control" />
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <asp:LinkButton ID="btnAsignarServicioSis" runat="server" CssClass="btn btn-primary"
                                Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="btnAsignarServicioSis_Click" />
                        </div>
                    </div>
                    <hr />
                    <h3>Agregar Comentario</h3>
                    <div class="row">
                        <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <label>Id del Servicio: </label>
                            <asp:TextBox runat="server" ID="txtIdServicioSis" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <label>Comentar: </label>
                            <asp:TextBox ID="txtComentarioSis" runat="server" CssClass="form-control" Rows="2" TextMode="multiline" placeholder="Comentario">
                            </asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <br />
                            <asp:LinkButton ID="btnComentarioSis" runat="server" CssClass="btn btn-primary"
                                Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="btnComentarioSis_Click" />
                        </div>
                    </div>
                    <hr />
                    <h3>Agregar foto de servicio finalizado</h3>
                    <div class="row">
                        <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <label>Id del Servicio: </label>
                            <asp:TextBox runat="server" ID="idserviciofotos" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                            <label>Fotos: </label>
                            <div class="form-group">
                                <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="file" multiple="multiple" data-show-upload="false" data-show-caption="true" />
                            </div>
                        </div>
                        <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <asp:LinkButton ID="btnfotofin" runat="server" CssClass="btn btn-primary"
                                Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="btnfotofin_Click" />
                        </div>
                    </div>
                    <hr />
                    <h3>Finalizar Servicio</h3>
                    <div class="row">
                        <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <label>Id del Servicio: </label>
                            <asp:TextBox runat="server" ID="txtIdServicioFinSis" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <asp:LinkButton ID="BtnServicioFinSis" runat="server" CssClass="btn btn-primary"
                                Text="Finalizar <span class='glyphicon glyphicon-ok'></span>" OnClick="BtnServicioFinSis_Click" />
                        </div>
                    </div>
                    <h2>Servicios Asignados a Sistemas </h2>
                    <asp:GridView runat="server" ID="dgAbiertosSis" CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID">
                                <ItemStyle CssClass="ID"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <%--<asp:BoundField HeaderText="Area" DataField="Area"></asp:BoundField>
                            <asp:BoundField HeaderText="Equipo" DataField="Equipo"></asp:BoundField>--%>
                            <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                            <asp:BoundField HeaderText="Comentarios" DataField="Comentarios"></asp:BoundField>
                            <asp:BoundField HeaderText="Responsable" DataField="Asignado_A"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha Estimada Fin" DataField="Fecha_Estimada_Fin"></asp:BoundField>
                            <asp:TemplateField HeaderText="Foto">
                                <ItemTemplate>
                                    <center>
                                        <asp:LinkButton ID="lnkView" CssClass="btn btn-primary" Text="Antes" runat="server"
                                            data-toggle="modal" data-target="#myModal">
                                        </asp:LinkButton>
                                    </center>
                                    <br />
                                    <center>
                                        <asp:LinkButton ID="lnkView2" CssClass="btn btn-primary" Text="Despues" runat="server"
                                            data-toggle="modal" data-target="#myModal2">
                                        </asp:LinkButton>
                                    </center>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings Mode="NextPreviousFirstLast" />
                    </asp:GridView>
                    <hr />
                    <h2>Servicios Finalizados de Sistemas </h2>

                    <!-- ==================== SERVICIOS FINALIZADOS ==================== -->
                    <div class="card-modern">
                        <div class="card-header-custom">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5><i class="fas fa-check-double me-2"></i>Servicios Finalizados de Sistemas</h5>
                                    <small><i class="fas fa-info-circle me-1"></i>Consulta de servicios concluidos</small>
                                </div>
                                <div>
                                    <span class="badge badge-light" style="background: rgba(255,255,255,0.2);">
                                        <i class="fas fa-list-ol me-1"></i>Total: <%= dgFinalizadosxis.Rows.Count %>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <asp:GridView
                                runat="server"
                                ID="dgFinalizadosxis"
                                CssClass="table table-hover table-modern mb-0"
                                AutoGenerateColumns="false"
                                EmptyDataText="No hay servicios finalizados"
                                ShowHeaderWhenEmpty="true"
                                OnPageIndexChanging="dgFinalizadosSis_PageIndexChanging"
                                GridLines="None">

                                <HeaderStyle CssClass="table-header" />

                                <Columns>

                                    <asp:BoundField
                                        HeaderText="ID"
                                        DataField="ID">
                                        <ItemStyle CssClass="text-center fw-semibold text-muted col-id" />
                                        <HeaderStyle CssClass="text-center col-id" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Nombre"
                                        DataField="Nombre">
                                        <ItemStyle CssClass="fw-semibold col-nombre" />
                                        <HeaderStyle CssClass="col-nombre" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Incidente"
                                        DataField="Incidente">
                                        <ItemStyle CssClass="text-wrap col-incidente" />
                                        <HeaderStyle CssClass="col-incidente" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Comentarios"
                                        DataField="Comentarios">
                                        <ItemStyle CssClass="text-wrap comentarios-column col-comentarios" />
                                        <HeaderStyle CssClass="col-comentarios" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Asignado a"
                                        DataField="Asignado_A">
                                        <ItemStyle CssClass="col-asignado" />
                                        <HeaderStyle CssClass="col-asignado" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Estado">
                                        <HeaderStyle CssClass="text-center col-estado" />
                                        <ItemStyle CssClass="text-center col-estado" />
                                        <ItemTemplate>
                                            <span class="badge-finalizado">
                                                <i class="fas fa-check-circle me-1"></i><%# Eval("Estado") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField
                                        HeaderText="Fecha de ingreso"
                                        DataField="Fecha_de_Ingreso">
                                        <ItemStyle CssClass="text-nowrap col-fechaingreso" />
                                        <HeaderStyle CssClass="col-fechaingreso" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Último estado"
                                        DataField="Fecha_de_último_Estado">
                                        <ItemStyle CssClass="text-nowrap col-ultimoestado" />
                                        <HeaderStyle CssClass="col-ultimoestado" />
                                    </asp:BoundField>

                                    <asp:BoundField
                                        HeaderText="Duración"
                                        DataField="Duración">
                                        <ItemStyle CssClass="text-center text-nowrap col-duracion" />
                                        <HeaderStyle CssClass="col-duracion" />
                                    </asp:BoundField>

                                    <asp:TemplateField HeaderText="Cumplimiento y Calidad">
                                        <HeaderStyle CssClass="text-center col-cumplimiento" />
                                        <ItemStyle CssClass="text-center col-cumplimiento" />
                                        <ItemTemplate>
                                            <i class='<%# Eval("CumplimientoCalidad") %> cumplimiento-icon'
                                                data-toggle="tooltip"
                                                title="Evaluación del servicio"></i>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Evidencia">
                                        <HeaderStyle CssClass="text-center col-evidencia" />
                                        <ItemStyle CssClass="text-center col-evidencia" />
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <asp:LinkButton
                                                    ID="lnkView"
                                                    runat="server"
                                                    CssClass="btn btn-outline-primary btn-evidencia"
                                                    ToolTip="Ver fotografía antes del servicio"
                                                    data-toggle="modal"
                                                    data-target="#myModal">
                                <i class="glyphicon glyphicon-camera"></i> Antes
                                                </asp:LinkButton>
                                                <asp:LinkButton
                                                    ID="lnkView2"
                                                    runat="server"
                                                    CssClass="btn btn-outline-success btn-evidencia"
                                                    ToolTip="Ver fotografía después del servicio"
                                                    data-toggle="modal"
                                                    data-target="#myModal2">
                                <i class="glyphicon glyphicon-picture"></i> Después
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>
                        </div>
                    </div>

                </div>
            </div>
    </form>
</body>
</html>
