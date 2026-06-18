<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonitorTickets.aspx.cs" Inherits="Tickets2.Montito_Tickets" %> 

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monitor de Tickets</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery-2.1.3.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/PaginacionGrid.css"/>

    <script type="text/javascript">
        $(document).ready(function(){
            $('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
                localStorage.setItem('activeTab', $(e.target).attr('href'));
            });
            var activeTab = localStorage.getItem('activeTab');
            if(activeTab){
                $('#tablas a[href="' + activeTab + '"]').tab('show');
            }
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
            $("#foto21").attr('src', 'FotosManto/' + folio + '1.jpg');
            $("#foto22").attr('src', 'FotosManto/' + folio + '2.jpg');
            $("#foto23").attr('src', 'FotosManto/' + folio + '3.jpg');
            $("#foto24").attr('src', 'FotosManto/' + folio + '4.jpg');
            $("#foto25").attr('src', 'FotosManto/' + folio + '5.jpg');
        });

        $(document).on("click", "[id*=lnkView22]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#Img1").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
            $("#Img2").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
            $("#Img3").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
            $("#Img4").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
            $("#Img5").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');
        });

        $(document).on("click", "[id*=lnkView3]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#foto31").attr('src', 'FotosManto/' + folio + '1.jpg');
            $("#foto32").attr('src', 'FotosManto/' + folio + '2.jpg');
            $("#foto33").attr('src', 'FotosManto/' + folio + '3.jpg');
            $("#foto34").attr('src', 'FotosManto/' + folio + '4.jpg');
            $("#foto35").attr('src', 'FotosManto/' + folio + '5.jpg');
        });

        $(document).on("click", "[id*=lnkView33]", function () {
            var folio = $(".ID", $(this).closest("tr")).html();
            $("#Img6").attr('src', 'FotosManto/Finalizado/' + folio + '1.jpg');
            $("#Img7").attr('src', 'FotosManto/Finalizado/' + folio + '2.jpg');
            $("#Img8").attr('src', 'FotosManto/Finalizado/' + folio + '3.jpg');
            $("#Img9").attr('src', 'FotosManto/Finalizado/' + folio + '4.jpg');
            $("#Img10").attr('src', 'FotosManto/Finalizado/' + folio + '5.jpg');
        });

    </script>
    <script>setTimeout('document.location.reload()', 300000); </script>
    <style type="text/css">
	    .table-striped > tbody > tr:nth-child(odd), .table-striped > tbody > tr:nth-child(odd) {
	        background-color: #bfd8eb;
	    }
	    .table-hover > tbody > tr:hover {
	        background-color: #9fb8cb;
	    }
	</style>
</head>
    <body>
        <form id="Form1" runat="server">
        <div class="container col-xs-0 col-sm-0 col-md-0 col-lg-1">
        </div>
        <div class="container col-xs-12 col-sm-12 col-md-12 col-lg-10">
            <div class="row">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center><img src="MrLucky.jpeg" class="img-responsive img-circle" alt="mrlucky"/></center>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <center><h1>Sistema de Tickets de Soporte Técnico</h1></center>
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <center><img src="gab.jpg" class="img-responsive" alt="mrlucky"/></center>
                </div>
            </div>
            <br/>
			<ul class="nav nav-tabs nav-justified" id="tablas">
                <li><a href="PaginaLogin.aspx" class="btn btn-default">Inicio <span class="glyphicon glyphicon-home" aria-hidden="true"></span></a></li>
				<li class="active"><a data-toggle="tab" href="#solicitados">Solicitados <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></a></li>
				<li><a data-toggle="tab" href="#asignados">Asignados <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></a></li>
				<li><a data-toggle="tab" href="#finalizados">Finalizados <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span></a></li>
			    <li><a href="MonitorTickets.aspx" class="btn btn-primary">Refrescar <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></a></li>
                <li><a href="PaginaLogin.aspx" class="btn btn-success">Agregar <span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a></li>
            </ul>
			<!-- Creo los contenedores -->
			    <div class="tab-content">
                    <div class="tab-pane fade in active" id="solicitados">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						        <center><h1>Solicitudes Hechas</h1></center>
					        </div>
                        </div>
                        <asp:GridView runat ="server" ID="dgSolicitados" CssClass="table table-bordered table-responsive table-hover table-striped"
                            AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true">
                            <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>                           
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Fecha" DataField="Fecha" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Solicitado A" DataField="Solicitado_A" >
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
                                          <%
                                          for (int i = 1; i < 5; i++)
                                          {
                                              Response.Write("<div class='item'><center><img class='img-responsive' id='foto1" + (i + 1).ToString() + "' src=''></center><div class='carousel-caption'></div></div>");
                                          }
                                          %>
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
				    </div>	
				    <div class="tab-pane fade" id="asignados">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						        <center><h1>Tickets Abiertos/Asignados</h1></center>
					        </div> 
                        </div>
                        <asp:GridView runat ="server" ID="dgAbiertos" CssClass="table table-bordered table-responsive table-hover table-striped"
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
                                <asp:BoundField HeaderText="Asignado a" DataField="Asignado_A" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Responsable" DataField="Responsable" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_Ingreso" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Fecha Estimada Fin" DataField="Fecha_Estimada_Fin" >
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Foto">
                                    <ItemTemplate>
                                        <center><asp:LinkButton ID="lnkView2" CssClass="btn btn-primary" Text="Antes" runat="server"
                                            data-toggle="modal" data-target="#myModal2">
                                        </asp:LinkButton></center>
                                        <br />
                                        <center><asp:LinkButton ID="lnkView22" CssClass="btn btn-primary" Text="Despues" runat="server"
                                            data-toggle="modal" data-target="#myModal22">
                                        </asp:LinkButton></center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <!--Modal-->
                        <div class="modal fade bs-example-modal-lg" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="H1">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carrusel2" class="carousel slide" data-ride="carousel" data-interval="false">

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
                                          <center><img class="img-responsive" id="foto21" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto22" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                         <div class="item">
                                          <center><img class="img-responsive" id="foto23" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto24" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto25" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                      </div>

                                      <!-- Controls -->
                                      <a class="left carousel-control" href="#carrusel2" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                      </a>
                                      <a class="right carousel-control" href="#carrusel2" role="button" data-slide="next">
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
                        <div class="modal fade bs-example-modal-lg" id="myModal22" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="H3">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carrusel22" class="carousel slide" data-ride="carousel" data-interval="false">

                                        <!-- Indicators -->
                                        <ol class="carousel-indicators">
                                            <li data-target="#carrusel22" data-slide-to="0" class="active"></li>
                                            <li data-target="#carrusel22" data-slide-to="1"></li>
                                            <li data-target="#carrusel22" data-slide-to="2"></li>
                                            <li data-target="#carrusel22" data-slide-to="3"></li>
                                            <li data-target="#carrusel22" data-slide-to="4"></li>
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
                                      <a class="left carousel-control" href="#carrusel22" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                      </a>
                                      <a class="right carousel-control" href="#carrusel22" role="button" data-slide="next">
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
				    </div>
				    <div class="tab-pane fade" id="finalizados">
                        <div class="row">
                            <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
						        <center><h1>Tickets Finalizados</h1></center>
					        </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                <br />
                                <asp:TextBox runat="server" ID="txtID_Search_Finalizados" CssClass="form-control" placeholder="ID Usuario"> </asp:TextBox>
					        </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                <br />
                                <asp:LinkButton ID="btnBuscar_Finalizados" runat="server" CssClass="btn btn-primary" 
                                    Text="Buscar <span class='glyphicon glyphicon-search'></span>" OnClick="btnBuscar_Finalizados_Click"/>
                            </div>
                        </div>
                        <asp:GridView runat ="server" ID="dgFinalizados" CssClass="table table-bordered table-responsive table-hover table-striped"
                            AllowPaging="True" PageSize="10" AutoGenerateColumns="false" EmptyDataText="No hay servicios" ShowHeaderWhenEmpty="true"
                            OnPageIndexChanging="dgFinalizados_PageIndexChanging">
                            <HeaderStyle BackColor="#4682B4" Font-Bold="True" ForeColor="Black"></HeaderStyle>                           
                            <Columns>
                                <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="ID" >
                                </asp:BoundField> 
                                <asp:BoundField HeaderText="Usuario" DataField="Usuario" >
                                </asp:BoundField>                               
                                <asp:BoundField HeaderText="Nombre" DataField="Nombre" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Incidente" DataField="Incidente" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Comentarios" DataField="Comentarios" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Asignado a" DataField="Asignado_A" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Estado" DataField="Estado" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Fecha Ingreso" DataField="Fecha_de_Ingreso" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Ultimo Estado" DataField="Fecha_de_último_Estado" >
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Duracion" DataField="Duración" >
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Foto">
                                    <ItemTemplate>
                                        <center><asp:LinkButton ID="lnkView3" CssClass="btn btn-primary" Text="Antes" runat="server"
                                            data-toggle="modal" data-target="#myModal3">
                                        </asp:LinkButton></center>
                                        <br />
                                        <center><asp:LinkButton ID="lnkView33" CssClass="btn btn-primary" Text="Despues" runat="server"
                                            data-toggle="modal" data-target="#myModal33">
                                        </asp:LinkButton></center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <!--Modal-->
                        <div class="modal fade bs-example-modal-lg" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="H2">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carrusel3" class="carousel slide" data-ride="carousel">

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
                                          <center><img class="img-responsive" id="foto31" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto32" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                         <div class="item">
                                          <center><img class="img-responsive" id="foto33" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto34" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="foto35" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                      </div>

                                      <!-- Controls -->
                                      <a class="left carousel-control" href="#carrusel3" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                      </a>
                                      <a class="right carousel-control" href="#carrusel3" role="button" data-slide="next">
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
                        <div class="modal fade bs-example-modal-lg" id="myModal33" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="H4">Evidencia</h4>
                                </div>
                                <div class="modal-body">

                                    <div id="carrusel33" class="carousel slide" data-ride="carousel">

                                        <!-- Indicators -->
                                        <ol class="carousel-indicators">
                                            <li data-target="#carrusel33" data-slide-to="0" class="active"></li>
                                            <li data-target="#carrusel33" data-slide-to="1"></li>
                                            <li data-target="#carrusel33" data-slide-to="2"></li>
                                            <li data-target="#carrusel33" data-slide-to="3"></li>
                                            <li data-target="#carrusel33" data-slide-to="4"></li>
                                        </ol>

                                      <!-- Wrapper for slides -->
                                      <div class="carousel-inner">
                                        <div class="item active">
                                          <center><img class="img-responsive" id="Img6" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="Img7" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                         <div class="item">
                                          <center><img class="img-responsive" id="Img8" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="Img9" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                        <div class="item">
                                          <center><img class="img-responsive" id="Img10" src=""></center>
                                          <div class="carousel-caption">
                                          </div>
                                        </div>
                                      </div>

                                      <!-- Controls -->
                                      <a class="left carousel-control" href="#carrusel33" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left"></span>
                                      </a>
                                      <a class="right carousel-control" href="#carrusel33" role="button" data-slide="next">
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
				    </div>
			    </div>
        </div>
        </form>
    </body>
</html>
