<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="Tickets2.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador de Tickets Sistema</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- LIBRERÍAS LIMPIAS (Sin duplicados) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap-datetimepicker.css" />
    <link rel="stylesheet" href="css/FormContactos.css" />

    <style type="text/css">
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Cabecera Principal */
        .header-brand {
            background: linear-gradient(135deg, #4682B4 0%, #2c5775 100%);
            color: white;
            padding: 20px 0;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

            .header-brand img {
                max-height: 60px;
                border-radius: 50%;
                border: 2px solid rgba(255,255,255,0.5);
            }

            .header-brand h1 {
                margin: 0;
                font-size: 1.8rem;
                font-weight: 600;
            }

        /* Pestañas */
        .nav-tabs {
            border-bottom: 2px solid #4682B4;
        }

            .nav-tabs .nav-link {
                border: none;
                color: #555;
                font-weight: 500;
            }

                .nav-tabs .nav-link.active {
                    color: #4682B4;
                    border-bottom: 3px solid #4682B4;
                    background: transparent;
                }

                .nav-tabs .nav-link:hover {
                    color: #4682B4;
                }

        /* Tarjetas de Acción (Reemplazan los formularios sueltos) */
        .action-card {
            background: white;
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            border-left: 4px solid #4682B4;
        }

            .action-card.success {
                border-left-color: #28a745;
            }

            .action-card.warning {
                border-left-color: #ffc107;
            }

            .action-card.danger {
                border-left-color: #dc3545;
            }

            .action-card .card-header {
                background: transparent;
                border-bottom: 1px solid #eee;
                font-weight: 600;
                color: #333;
            }

            .action-card .card-body {
                padding: 20px;
            }

            .action-card label {
                font-size: 0.85rem;
                color: #6c757d;
                margin-bottom: 5px;
                font-weight: 500;
            }

        /* GridViews Modernos */
        .table-responsive {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            padding: 10px;
            margin-bottom: 25px;
        }

        .custom-grid-header {
            background-color: #4682B4;
            color: #ffffff !important;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

            .custom-grid-header th {
                padding: 12px 15px !important;
                border-bottom: 2px solid #2c5775 !important;
            }

        .table-hover tbody tr:hover {
            background-color: #eef5fa !important;
        }

        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: rgba(0,0,0,.02);
        }

        /* Modales */
        .modal-header {
            background-color: #4682B4;
            color: white;
        }

            .modal-header .close {
                color: white;
                text-shadow: none;
            }

        .modal-content {
            border-radius: 10px;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <form runat="server">
        <!-- CABECERA -->
        <div class="header-brand">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-2 text-center text-md-left">
                        <img src="MrLucky.jpeg" alt="Logo" />
                    </div>
                    <div class="col-md-8 text-center">
                        <h1><i class="bi bi-ticket-perforated mr-2"></i>Administrador de Tickets de Sistemas</h1>
                    </div>
                    <div class="col-md-2 text-center text-md-right d-none d-md-block">
                        <img src="gab.jpg" alt="Logo" class="rounded-circle" style="max-height: 60px;" />
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <!-- NAVEGACIÓN -->
            <ul class="nav nav-tabs mb-4" id="tablas" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" href="#sis" data-toggle="tab"><i class="bi bi-list-task mr-1"></i>Servicios Sistemas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#reg" data-toggle="tab"><i class="bi bi-person-plus mr-1"></i>Registrar Usuarios</a>
                </li>
                <li class="nav-item ml-auto">
                    <a href="Administrador.aspx" class="nav-link btn btn-sm btn-outline-secondary mt-1"><i class="bi bi-arrow-clockwise mr-1"></i>Refrescar</a>
                </li>
                <li class="nav-item">
                    <asp:LinkButton ID="btnSalir" runat="server" CssClass="nav-link btn btn-sm btn-outline-danger mt-1"
                        Text="<i class='bi bi-box-arrow-right mr-1'></i>Salir" OnClick="btnSalir_Click" />
                </li>
            </ul>

            <!-- CONTENIDO DE PESTAÑAS -->
            <div class="tab-content">

                <!-- PESTAÑA: REGISTRAR USUARIOS -->
                <div class="tab-pane fade" id="reg">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="action-card">
                                <div class="card-header"><i class="bi bi-person-badge mr-2"></i>Datos de la Persona</div>
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label>Nombre</label>
                                            <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Apellido Paterno</label>
                                            <asp:TextBox runat="server" ID="txtApellidoP" CssClass="form-control" placeholder="Apellido Paterno"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Apellido Materno</label>
                                            <asp:TextBox runat="server" ID="txtApellidoM" CssClass="form-control" placeholder="Apellido Materno"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>E-mail</label>
                                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" placeholder="correo@ejemplo.com"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Teléfono / Ext</label>
                                            <asp:TextBox runat="server" ID="txtTele" CssClass="form-control" placeholder="Ext. 1234"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Departamento</label>
                                            <asp:DropDownList ID="cmbDepto" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="action-card success">
                                <div class="card-header"><i class="bi bi-shield-lock mr-2"></i>Datos del Usuario</div>
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <label>Usuario</label>
                                            <asp:TextBox runat="server" ID="txtNombreUsuario" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Contraseña</label>
                                            <asp:TextBox runat="server" ID="txtPasswordUsuario" CssClass="form-control" TextMode="Password" placeholder="Contraseña"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Rol</label>
                                            <asp:DropDownList ID="cmbRol" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="cmbUsuario" Text="Usuario" Selected="True"></asp:ListItem>
                                                <asp:ListItem Value="cmbAdministrador" Text="Administrador"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="text-right mt-3">
                                        <asp:LinkButton ID="BtnRegistro" runat="server" CssClass="btn btn-success" Text="<i class='bi bi-floppy mr-1'></i>Guardar Usuario" OnClick="BtnRegistro_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- PESTAÑA: SISTEMAS -->
                <div class="tab-pane fade show active" id="sis">

                    <!-- GRID 1: SOLICITADOS -->
                    <h5 class="mb-3 text-primary font-weight-bold">Solicitudes Pendientes</h5>
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="dgSolicitados" CssClass="table table-hover table-bordered align-middle mb-0"
                            AutoGenerateColumns="false" EmptyDataText="No hay servicios pendientes." ShowHeaderWhenEmpty="true" GridLines="None">
                            <HeaderStyle CssClass="custom-grid-header" />
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="text-center text-nowrap" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso" DataFormatString="{0:d}" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                <asp:BoundField HeaderText="Solicitado A" DataField="Asignado_A" />
                                <asp:BoundField HeaderText="Incidente" DataField="Incidente" />
                                <asp:BoundField HeaderText="Estado" DataField="Estado" ItemStyle-CssClass="text-center" />
                                <asp:TemplateField HeaderText="Evidencia" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkView" CssClass="btn btn-sm btn-outline-primary" runat="server" data-toggle="modal" data-target="#myModal">
                                            <i class="bi bi-image"></i> Ver
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                    <!-- FORMULARIOS DE ACCIÓN (Diseño Cards) -->
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="action-card">
                                <div class="card-header">Asignar Responsable</div>
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <label>ID Servicio</label>
                                            <asp:TextBox runat="server" ID="txtIdServicioResponsableSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Responsable</label>
                                            <asp:DropDownList ID="cmbResponsableServicioSis" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label>Fecha Estimada</label>
                                            <asp:TextBox ID='datetimepicker4' runat="server" CssClass="form-control" placeholder="DD/MM/YYYY" />
                                        </div>
                                    </div>
                                    <asp:LinkButton ID="btnAsignarServicioSis" runat="server" CssClass="btn btn-primary btn-sm" Text="<i class='bi bi-floppy mr-1'></i>Asignar" OnClick="btnAsignarServicioSis_Click" />
                                </div>
                            </div>

                            <div class="action-card warning">
                                <div class="card-header">Agregar Comentario</div>
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <label>ID Servicio</label>
                                            <asp:TextBox runat="server" ID="txtIdServicioSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-9">
                                            <label>Comentario</label>
                                            <asp:TextBox ID="txtComentarioSis" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine" placeholder="Escriba aquí..."></asp:TextBox>
                                        </div>
                                    </div>
                                    <asp:LinkButton ID="btnComentarioSis" runat="server" CssClass="btn btn-warning btn-sm text-white" Text="<i class='bi bi-chat-dots mr-1'></i>Comentar" OnClick="btnComentarioSis_Click" />
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="action-card success">
                                <div class="card-header">Subir Evidencia (Fotos)</div>
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <label>ID Servicio</label>
                                            <asp:TextBox runat="server" ID="idserviciofotos" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-9">
                                            <label>Seleccionar Fotos</label>
                                            <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="form-control-file" multiple="multiple" />
                                        </div>
                                    </div>
                                    <asp:LinkButton ID="btnfotofin" runat="server" CssClass="btn btn-success btn-sm" Text="<i class='bi bi-upload mr-1'></i>Subir Fotos" OnClick="btnfotofin_Click" />
                                </div>
                            </div>

                            <div class="action-card danger">
                                <div class="card-header">Finalizar Servicio</div>
                                <div class="card-body">
                                    <div class="form-row align-items-end">
                                        <div class="form-group col-md-6">
                                            <label>ID Servicio a Finalizar</label>
                                            <asp:TextBox runat="server" ID="txtIdServicioFinSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-6 text-right">
                                            <asp:LinkButton ID="BtnServicioFinSis" runat="server" CssClass="btn btn-danger btn-sm" Text="<i class='bi bi-check-circle mr-1'></i>Finalizar Ticket" OnClick="BtnServicioFinSis_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- GRID 2: ASIGNADOS -->
                    <h5 class="mb-3 mt-4 text-primary font-weight-bold">Servicios Asignados (En Proceso)</h5>
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="dgAbiertosSis" CssClass="table table-hover table-bordered align-middle mb-0"
                            AutoGenerateColumns="false" EmptyDataText="No hay servicios asignados." ShowHeaderWhenEmpty="true" GridLines="None">
                            <HeaderStyle CssClass="custom-grid-header" />
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID text-center text-nowrap" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                <asp:BoundField HeaderText="Incidente" DataField="Incidente" />
                                <asp:BoundField HeaderText="Comentarios" DataField="Comentarios" />
                                <asp:BoundField HeaderText="Responsable" DataField="Asignado_A" />
                                <asp:BoundField HeaderText="Ingreso" DataField="Fecha_Ingreso" DataFormatString="{0:d}" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:BoundField HeaderText="Fin Estimado" DataField="Fecha_Estimada_Fin" DataFormatString="{0:d}" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:TemplateField HeaderText="Evidencia" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <div class="btn-group-vertical btn-group-sm">
                                            <asp:LinkButton ID="lnkView" CssClass="btn btn-outline-primary" runat="server" data-toggle="modal" data-target="#myModal"><i class="bi bi-image"></i> Antes</asp:LinkButton>
                                            <asp:LinkButton ID="lnkView2" CssClass="btn btn-outline-success" runat="server" data-toggle="modal" data-target="#myModal2"><i class="bi bi-image"></i> Después</asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                    <!-- GRID 3: FINALIZADOS -->
                    <h5 class="mb-3 mt-4 text-primary font-weight-bold">Servicios Finalizados</h5>
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="dgFinalizadosxis" CssClass="table table-hover table-striped table-bordered align-middle mb-0"
                            AutoGenerateColumns="false" EmptyDataText="No hay servicios finalizados." ShowHeaderWhenEmpty="true"
                            OnPageIndexChanging="dgFinalizadosSis_PageIndexChanging" GridLines="None" AllowPaging="true" PageSize="15">
                            <HeaderStyle CssClass="custom-grid-header" />
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="text-center text-nowrap" HeaderStyle-CssClass="text-center" />
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" ItemStyle-CssClass="text-nowrap" />
                                <asp:BoundField HeaderText="Incidente" DataField="Incidente" ItemStyle-CssClass="text-nowrap" />
                                <asp:TemplateField HeaderText="Comentarios">
                                    <ItemTemplate>
                                        <div class="text-truncate" style="max-width: 200px;" title='<%# Eval("Comentarios") %>'><%# Eval("Comentarios") %></div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Asignado a" DataField="Asignado_A" ItemStyle-CssClass="text-nowrap" />
                                <asp:TemplateField HeaderText="Estado" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <span class="badge badge-success"><%# Eval("Estado") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Ingreso" DataField="Fecha_de_Ingreso" DataFormatString="{0:d}" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:BoundField HeaderText="Último Estado" DataField="Fecha_de_último_Estado" DataFormatString="{0:d}" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:BoundField HeaderText="Duración" DataField="Duración" ItemStyle-CssClass="text-nowrap text-center" />
                                <asp:TemplateField HeaderText="Evidencia" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <div class="btn-group-vertical btn-group-sm">
                                            <asp:LinkButton ID="lnkView" CssClass="btn btn-outline-primary" runat="server" data-toggle="modal" data-target="#myModal"><i class="bi bi-image"></i> Antes</asp:LinkButton>
                                            <asp:LinkButton ID="lnkView2" CssClass="btn btn-outline-success" runat="server" data-toggle="modal" data-target="#myModal2"><i class="bi bi-image"></i> Después</asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>
            <br />
            <br />
        </div>
        <!-- Fin Container -->

        <!-- MODAL FOTOS 1 (ANTES) -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabel"><i class="bi bi-image mr-2"></i>Evidencia: Antes del Servicio</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body text-center">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="4"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block mx-auto img-fluid" id="foto11" src="" alt="Foto 1"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="foto12" src="" alt="Foto 2"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="foto13" src="" alt="Foto 3"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="foto14" src="" alt="Foto 4"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="foto15" src="" alt="Foto 5"></div>
                            </div>
                            <a class="carousel-control-prev" href="#carousel-example-generic" role="button" data-slide="prev"><span class="carousel-control-prev-icon"></span></a>
                            <a class="carousel-control-next" href="#carousel-example-generic" role="button" data-slide="next"><span class="carousel-control-next-icon"></span></a>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL FOTOS 2 (DESPUÉS) -->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabel2"><i class="bi bi-image mr-2"></i>Evidencia: Después del Servicio</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body text-center">
                        <div id="carousel-example-generic2" class="carousel slide" data-ride="carousel" data-interval="false">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic2" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic2" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic2" data-slide-to="2"></li>
                                <li data-target="#carousel-example-generic2" data-slide-to="3"></li>
                                <li data-target="#carousel-example-generic2" data-slide-to="4"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block mx-auto img-fluid" id="Img1" src="" alt="Foto 1"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="Img2" src="" alt="Foto 2"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="Img3" src="" alt="Foto 3"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="Img4" src="" alt="Foto 4"></div>
                                <div class="carousel-item">
                                    <img class="d-block mx-auto img-fluid" id="Img5" src="" alt="Foto 5"></div>
                            </div>
                            <a class="carousel-control-prev" href="#carousel-example-generic2" role="button" data-slide="prev"><span class="carousel-control-prev-icon"></span></a>
                            <a class="carousel-control-next" href="#carousel-example-generic2" role="button" data-slide="next"><span class="carousel-control-next-icon"></span></a>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- SCRIPTS LIMPIOS (Al final del body para mejor carga) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/bootstrap-datetimepicker.js" type="text/javascript"></script>
    <script src="js/fileinput.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // Mantener pestaña activa al recargar
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                $('#tablas a[href="' + activeTab + '"]').tab('show');
            }

            // Inicializar Datepicker
            $('#datetimepicker4').datetimepicker({ locale: 'es', format: 'DD/MM/YYYY' });
        });

        // Modal Fotos 1 (Antes)
        $(document).on("click", "[id*=lnkView]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#foto11").attr('src', 'FotosManto/' + folio + '1.jpg');
            $("#foto12").attr('src', 'FotosManto/' + folio + '2.jpg');
            $("#foto13").attr('src', 'FotosManto/' + folio + '3.jpg');
            $("#foto14").attr('src', 'FotosManto/' + folio + '4.jpg');
            $("#foto15").attr('src', 'FotosManto/' + folio + '5.jpg');

            // Reiniciar carousel al abrir
            $('#carousel-example-generic').carousel(0);
        });

        // Modal Fotos 2 (Después)
        $(document).on("click", "[id*=lnkView2]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#Img1").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
            $("#Img2").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
            $("#Img3").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
            $("#Img4").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
            $("#Img5").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');

            // Reiniciar carousel al abrir
            $('#carousel-example-generic2').carousel(0);
        });
    </script>
</body>
</html>
