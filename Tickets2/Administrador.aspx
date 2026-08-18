<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="Tickets2.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador de Tickets Sistema</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- CSS local (mantén tus archivos) -->
    <link href="css/bootstrap.min2.css" rel="stylesheet" />
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/FormContactos.css" />
    <link rel="stylesheet" href="css/PaginacionGrid.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <!-- JS: una sola versión de jQuery (2.1.3 local) y Bootstrap -->
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/fileinput.js" type="text/javascript"></script>
    <script src="js/moment.js" type="text/javascript"></script>
    <script src="js/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="js/fancyTable.js"></script>

    <style type="text/css">
        /* ============================================
   Estilos generales
   ============================================ */
        .table-striped > tbody > tr:nth-child(odd) {
            background-color: #f8f9fa;
        }

        .table-hover > tbody > tr:hover {
            background-color: #e8f4fc;
            transition: background-color 0.2s ease;
        }

        /* ============================================
   Tabla de finalizados
   ============================================ */
        .tabla-finalizados {
            font-size: 13px;
            width: 100%;
            table-layout: fixed;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 8px;
            overflow: hidden;
        }

            /* Encabezados con gradiente */
            .tabla-finalizados thead th {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
                background-color: #667eea !important;
                color: #ffffff !important;
                font-weight: 600 !important;
                font-size: 11px !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px;
                padding: 14px 8px !important;
                border: none !important;
                white-space: nowrap;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                vertical-align: middle !important;
            }

            /* Filas de datos */
            .tabla-finalizados tbody td {
                padding: 11px 10px;
                vertical-align: middle;
                word-wrap: break-word;
                border-bottom: 1px solid #e9ecef;
                font-size: 12px;
                line-height: 1.5;
            }

            /* Colores alternados y hover */
            .tabla-finalizados tbody tr:nth-child(odd) {
                background-color: #ffffff;
            }

            .tabla-finalizados tbody tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            .tabla-finalizados tbody tr:hover {
                background-color: #e8f4fc;
                transition: background-color 0.2s ease;
            }

        /* ============================================
   Anchuras de columnas
   ============================================ */
        .col-id {
            width: 55px;
            text-align: center;
        }

        .col-nombre {
            width: 120px;
        }

        .col-incidente {
            width: 150px;
        }

        .col-comentarios {
            width: 180px;
        }

        .col-asignado {
            width: 120px;
        }

        .col-fechas {
            width: 115px;
            text-align: center;
        }

        .col-duracion {
            width: 85px;
            text-align: center;
        }

        .col-evidencia {
            width: 145px;
            text-align: center;
        }

        .col-cumplimiento {
            width: 135px;
            text-align: center;
        }

        /* ============================================
   Formato de fechas
   ============================================ */
        .fecha-celda {
            text-align: center !important;
            font-size: 11.5px !important;
            line-height: 1.6 !important;
            padding: 12px 8px !important;
            white-space: normal !important;
            word-wrap: break-word !important;
        }

        /* ============================================
   Contenedor de la tabla
   ============================================ */
        .table-container-no-hscroll {
            overflow-x: auto;
            overflow-y: auto;
            max-height: none;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.08);
        }

        /* ============================================
   Botones de evidencia
   ============================================ */
        .btn-group-sm > .btn {
            padding: 4px 7px;
            font-size: 10px;
            border-radius: 4px;
        }

        /* ============================================
   Indicador de carga (UpdateProgress)
   ============================================ */
        .update-progress-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 99999;
            background-color: rgba(0, 0, 0, 0.35);
        }

        .update-progress-box {
            position: absolute;
            top: 50%;
            left: 50%;
            min-width: 220px;
            padding: 22px 28px;
            transform: translate(-50%, -50%);
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.25);
            color: #333333;
            text-align: center;
            font-size: 15px;
        }

            .update-progress-box .glyphicon {
                display: block;
                margin-bottom: 12px;
                color: #667eea;
                font-size: 30px;
            }

        .glyphicon-spin {
            animation: glyphicon-spin 1s infinite linear;
        }

        @keyframes glyphicon-spin {
            from {
                transform: rotate(0deg);
            }

            to {
                transform: rotate(360deg);
            }
        }

        /* ============================================
   Ajuste de texto en celdas
   ============================================ */
        .tabla-finalizados th,
        .tabla-finalizados td {
            white-space: normal;
            word-break: normal;
            overflow-wrap: break-word;
        }

        .tabla-finalizados .fecha-celda {
            min-width: 125px;
            white-space: nowrap !important;
            line-height: 1.5 !important;
        }

        /* ============================================
   Iconos de cumplimiento (caras)
   ============================================ */
        .cumplimiento-icono {
            font-size: 1.6rem;
            color: #f39c12;
        }

            .cumplimiento-icono.fa-grin-alt {
                color: #28a745;
            }

            .cumplimiento-icono.fa-meh {
                color: #f39c12;
            }

            .cumplimiento-icono.fa-sad-cry {
                color: #e74c3c;
            }

        /* ============================================
   Campo de búsqueda global
   ============================================ */
        #globalSearchFinalizados {
            transition: all 0.3s ease;
            font-size: 13px;
            padding: 8px 14px;
        }

            #globalSearchFinalizados:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                outline: none;
            }

            #globalSearchFinalizados::placeholder {
                color: #999999;
            }

        /* En pantallas pequeñas, el buscador ocupa todo el ancho */
        @media (max-width: 768px) {
            #globalSearchFinalizados {
                width: 100% !important;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- Indicadores de progreso para los UpdatePanels -->
        <asp:UpdateProgress ID="UpdateProgressAbiertos" runat="server"
            AssociatedUpdatePanelID="UpdatePanelAbiertos" DisplayAfter="150">
            <ProgressTemplate>
                <div class="update-progress-overlay">
                    <div class="update-progress-box">
                        <span class="glyphicon glyphicon-refresh glyphicon-spin"></span>
                        <span>Cargando servicios asignados...</span>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <asp:UpdateProgress ID="UpdateProgressFinalizados" runat="server"
            AssociatedUpdatePanelID="UpdatePanelFinalizados" DisplayAfter="150">
            <ProgressTemplate>
                <div class="update-progress-overlay">
                    <div class="update-progress-box">
                        <span class="glyphicon glyphicon-refresh glyphicon-spin"></span>
                        <span>Cargando servicios finalizados...</span>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>

        <div class="container col-xs-0 col-sm-0 col-md-0 col-lg-1"></div>
        <div class="container col-xs-12 col-sm-12 col-md-12 col-lg-10">
            <div class="row">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center>
                        <img src="MrLucky.jpeg" class="img-responsive img-circle" alt="mrlucky" />
                    </center>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <center>
                        <h1>Administrador de Tickets de Sistemas</h1>
                    </center>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center>
                        <img src="gab.jpg" class="img-responsive" alt="mrlucky" />
                    </center>
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
                <!-- ==================== TAB: Registrar Usuario ==================== -->
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
                                        <asp:DropDownList ID="cmbDepto" runat="server" AutoPostBack="false" CssClass="form-control"></asp:DropDownList>
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

                <!-- ==================== TAB: Servicios Sistemas ==================== -->
                <div class="tab-pane fade in active" id="sis">
                    <h3>Servicios Solicitados</h3>
                    <asp:GridView runat="server" ID="dgSolicitados"
                        CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso"></asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <asp:BoundField HeaderText="Solicitado A" DataField="Asignado_A"></asp:BoundField>
                            <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                            <asp:BoundField HeaderText="Estado" DataField="Estado"></asp:BoundField>
                            <asp:TemplateField HeaderText="Foto">
                                <ItemTemplate>
                                    <button type="button" class="btn btn-primary btn-ver-foto" data-toggle="modal" data-target="#myModal">Foto</button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <!-- Modal Evidencia (Antes) -->
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
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto12" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto13" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto14" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="foto15" src=""></center>
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

                    <!-- Modal Evidencia (Después) -->
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
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img2" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img3" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img4" src=""></center>
                                            </div>
                                            <div class="item">
                                                <center>
                                                    <img class="img-responsive" id="Img5" src=""></center>
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
                            <asp:DropDownList ID="cmbResponsableServicioSis" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3">
                            <label>Fecha estimada de finalización: </label>
                            <asp:TextBox ID="datetimepicker4" runat="server" type="text" CssClass="form-control" />
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
                            <asp:TextBox ID="txtComentarioSis" runat="server" CssClass="form-control" Rows="2" TextMode="multiline" placeholder="Comentario"></asp:TextBox>
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

                    <h2>Servicios Asignados a Sistemas</h2>
                    <asp:UpdatePanel ID="UpdatePanelAbiertos" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:GridView runat="server" ID="dgAbiertosSis"
                                CssClass="table table-bordered table-responsive table-hover table-striped"
                                AutoGenerateColumns="false"
                                EmptyDataText="No hay servicios"
                                ShowHeaderWhenEmpty="true"
                                AllowPaging="true"
                                PageSize="5"
                                OnPageIndexChanging="dgAbiertosSis_PageIndexChanging">
                                <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                                <Columns>
                                    <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                                    <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                                    <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                                    <asp:BoundField HeaderText="Comentarios" DataField="Comentarios"></asp:BoundField>
                                    <asp:BoundField HeaderText="Responsable" DataField="Asignado_A"></asp:BoundField>
                                    <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso"></asp:BoundField>
                                    <asp:BoundField HeaderText="Fecha Estimada Fin" DataField="Fecha_Estimada_Fin"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Foto">
                                        <ItemTemplate>
                                            <center>
                                                <button type="button" class="btn btn-primary btn-ver-foto" data-toggle="modal" data-target="#myModal">Antes</button>
                                            </center>
                                            <br />
                                            <center>
                                                <button type="button" class="btn btn-primary btn-ver-foto2" data-toggle="modal" data-target="#myModal2">Después</button>
                                            </center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <hr />
                    <h2>Servicios Finalizados de Sistemas</h2>
                    <asp:UpdatePanel ID="UpdatePanelFinalizados" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="card shadow-sm border-0" style="margin-bottom: 20px;">
                                <!-- Cabecera con título y búsqueda -->
                                <div class="card-header bg-white border-0 py-3">
                                    <div class="row align-items-center">
                                        <div class="col-xs-12 col-sm-6">
                                            <h5 class="mb-1 fw-bold text-dark">
                                                <span class="glyphicon glyphicon-ok-circle"></span>
                                                Servicios Finalizados de Sistemas
                                            </h5>
                                            <small class="text-muted">Consulta histórica de servicios concluidos</small>
                                        </div>
                                        <div class="col-xs-12 col-sm-6">
                                            <div class="input-group input-group-sm" style="margin-top: 5px;">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                                                <input type="text" id="globalSearchFinalizados" class="form-control"
                                                    placeholder="Buscar en toda la tabla..." />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cuerpo con la tabla -->
                                <div class="card-body p-0">
                                    <div class="table-container-no-hscroll">
                                        <asp:GridView
                                            runat="server"
                                            ID="dgFinalizadosxis"
                                            CssClass="table table-hover tabla-finalizados mb-0 table-striped"
                                            AutoGenerateColumns="false"
                                            EmptyDataText="No hay servicios finalizados"
                                            ShowHeaderWhenEmpty="true"
                                            GridLines="None"
                                            UseAccessibleHeader="true">

                                            <HeaderStyle CssClass="table-header-gradient" />
                                            <RowStyle CssClass="table-row" />
                                            <AlternatingRowStyle CssClass="table-row-alt" />

                                            <Columns>
                                                <asp:BoundField HeaderText="ID" DataField="ID">
                                                    <ItemStyle CssClass="text-center col-id" />
                                                    <HeaderStyle CssClass="text-center col-id" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                                                    <ItemStyle CssClass="col-nombre" />
                                                    <HeaderStyle CssClass="col-nombre" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Incidente" DataField="Incidente">
                                                    <ItemStyle CssClass="col-incidente" />
                                                    <HeaderStyle CssClass="col-incidente" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Comentarios" DataField="Comentarios">
                                                    <ItemStyle CssClass="col-comentarios" />
                                                    <HeaderStyle CssClass="col-comentarios" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Asignado a" DataField="Asignado_A">
                                                    <ItemStyle CssClass="col-asignado" />
                                                    <HeaderStyle CssClass="col-asignado" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Fecha de ingreso" DataField="Fecha_de_Ingreso"
                                                    DataFormatString="{0:dd/MM/yyyy HH:mm}" HtmlEncode="false">
                                                    <ItemStyle CssClass="fecha-celda col-fechas" />
                                                    <HeaderStyle CssClass="col-fechas" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Último estado" DataField="Fecha_de_último_Estado"
                                                    DataFormatString="{0:dd/MM/yyyy HH:mm}" HtmlEncode="false">
                                                    <ItemStyle CssClass="fecha-celda col-fechas" />
                                                    <HeaderStyle CssClass="col-fechas" />
                                                </asp:BoundField>

                                                <asp:BoundField HeaderText="Duración" DataField="Duración">
                                                    <ItemStyle CssClass="text-center col-duracion" />
                                                    <HeaderStyle CssClass="text-center col-duracion" />
                                                </asp:BoundField>

                                                <asp:TemplateField HeaderText="Evidencia">
                                                    <HeaderStyle CssClass="text-center col-evidencia" />
                                                    <ItemStyle CssClass="text-center col-evidencia" />
                                                    <ItemTemplate>
                                                        <div class="btn-group btn-group-sm">
                                                            <button type="button" class="btn btn-outline-primary btn-xs btn-ver-foto" data-toggle="modal" data-target="#myModal">Antes</button>
                                                            <button type="button" class="btn btn-outline-success btn-xs btn-ver-foto2" data-toggle="modal" data-target="#myModal2">Después</button>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Cumplimiento y Calidad del Servicio">
                                                    <HeaderStyle CssClass="text-center col-cumplimiento" />
                                                    <ItemStyle CssClass="text-center col-cumplimiento" />
                                                    <ItemTemplate>
                                                        <i class='<%# Eval("CumplimientoCalidad") %> cumplimiento-icono'
                                                            data-toggle="tooltip" title="Evaluación del servicio"></i>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>

                                    <!-- Paginación personalizada -->
                                    <div id="paginationFinalizados" class="text-center" style="padding: 10px 0; background-color: #f8f9fa; border-top: 1px solid #e9ecef;">
                                        <ul class="pagination pagination-sm" style="margin: 0;"></ul>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        // ============================================
        // Paginación y búsqueda personalizada para Servicios Finalizados
        // ============================================
        var finalizados = {
            currentPage: 1,
            rowsPerPage: 15,
            $table: null,
            $rows: null,
            filteredRows: null,
            totalRows: 0,
            totalPages: 1,

            init: function () {
                this.$table = $('#dgFinalizadosxis');
                this.$rows = this.$table.find('tbody tr');
                this.filteredRows = this.$rows; // Inicialmente, todas las filas están visibles
                this.totalRows = this.$rows.length;
                this.totalPages = Math.ceil(this.totalRows / this.rowsPerPage) || 1;
                this.currentPage = 1;
                this.showPage(1);
                this.createPagination();
                this.bindSearch();
            },

            showPage: function (page) {
                if (page < 1) page = 1;
                if (page > this.totalPages) page = this.totalPages;
                this.currentPage = page;

                var start = (page - 1) * this.rowsPerPage;
                var end = start + this.rowsPerPage;

                this.filteredRows.hide().slice(start, end).show();
                this.updatePagination();
            },

            createPagination: function () {
                var $pagination = $('#paginationFinalizados ul');
                $pagination.empty();

                // Botón anterior
                $pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="prev">&laquo;</a></li>');

                // Números de página
                for (var i = 1; i <= this.totalPages; i++) {
                    $pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
                }

                // Botón siguiente
                $pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="next">&raquo;</a></li>');

                // Eventos
                var self = this;
                $pagination.find('a').on('click', function (e) {
                    e.preventDefault();
                    var page = $(this).data('page');
                    if (page === 'prev') {
                        self.showPage(self.currentPage - 1);
                    } else if (page === 'next') {
                        self.showPage(self.currentPage + 1);
                    } else {
                        self.showPage(parseInt(page));
                    }
                });
            },

            updatePagination: function () {
                var $pagination = $('#paginationFinalizados ul');
                $pagination.find('li').removeClass('active');
                $pagination.find('a[data-page="' + this.currentPage + '"]').parent('li').addClass('active');
            },

            bindSearch: function () {
                var self = this;
                // Eliminar manejador previo para evitar duplicados
                $('#globalSearchFinalizados').off('keyup').on('keyup', function () {
                    var term = $(this).val().toLowerCase();
                    var filteredRows = self.$rows.filter(function () {
                        return $(this).text().toLowerCase().indexOf(term) > -1;
                    });
                    self.filteredRows = filteredRows; // Actualizar las filas filtradas
                    self.$rows.hide();
                    filteredRows.show();

                    // Recalcular paginación con filas filtradas
                    self.totalRows = filteredRows.length;
                    self.totalPages = Math.ceil(self.totalRows / self.rowsPerPage) || 1;
                    self.currentPage = 1;
                    self.createPagination();
                    self.showPage(1);
                });
            }
        };

        // ============================================
        // Inicialización general
        // ============================================
        $(document).ready(function () {
            // Inicializar paginación de finalizados
            finalizados.init();

            // Restaurar pestaña activa
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#tablas a[href="' + activeTab + '"]').tab('show');
            }

            // Inicializar datetimepicker
            $('#datetimepicker4').datetimepicker({
                locale: 'es'
            });

            // Inicializar tooltips
            $('[data-toggle="tooltip"]').tooltip();

            $(document).on("click", ".btn-ver-foto", function (e) {
                e.preventDefault();
                var folio = $(this).closest("tr").find(".ID").text();
                $("#foto11").attr('src', 'FotosManto/' + folio + '1.jpg');
                $("#foto12").attr('src', 'FotosManto/' + folio + '2.jpg');
                $("#foto13").attr('src', 'FotosManto/' + folio + '3.jpg');
                $("#foto14").attr('src', 'FotosManto/' + folio + '4.jpg');
                $("#foto15").attr('src', 'FotosManto/' + folio + '5.jpg');
                // No es necesario return false porque no hay postback
            });

            $(document).on("click", ".btn-ver-foto2", function (e) {
                e.preventDefault();
                var folio = $(this).closest("tr").find(".ID").text();
                $("#Img1").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
                $("#Img2").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
                $("#Img3").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
                $("#Img4").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
                $("#Img5").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');
            });
        });

        // ============================================
        // Re-inicializar después de actualizaciones parciales
        // ============================================
        if (typeof (Sys) !== 'undefined') {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function (sender, args) {
                var updatedPanels = sender.get_panelsUpdated();
                for (var i = 0; i < updatedPanels.length; i++) {
                    if (updatedPanels[i].id === 'UpdatePanelFinalizados') {
                        setTimeout(function () {
                            finalizados.init();
                        }, 100);
                        break;
                    }
                }
            });
        }
    </script>
</body>
</html>
