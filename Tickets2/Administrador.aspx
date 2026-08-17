<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="Tickets2.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador de Tickets de Sistemas</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />

    <style>
        :root {
            --primary-color: #1e3a5f;
            --primary-hover: #2a4d7a;
            --background: #f4f7fb;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            --border-radius: 12px;
        }

        body {
            background-color: var(--background);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar-custom {
            background-color: var(--primary-color);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

            .navbar-custom .navbar-brand {
                color: #fff;
                font-weight: 600;
            }

            .navbar-custom .btn {
                border-radius: 20px;
                font-size: 0.9rem;
            }

        .btn-icon::before {
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            margin-right: 6px;
        }

        .btn-save::before {
            content: "\f0c7";
        }
        /* guardar */
        .btn-logout::before {
            content: "\f2f5";
        }
        /* salir */
        .btn-refresh::before {
            content: "\f021";
        }
        /* refrescar */
        .btn-finalize::before {
            content: "\f00c";
        }
        /* finalizar */
        .btn-comment::before {
            content: "\f075";
        }
        /* comentar */
        .btn-camera::before {
            content: "\f030";
        }
        /* foto */

        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
        }

        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #e9ecef;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
            padding: 1rem 1.5rem;
        }

            .card-header h5 {
                margin-bottom: 0;
                font-weight: 600;
                color: var(--primary-color);
            }

        .table-dark th {
            background-color: var(--primary-color);
            color: #fff;
            font-weight: 500;
            white-space: nowrap;
        }

        .table-hover tbody tr:hover {
            background-color: #e9f2fa;
        }

        .search-box {
            max-width: 300px;
            margin-bottom: 1rem;
        }

            .search-box .input-group-text {
                background-color: #fff;
                border-right: none;
            }

            .search-box input {
                border-left: none;
            }

        .modal-content {
            border-radius: var(--border-radius);
            border: none;
        }

        .modal-header {
            background-color: var(--primary-color);
            color: #fff;
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

            .modal-header .btn-close {
                filter: invert(1);
            }

        .carousel-item img {
            height: 400px;
            object-fit: contain;
            background-color: #f0f0f0;
            border-radius: 8px;
        }

        .carousel-indicators [data-bs-target] {
            background-color: #000;
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }

        .tab-pane {
            padding-top: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .nav-tabs .nav-link {
            color: var(--primary-color);
            font-weight: 500;
            border-radius: 8px 8px 0 0;
        }

            .nav-tabs .nav-link.active {
                background-color: var(--primary-color);
                color: #fff;
                border-color: var(--primary-color);
            }

        .btn-group-sm .btn {
            border-radius: 20px;
            font-size: 0.8rem;
            padding: 0.25rem 0.75rem;
        }

        .badge-estado {
            background-color: #e9ecef;
            color: #495057;
            font-weight: 500;
            padding: 0.35em 0.65em;
            border-radius: 20px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <form runat="server">
        <!-- Barra de navegación superior -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-ticket-alt me-2"></i>Admin Tickets Sistemas
                </a>
                <div class="d-flex align-items-center">
                    <a href="Administrador.aspx" class="btn btn-outline-light btn-refresh btn-icon me-2">Refrescar
                    </a>
                    <asp:LinkButton ID="btnSalir" runat="server" CssClass="btn btn-light btn-logout btn-icon"
                        Text="Salir" OnClick="btnSalir_Click" />
                </div>
            </div>
        </nav>

        <!-- Contenido principal -->
        <div class="container-fluid px-4 py-4">
            <!-- Pestañas -->
            <ul class="nav nav-tabs" id="tablas" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" href="#sis" data-bs-toggle="tab" role="tab">
                        <i class="fas fa-list-alt me-2"></i>Servicios Sistemas
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" href="#reg" data-bs-toggle="tab" role="tab">
                        <i class="fas fa-user me-2"></i>Registrar Usuarios
                    </a>
                </li>
            </ul>

            <div class="tab-content">
                <!-- ==================== TAB: Registrar Usuario ==================== -->
                <div class="tab-pane fade" id="reg" role="tabpanel">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="card">
                                <div class="card-header">
                                    <h5><i class="fas fa-user-plus me-2"></i>Registro de Usuario</h5>
                                </div>
                                <div class="card-body">
                                    <h6 class="text-uppercase text-muted mb-3">Datos de la persona</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Nombre:</label>
                                            <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Nombre"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Apellido Paterno:</label>
                                            <asp:TextBox runat="server" ID="txtApellidoP" CssClass="form-control" placeholder="Apellido Paterno"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Apellido Materno:</label>
                                            <asp:TextBox runat="server" ID="txtApellidoM" CssClass="form-control" placeholder="Apellido Materno"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">E-mail:</label>
                                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="correo@ejemplo.com" TextMode="Email"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Teléfono Ext:</label>
                                            <asp:TextBox runat="server" ID="txtTele" CssClass="form-control" placeholder="Extensión"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Departamento:</label>
                                            <asp:DropDownList ID="cmbDepto" runat="server" CssClass="form-select"></asp:DropDownList>
                                        </div>
                                    </div>

                                    <hr class="my-4" />
                                    <h6 class="text-uppercase text-muted mb-3">Datos del usuario</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Nombre de Usuario:</label>
                                            <asp:TextBox runat="server" ID="txtNombreUsuario" CssClass="form-control" placeholder="Usuario"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Contraseña:</label>
                                            <asp:TextBox runat="server" ID="txtPasswordUsuario" CssClass="form-control" placeholder="Contraseña" TextMode="Password"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Rol:</label>
                                            <asp:DropDownList ID="cmbRol" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="cmbUsuario" Text="Usuario" Selected="True"></asp:ListItem>
                                                <asp:ListItem Value="cmbAdministrador" Text="Administrador"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-12 mt-4">
                                            <asp:LinkButton ID="BtnRegistro" runat="server" CssClass="btn btn-primary btn-save btn-icon"
                                                Text="Guardar" OnClick="BtnRegistro_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ==================== TAB: Servicios Sistemas ==================== -->
                <div class="tab-pane fade show active" id="sis" role="tabpanel">
                    <!-- Servicios solicitados -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-clipboard-list me-2"></i>Servicios Solicitados</h5>
                        </div>
                        <div class="card-body">
                            <div class="search-box">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" id="searchSolicitados" class="form-control" placeholder="Buscar...">
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView runat="server" ID="dgSolicitados"
                                    CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="false"
                                    EmptyDataText="No hay servicios"
                                    ShowHeaderWhenEmpty="true">
                                    <HeaderStyle CssClass="table-dark" />
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID text-center" />
                                        <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso" />
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                        <asp:BoundField HeaderText="Solicitado A" DataField="Asignado_A" />
                                        <asp:BoundField HeaderText="Incidente" DataField="Incidente" />
                                        <asp:BoundField HeaderText="Estado" DataField="Estado" ItemStyle-CssClass="text-center" />
                                        <asp:TemplateField HeaderText="Foto">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkView" CssClass="btn btn-outline-primary btn-sm"
                                                    Text="Foto" runat="server"
                                                    data-bs-toggle="modal" data-bs-target="#myModal">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                    <!-- Asignar responsable -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-user-check me-2"></i>Asignar responsable y fecha estimada</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-2">
                                    <label class="form-label">Id del Servicio:</label>
                                    <asp:TextBox runat="server" ID="txtIdServicioResponsableSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Responsable del servicio:</label>
                                    <asp:DropDownList ID="cmbResponsableServicioSis" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Fecha estimada de finalización:</label>
                                    <asp:TextBox ID="datetimepicker4" runat="server" type="date" CssClass="form-control" />
                                </div>
                                <div class="col-md-3">
                                    <asp:LinkButton ID="btnAsignarServicioSis" runat="server" CssClass="btn btn-primary btn-save btn-icon w-100"
                                        Text="Guardar" OnClick="btnAsignarServicioSis_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Agregar comentario -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-comment-dots me-2"></i>Agregar Comentario</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-2">
                                    <label class="form-label">Id del Servicio:</label>
                                    <asp:TextBox runat="server" ID="txtIdServicioSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                </div>
                                <div class="col-md-7">
                                    <label class="form-label">Comentario:</label>
                                    <asp:TextBox ID="txtComentarioSis" runat="server" CssClass="form-control" Rows="2" TextMode="multiline" placeholder="Escribe un comentario..."></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:LinkButton ID="btnComentarioSis" runat="server" CssClass="btn btn-primary btn-comment btn-icon w-100"
                                        Text="Guardar" OnClick="btnComentarioSis_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Agregar foto finalizado -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-camera me-2"></i>Agregar foto de servicio finalizado</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-2">
                                    <label class="form-label">Id del Servicio:</label>
                                    <asp:TextBox runat="server" ID="idserviciofotos" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                </div>
                                <div class="col-md-7">
                                    <label class="form-label">Fotos:</label>
                                    <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="form-control" multiple="multiple" />
                                </div>
                                <div class="col-md-3">
                                    <asp:LinkButton ID="btnfotofin" runat="server" CssClass="btn btn-primary btn-camera btn-icon w-100"
                                        Text="Guardar" OnClick="btnfotofin_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Finalizar servicio -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-check-circle me-2"></i>Finalizar Servicio</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-3">
                                    <label class="form-label">Id del Servicio:</label>
                                    <asp:TextBox runat="server" ID="txtIdServicioFinSis" CssClass="form-control" placeholder="ID"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <asp:LinkButton ID="BtnServicioFinSis" runat="server" CssClass="btn btn-success btn-finalize btn-icon w-100"
                                        Text="Finalizar" OnClick="BtnServicioFinSis_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Servicios Asignados -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-tasks me-2"></i>Servicios Asignados a Sistemas</h5>
                        </div>
                        <div class="card-body">
                            <div class="search-box">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" id="searchAbiertos" class="form-control" placeholder="Buscar...">
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView runat="server" ID="dgAbiertosSis"
                                    CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="false"
                                    EmptyDataText="No hay servicios"
                                    ShowHeaderWhenEmpty="true">
                                    <HeaderStyle CssClass="table-dark" />
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID text-center" />
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                                        <asp:BoundField HeaderText="Incidente" DataField="Incidente" />
                                        <asp:BoundField HeaderText="Comentarios" DataField="Comentarios" />
                                        <asp:BoundField HeaderText="Responsable" DataField="Asignado_A" />
                                        <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso" />
                                        <asp:BoundField HeaderText="Fecha Estimada Fin" DataField="Fecha_Estimada_Fin" />
                                        <asp:TemplateField HeaderText="Foto">
                                            <ItemTemplate>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <asp:LinkButton ID="lnkView" CssClass="btn btn-outline-primary"
                                                        Text="Antes" runat="server"
                                                        data-bs-toggle="modal" data-bs-target="#myModal">
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lnkView2" CssClass="btn btn-outline-success"
                                                        Text="Después" runat="server"
                                                        data-bs-toggle="modal" data-bs-target="#myModal2">
                                                    </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                    <!-- Servicios Finalizados -->
                    <div class="card">
                        <div class="card-header">
                            <h5><i class="fas fa-check-double me-2"></i>Servicios Finalizados de Sistemas</h5>
                            <small class="text-muted">Consulta de servicios concluidos</small>
                        </div>
                        <div class="card-body">
                            <div class="search-box">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                    <input type="text" id="searchFinalizados" class="form-control" placeholder="Buscar...">
                                </div>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView
                                    runat="server"
                                    ID="dgFinalizadosxis"
                                    CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="false"
                                    EmptyDataText="No hay servicios finalizados"
                                    ShowHeaderWhenEmpty="true"
                                    OnPageIndexChanging="dgFinalizadosSis_PageIndexChanging"
                                    GridLines="None">
                                    <HeaderStyle CssClass="table-dark" />
                                    <Columns>
                                        <asp:BoundField HeaderText="ID" DataField="ID">
                                            <ItemStyle CssClass="text-center fw-semibold text-muted" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Nombre" DataField="Nombre">
                                            <ItemStyle CssClass="fw-semibold" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Incidente" DataField="Incidente">
                                            <ItemStyle CssClass="text-wrap" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Comentarios" DataField="Comentarios">
                                            <ItemStyle CssClass="text-wrap comentarios-column" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Asignado a" DataField="Asignado_A" />
                                        <asp:BoundField HeaderText="Estado" DataField="Estado">
                                            <ItemStyle CssClass="text-center" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Fecha de ingreso" DataField="Fecha_de_Ingreso">
                                            <ItemStyle CssClass="text-nowrap" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Último estado" DataField="Fecha_de_último_Estado">
                                            <ItemStyle CssClass="text-nowrap" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Duración" DataField="Duración">
                                            <ItemStyle CssClass="text-center text-nowrap" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Evidencia">
                                            <ItemTemplate>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <asp:LinkButton
                                                        ID="lnkView"
                                                        runat="server"
                                                        CssClass="btn btn-outline-primary"
                                                        Text="Antes"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#myModal"
                                                        ToolTip="Ver fotografía antes del servicio">
                                                    </asp:LinkButton>
                                                    <asp:LinkButton
                                                        ID="lnkView2"
                                                        runat="server"
                                                        CssClass="btn btn-outline-success"
                                                        Text="Después"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#myModal2"
                                                        ToolTip="Ver fotografía después del servicio">
                                                    </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==================== MODAL EVIDENCIA ANTES ==================== -->
        <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabel">Evidencia (Antes)</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="carousel-example-generic" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">
                            <ol class="carousel-indicators">
                                <li data-bs-target="#carousel-example-generic" data-bs-slide-to="0" class="active"></li>
                                <li data-bs-target="#carousel-example-generic" data-bs-slide-to="1"></li>
                                <li data-bs-target="#carousel-example-generic" data-bs-slide-to="2"></li>
                                <li data-bs-target="#carousel-example-generic" data-bs-slide-to="3"></li>
                                <li data-bs-target="#carousel-example-generic" data-bs-slide-to="4"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block w-100" id="foto11" src="" alt="Evidencia 1">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="foto12" src="" alt="Evidencia 2">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="foto13" src="" alt="Evidencia 3">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="foto14" src="" alt="Evidencia 4">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="foto15" src="" alt="Evidencia 5">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carousel-example-generic" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Anterior</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carousel-example-generic" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Siguiente</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==================== MODAL EVIDENCIA DESPUÉS ==================== -->
        <div class="modal fade" id="myModal2" tabindex="-1" aria-labelledby="myModalLabel2" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="myModalLabel2">Evidencia (Después)</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="carousel-example-generic2" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">
                            <ol class="carousel-indicators">
                                <li data-bs-target="#carousel-example-generic2" data-bs-slide-to="0" class="active"></li>
                                <li data-bs-target="#carousel-example-generic2" data-bs-slide-to="1"></li>
                                <li data-bs-target="#carousel-example-generic2" data-bs-slide-to="2"></li>
                                <li data-bs-target="#carousel-example-generic2" data-bs-slide-to="3"></li>
                                <li data-bs-target="#carousel-example-generic2" data-bs-slide-to="4"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img class="d-block w-100" id="Img1" src="" alt="Evidencia final 1">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="Img2" src="" alt="Evidencia final 2">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="Img3" src="" alt="Evidencia final 3">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="Img4" src="" alt="Evidencia final 4">
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block w-100" id="Img5" src="" alt="Evidencia final 5">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carousel-example-generic2" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Anterior</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carousel-example-generic2" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Siguiente</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- Scripts al final para mejor rendimiento -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // Restaurar pestaña activa desde localStorage
            var activeTab = localStorage.getItem('activeTab');
            if (activeTab) {
                var tab = new bootstrap.Tab(document.querySelector('#tablas a[href="' + activeTab + '"]'));
                tab.show();
            }

            // Guardar pestaña activa al cambiar
            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });

            // Búsqueda en tablas
            $("#searchSolicitados").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#dgSolicitados tbody tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });

            $("#searchAbiertos").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#dgAbiertosSis tbody tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });

            $("#searchFinalizados").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#dgFinalizadosxis tbody tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });

            // Cargar imágenes "Antes"
            $(document).on("click", "[id*=lnkView]", function () {
                var folio = $(".ID", $(this).closest("tr")).html();
                $("#foto11").attr('src', 'FotosManto/' + folio + '1.jpg');
                $("#foto12").attr('src', 'FotosManto/' + folio + '2.jpg');
                $("#foto13").attr('src', 'FotosManto/' + folio + '3.jpg');
                $("#foto14").attr('src', 'FotosManto/' + folio + '4.jpg');
                $("#foto15").attr('src', 'FotosManto/' + folio + '5.jpg');
            });

            // Cargar imágenes "Después"
            $(document).on("click", "[id*=lnkView2]", function () {
                var folio = $(".ID", $(this).closest("tr")).html();
                $("#Img1").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
                $("#Img2").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
                $("#Img3").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
                $("#Img4").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
                $("#Img5").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');
            });
        });
    </script>
</body>
</html>
