<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminManto.aspx.cs" Inherits="Tickets2.AdminManto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador de Tickets Mantenimiento</title>
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

    <link rel="stylesheet" href="css/bootstrap-datetimepicker.css" />
    <script src="js/moment.js" type="text/javascript"></script>
    <script src="js/bootstrap-datetimepicker.js" type="text/javascript"></script>

    <style type="text/css">
        .table-striped > tbody > tr:nth-child(odd), .table-striped > tbody > tr:nth-child(odd) {
            background-color: #bfd8eb;
        }

        .table-hover > tbody > tr:hover {
            background-color: #9fb8cb;
        }
    </style>
    <script type="text/javascript">

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
                        <h1>Administrador de Tickets de Mantenimiento</h1>
                    </center>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center>
                        <img src="gab.jpg" class="img-responsive" alt="mrlucky" /></center>
                </div>
            </div>
            <br />
            <ul class="nav nav-tabs" id="tablas">
                <li class="active"><a href="#man" data-toggle="tab">Servicios Mantenimiento <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></a></li>
                <li><a href="AdminManto.aspx" class="btn btn-success">Refrescar <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a></li>
                <li>
                    <asp:LinkButton ID="btnSalir" runat="server" CssClass="btn btn-primary"
                        Text="Salir <span class='glyphicon glyphicon-log-out'></span>"
                        OnClick="btnSalir_Click" />
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="man">
                    <h3>Servicios Solicitados</h3>
                    <asp:GridView runat="server" ID="dgSolicitadosMan" CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso"></asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <asp:BoundField HeaderText="Solicitado A" DataField="Responsable"></asp:BoundField>
                            <asp:BoundField HeaderText="Area" DataField="Area"></asp:BoundField>
                            <asp:BoundField HeaderText="Equipo" DataField="Equipo"></asp:BoundField>
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
                            <asp:TextBox runat="server" ID="txtIdServicioResponsableMan" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                            <label>Responsable del servicio: </label>
                            <asp:DropDownList ID="cmbResponsableServicioMan" runat="server" AutoPostBack="true" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3">
                            <label>Fecha estimada de finalización: </label>
                            <asp:TextBox ID='datetimepicker4' runat="server" type="text" CssClass="form-control" />
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <asp:LinkButton ID="btnAsignarServicioMan" runat="server" CssClass="btn btn-primary"
                                Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="btnAsignarServicioMan_Click" />
                        </div>
                    </div>
                    <hr />
                    <h3>Agregar Comentario</h3>
                    <div class="row">
                        <div class="col-xs-6 col-sm-2 col-md-2 col-lg-2">
                            <label>Id del Servicio: </label>
                            <asp:TextBox runat="server" ID="txtIdServicioMan" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <label>Comentar: </label>
                            <asp:TextBox ID="txtComentarioMan" runat="server" CssClass="form-control" Rows="2" TextMode="multiline" placeholder="Comentario">
                            </asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <br />
                            <asp:LinkButton ID="btnComentarioMan" runat="server" CssClass="btn btn-primary"
                                Text="Guardar <span class='glyphicon glyphicon-floppy-disk'></span>" OnClick="btnComentarioMan_Click" />
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
                            <asp:TextBox runat="server" ID="txtIdServicioFinMan" CssClass="form-control" placeholder="Id del Servicio"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                            <br />
                            <asp:LinkButton ID="BtnServicioFinMan" runat="server" CssClass="btn btn-primary"
                                Text="Finalizar <span class='glyphicon glyphicon-ok'></span>" OnClick="BtnServicioFinMan_Click" />
                        </div>
                    </div>
                    <hr />
                    <h2>Servicios Asignados a Mantenimiento </h2>
                    <asp:GridView runat="server" ID="dgAbiertosMan" CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <asp:BoundField HeaderText="Area" DataField="Area"></asp:BoundField>
                            <asp:BoundField HeaderText="Equipo" DataField="Equipo"></asp:BoundField>
                            <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                            <asp:BoundField HeaderText="Comentarios" DataField="Comentarios"></asp:BoundField>
                            <asp:BoundField HeaderText="Responsable" DataField="Responsable"></asp:BoundField>
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
                    </asp:GridView>
                    <h2>Servicios Finalizados de Mantenimiento </h2>
                    <asp:GridView runat="server" ID="dgFinalizadosMan" CssClass="table table-bordered table-responsive table-hover table-striped"
                        AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                        <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID"></asp:BoundField>
                            <asp:BoundField HeaderText="Usuario" DataField="Usuario"></asp:BoundField>
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre"></asp:BoundField>
                            <asp:BoundField HeaderText="Incidente" DataField="Incidente"></asp:BoundField>
                            <asp:BoundField HeaderText="Comentarios" DataField="Comentarios"></asp:BoundField>
                            <asp:BoundField HeaderText="Asignado a" DataField="Responsable"></asp:BoundField>
                            <asp:BoundField HeaderText="Estado" DataField="Estado"></asp:BoundField>
                            <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso"></asp:BoundField>
                            <asp:BoundField HeaderText="Ultimo Estado" DataField="Fecha_Estimada_Fin"></asp:BoundField>
                            <asp:BoundField HeaderText="Duracion" DataField="Duración"></asp:BoundField>
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
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
