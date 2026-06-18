<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonitorMantenimiento.aspx.cs" Inherits="Tickets2.MonitorMantenimiento" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>Monitor de Tickets Mantenimiento</title>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery-2.1.3.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/FormContactos.css"/>
        <script>setTimeout('document.location.reload()', 120000); </script>
        <style type="text/css">
	        .table-striped > tbody > tr:nth-child(odd), .table-striped > tbody > tr:nth-child(odd) {
	            background-color: #bfd8eb;
	        }
	        .table-hover > tbody > tr:hover {
	            background-color: #9fb8cb;
	        }
	    </style>
        <script type="text/javascript">

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
        <form id="Form1" runat ="server">
            <div class="container col-xs-0 col-sm-0 col-md-0 col-lg-1">
            </div>
            <div class="container col-xs-12 col-sm-12 col-md-12 col-lg-10">
                <div class="row">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <center><img src="MrLucky.jpeg" class="img-responsive img-circle" alt="mrlucky"/></center>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                        <center><h1>Monitor de Tickets de Mantenimiento</h1></center>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                        <center><img src="gab.jpg" class="img-responsive" alt="mrlucky"/></center>
                    </div>
                </div>
                <br/>
                <h2>Servicios Solicitados</h2>
                <asp:GridView runat ="server" ID="dgSolicitadosMan" CssClass="table table-bordered table-responsive table-hover table-striped"
                    AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                    <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>                           
                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha_de_Ingreso" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Solicitado A" DataField="Responsable" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Area" DataField="Area" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Equipo" DataField="Equipo" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Incidente" DataField="Incidente" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Estado" DataField="Estado" >
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Foto">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkView" CssClass="btn btn-primary" Text="Foto" runat="server"
                                    data-toggle="modal" data-target="#myModal">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <!--Modal-->
                <div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Evidencia</h4>
                        </div>
                        <div class="modal-body">

                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">

                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="4"></li>
                                </ol>

                                <!-- Wrapper for slides -->
                                <div class="carousel-inner">
                                <div class="item active">
                                    <center><img class="img-responsive" id="foto11" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="foto12" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                    <div class="item">
                                    <center><img class="img-responsive" id="foto13" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="foto14" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="foto15" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                </div>

                                <!-- Controls -->
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
                <!---->
                <!--Modal-->
                <div class="modal fade bs-example-modal-lg" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="H1">Evidencia</h4>
                        </div>
                        <div class="modal-body">

                            <div id="carousel-example-generic2" class="carousel slide" data-ride="carousel" data-interval="false">

                                <!-- Indicators -->
                                <ol class="carousel-indicators">
                                    <li data-target="#carousel-example-generic2" data-slide-to="0" class="active"></li>
                                    <li data-target="#carousel-example-generic2" data-slide-to="1"></li>
                                    <li data-target="#carousel-example-generic2" data-slide-to="2"></li>
                                    <li data-target="#carousel-example-generic2" data-slide-to="3"></li>
                                    <li data-target="#carousel-example-generic2" data-slide-to="4"></li>
                                </ol>

                                <!-- Wrapper for slides -->
                                <div class="carousel-inner">
                                <div class="item active">
                                    <center><img class="img-responsive" id="Img1" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="Img2" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                    <div class="item">
                                    <center><img class="img-responsive" id="Img3" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="Img4" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                <div class="item">
                                    <center><img class="img-responsive" id="Img5" src=""></center>
                                    <div class="carousel-caption">
                                    </div>
                                </div>
                                </div>

                                <!-- Controls -->
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
                <!---->
                <br />
                <h2>Servicios Asignados a Mantenimiento </h2>
                <asp:GridView runat ="server" ID="dgAbiertosMan" CssClass="table table-bordered table-responsive table-hover table-striped"
                    AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                    <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>                           
                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID" >
                        </asp:BoundField>                                
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Area" DataField="Area" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Equipo" DataField="Equipo" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Incidente" DataField="Incidente" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Comentarios" DataField="Comentarios" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Responsable" DataField="Responsable" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso" >
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Fecha Estimada Fin" DataField="Fecha_Estimada_Fin" >
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Foto">
                            <ItemTemplate>
                                <center><asp:LinkButton ID="lnkView" CssClass="btn btn-primary" Text="Antes" runat="server"
                                    data-toggle="modal" data-target="#myModal">
                                </asp:LinkButton></center>
                                <br />
                                <center><asp:LinkButton ID="lnkView2" CssClass="btn btn-primary" Text="Despues" runat="server"
                                    data-toggle="modal" data-target="#myModal2">
                                </asp:LinkButton></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </form>
    </body>
</html>

