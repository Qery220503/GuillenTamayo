<html>
<head>
    <title>Cotización #{{ $cotizacion->id_cotizacion }}</title>
    <style>
        body {
            font-size: 12px;
            font-family: Arial, sans-serif;
        }
        table {
            border-spacing: 0;
            border-collapse: collapse;
        }
        .font-md {
            font-size: 12px;
        }
        .font-lg {
            font-size: 14px;
        }
        .font-xlg {
            font-size: 16px;
        }
        .font-bold {
            font-weight: bold;
        }

        .company_logo {
        max-height: 100px;
        }
        .company_logo_box {
        height: 65px;
        }
        .company_no_logo_box {
        height: 20px;
        }
        .company_logo_ticket {
        max-width: 200px;
        max-height: 80px
        }
        .contain {object-fit: cover;}

        .text-right {
            text-align: right !important;
        }
        .text-center {
            text-align: center !important;
        }
        .text-left {
            text-align: left !important;
        }
        .align-top {
            vertical-align: top !important;
        }

        .full-width {
            width: 100%;
        }

        .m-10 {
            margin: 10px;
        }
        .mt-10 {
            margin-top: 10px;
        }
        .mb-10 {
            margin-bottom: 10px;
        }
        .m-20 {
            margin: 20px;
        }
        .mt-20 {
            margin-top: 20px;
        }
        .mb-20 {
            margin-bottom: 20px;
        }

        .p-20 {
            padding: 20px;
        }
        .pt-20 {
            padding-top: 20px;
        }
        .pb-20 {
            padding-bottom: 20px;
        }
        .p-10 {
            padding: 10px;
        }
        .pt-10 {
            padding-top: 10px;
        }
        .pb-10 {
            padding-bottom: 10px;
        }

        .border-box {
            border: thin solid #333;
        }
        .border-top {
            border-top: thin solid #333;
        }
        .border-bottom {
            border-bottom: thin solid #333;
        }
        .border-top-bottom {
            border-top: thin solid #333;
            border-bottom: thin solid #333;
        }

        .bg-grey {
            background-color: #F8F8F8;
        }

        .logo {

        }

        /* Headings */
        h1, h2, h3, h4, h5, h6 {
            font-weight: 200;
            letter-spacing: -1px;
        }

        h1 {
            font-size: 32px;
            line-height: 44px;
            font-weight: 500;
        }

        h2 {
            font-size: 24px;
            font-weight: 500;
            line-height: 42px;
        }

        h3 {
            font-size: 18px;
            font-weight: 400;
            letter-spacing: normal;
            line-height: 24px;
        }

        h4 {
            font-size: 16px;
            font-weight: 400;
            letter-spacing: normal;
            line-height: 27px;
        }

        h5 {
            font-size: 13px;
            font-weight: 300;
            letter-spacing: normal;
            line-height: 18px;
        }

        h6 {
            font-size: 10px;
            font-weight: 300;
            letter-spacing: normal;
            line-height: 18px;
        }

        table, tr, td, th {
            font-size: 12px !important;
        }

        p {
            font-size: 12px !important;
        }

        .desc {
            font-size: 10px !important;
        }
        .desc-8{
            font-size: 8px;
        }
        .desc-9 {
            font-size: 10px !important;
        }

        .desc-12 {
            font-size: 12px !important;
        }


        .m-0 {
        margin: 0 !important;
        }

        .mt-0,
        .my-0 {
        margin-top: 0 !important;
        }

        .mr-0,
        .mx-0 {
        margin-right: 0 !important;
        }

        .mb-0,
        .my-0 {
        margin-bottom: 0 !important;
        }

        .ml-0,
        .mx-0 {
        margin-left: 0 !important;
        }

        .m-1 {
        margin: 0.25rem !important;
        }

        .mt-1,
        .my-1 {
        margin-top: 0.25rem !important;
        }

        .mr-1,
        .mx-1 {
        margin-right: 0.25rem !important;
        }

        .mb-1,
        .my-1 {
        margin-bottom: 0.25rem !important;
        }

        .ml-1,
        .mx-1 {
        margin-left: 0.25rem !important;
        }

        .m-2 {
        margin: 0.5rem !important;
        }

        .mt-2,
        .my-2 {
        margin-top: 0.5rem !important;
        }

        .mr-2,
        .mx-2 {
        margin-right: 0.5rem !important;
        }

        .mb-2,
        .my-2 {
        margin-bottom: 0.5rem !important;
        }

        .ml-2,
        .mx-2 {
        margin-left: 0.5rem !important;
        }

        .m-3 {
        margin: 1rem !important;
        }

        .mt-3,
        .my-3 {
        margin-top: 1rem !important;
        }

        .mr-3,
        .mx-3 {
        margin-right: 1rem !important;
        }

        .mb-3,
        .my-3 {
        margin-bottom: 1rem !important;
        }

        .ml-3,
        .mx-3 {
        margin-left: 1rem !important;
        }

        .m-4 {
        margin: 1.5rem !important;
        }

        .mt-4,
        .my-4 {
        margin-top: 1.5rem !important;
        }

        .mr-4,
        .mx-4 {
        margin-right: 1.5rem !important;
        }

        .mb-4,
        .my-4 {
        margin-bottom: 1.5rem !important;
        }

        .ml-4,
        .mx-4 {
        margin-left: 1.5rem !important;
        }

        .m-5 {
        margin: 3rem !important;
        }

        .mt-5,
        .my-5 {
        margin-top: 3rem !important;
        }

        .mr-5,
        .mx-5 {
        margin-right: 3rem !important;
        }

        .mb-5,
        .my-5 {
        margin-bottom: 3rem !important;
        }

        .ml-5,
        .mx-5 {
        margin-left: 3rem !important;
        }

        .p-0 {
        padding: 0 !important;
        }

        .pt-0,
        .py-0 {
        padding-top: 0 !important;
        }

        .pr-0,
        .px-0 {
        padding-right: 0 !important;
        }

        .pb-0,
        .py-0 {
        padding-bottom: 0 !important;
        }

        .pl-0,
        .px-0 {
        padding-left: 0 !important;
        }

        .p-1 {
        padding: 0.25rem !important;
        }

        .pt-1,
        .py-1 {
        padding-top: 0.25rem !important;
        }

        .pr-1,
        .px-1 {
        padding-right: 0.25rem !important;
        }

        .pb-1,
        .py-1 {
        padding-bottom: 0.25rem !important;
        }

        .pl-1,
        .px-1 {
        padding-left: 0.25rem !important;
        }

        .p-2 {
        padding: 0.5rem !important;
        }

        .pt-2,
        .py-2 {
        padding-top: 0.5rem !important;
        }

        .pr-2,
        .px-2 {
        padding-right: 0.5rem !important;
        }

        .pb-2,
        .py-2 {
        padding-bottom: 0.5rem !important;
        }

        .pl-2,
        .px-2 {
        padding-left: 0.5rem !important;
        }

        .p-3 {
        padding: 1rem !important;
        }

        .pt-3,
        .py-3 {
        padding-top: 1rem !important;
        }

        .pr-3,
        .px-3 {
        padding-right: 1rem !important;
        }

        .pb-3,
        .py-3 {
        padding-bottom: 1rem !important;
        }

        .pl-3,
        .px-3 {
        padding-left: 1rem !important;
        }

        .p-4 {
        padding: 1.5rem !important;
        }

        .pt-4,
        .py-4 {
        padding-top: 1.5rem !important;
        }

        .pr-4,
        .px-4 {
        padding-right: 1.5rem !important;
        }

        .pb-4,
        .py-4 {
        padding-bottom: 1.5rem !important;
        }

        .pl-4,
        .px-4 {
        padding-left: 1.5rem !important;
        }

        .p-5 {
        padding: 3rem !important;
        }

        .pt-5,
        .py-5 {
        padding-top: 3rem !important;
        }

        .pr-5,
        .px-5 {
        padding-right: 3rem !important;
        }

        .pb-5,
        .py-5 {
        padding-bottom: 3rem !important;
        }

        .pl-5,
        .px-5 {
        padding-left: 3rem !important;
        }

        .m-n1 {
        margin: -0.25rem !important;
        }

        .mt-n1,
        .my-n1 {
        margin-top: -0.25rem !important;
        }

        .mr-n1,
        .mx-n1 {
        margin-right: -0.25rem !important;
        }

        .mb-n1,
        .my-n1 {
        margin-bottom: -0.25rem !important;
        }

        .ml-n1,
        .mx-n1 {
        margin-left: -0.25rem !important;
        }

        .m-n2 {
        margin: -0.5rem !important;
        }

        .mt-n2,
        .my-n2 {
        margin-top: -0.5rem !important;
        }

        .mr-n2,
        .mx-n2 {
        margin-right: -0.5rem !important;
        }

        .mb-n2,
        .my-n2 {
        margin-bottom: -0.5rem !important;
        }

        .ml-n2,
        .mx-n2 {
        margin-left: -0.5rem !important;
        }

        .m-n3 {
        margin: -1rem !important;
        }

        .mt-n3,
        .my-n3 {
        margin-top: -1rem !important;
        }

        .mr-n3,
        .mx-n3 {
        margin-right: -1rem !important;
        }

        .mb-n3,
        .my-n3 {
        margin-bottom: -1rem !important;
        }

        .ml-n3,
        .mx-n3 {
        margin-left: -1rem !important;
        }

        .m-n4 {
        margin: -1.5rem !important;
        }

        .mt-n4,
        .my-n4 {
        margin-top: -1.5rem !important;
        }

        .mr-n4,
        .mx-n4 {
        margin-right: -1.5rem !important;
        }

        .mb-n4,
        .my-n4 {
        margin-bottom: -1.5rem !important;
        }

        .ml-n4,
        .mx-n4 {
        margin-left: -1.5rem !important;
        }

        .m-n5 {
        margin: -3rem !important;
        }

        .mt-n5,
        .my-n5 {
        margin-top: -3rem !important;
        }

        .mr-n5,
        .mx-n5 {
        margin-right: -3rem !important;
        }

        .mb-n5,
        .my-n5 {
        margin-bottom: -3rem !important;
        }

        .ml-n5,
        .mx-n5 {
        margin-left: -3rem !important;
        }

        .m-auto {
        margin: auto !important;
        }

        .mt-auto,
        .my-auto {
        margin-top: auto !important;
        }

        .mr-auto,
        .mx-auto {
        margin-right: auto !important;
        }

        .mb-auto,
        .my-auto {
        margin-bottom: auto !important;
        }

        .ml-auto,
        .mx-auto {
        margin-left: auto !important;
        }
        .prices_table{
        border-collapse: separate;
        border-spacing: 0 5px;
        width: 100%;
        height: 70px !important;
        }
        .price {
            text-align: center;
            background-color: #EEEEEE;
            vertical-align: middle;
        }
        .price-title{
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body>
@php
{{
    /*
    function getRefraccion($ojo){
        $esfera = ($ojo["esfera"] != null || "") ? $ojo["esfera"] : " ";
        $cilindro = ($ojo["cilindro"] != null || "") ? $ojo["cilindro"] : " ";
        $eje = ($ojo["eje"] != null || "") ? $ojo["eje"] : " ";
        $adicion = ($ojo["adicion"] != null || "") ? $ojo["adicion"] : " ";
        $dip = ($ojo["dip"] != null || "") ? $ojo["dip"] : " ";
        $alt = ($ojo["alt"] != null || "") ? $ojo["alt"] : " ";
        $prismas = ($ojo["prismas"] != null || "") ? $ojo["prismas"] : " ";
        $avcc = ($ojo["avcc"] != null || "") ? $ojo["avcc"] : " ";
        return "ESF: $esfera CIL: $cilindro EJE: $eje ADIC: $adicion DIP: $dip ALT: $alt PRISM: $prismas";
    }
    $rc = $cotizacion->refraccion_cerca;
    $rl = $cotizacion->refraccion_lejos;
    $od_rc = getRefraccion($rc["od"]);
    $oi_rc = getRefraccion($rc["oi"]);
    $od_rl = getRefraccion($rl["od"]);
    $oi_rl = getRefraccion($rl["oi"]);
    */

    function getTotal($detalles){
        $total = 0;
        foreach ($detalles as $detalle) {
            if($detalle["producto"] != null){
                $total += $detalle['producto']['precio_venta'];
            }
            if($detalle["precio_lente"] != null){
                $total += $detalle['precio_lente']['precio_venta'];
            }
        }
        return number_format($total, 2, '.', ' ');
    }


    $totalCotizacion = getTotal($detalle);
}}
@endphp

<div class="text-center company_logo_box pt-5">
    <img src="{{ asset('/images/illustrations/logo.png') }}" alt="Company logo" class="company_logo_ticket contain" /><br>
    <p>GAL.GAMESA INT. 21 AREQUIPA - AREQUIPA -AREQUIPA</p>
</div>

<table class="full-width">
    <tr>
        <td class="text-center pt-3 border-top border-bottom"><h4>Cotización {{$cotizacion->serie->serie}}-{{sprintf("%08s", $cotizacion->correlativo)}}</h4></td><br>
    </tr>
</table>

<table class="full-width">
    <tr>
        <td width="45%" class="pt-1"><p class="desc"><b>Fecha de Emisión:</b></p></td>
        <td width="" class="pt-1"><p class="desc">{{  $cotizacion->created_at }}</p></td>
    </tr>
    @if($cotizacion->cliente != null)
      <tr>
          <td class="align-top pt-2"><p class="desc"><b>Paciente:</b></p></td>
          <td class="pt-2"><p class="desc">{{ $cotizacion->cliente->nombre_razon_social }}</p></td>
      </tr>
    @endif
    @if($cotizacion->anamnesis != null && $cotizacion->anamnesis->clinica != null)
      <tr>
          <td class="desc pt-1"><b>Clínica: </b></td>
          <td class="desc pt-1">{{ $cotizacion->anamnesis->clinica->nombre_clinica }}</td>
      </tr>
    @endif
</table>


<!--<table class="full-width mt-10 mb-10">
    <thead class="">
        <tr>
            <th class="border-top-bottom desc-12 text-center" colspan="2">Lejos</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="text-center desc-12 text-left"><b>O.D &nbsp;&nbsp;</b></td>
            <td class="text-center desc-12 text-left">$od_rl</td>
        </tr>
        <tr>
            <td colspan="2" class="border-top"></td>
        </tr>
        <tr>
            <td class="text-center desc-12 text-left"><b>O.I&nbsp;&nbsp;</b></td>
            <td class="text-center desc-12 text-left">$oi_rl </td>
        </tr>
            
    </tbody>
</table>-->

<!-- <table class="full-width mt-10 mb-10">
    <thead class="">
        <tr>
            <th class="border-top-bottom desc-12 text-center" colspan="2">Cerca</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="text-center desc-12 text-left"><b>O.D</b></td>
            <td class="text-center desc-12 text-left"> $od_rc </td>
        </tr>
        <tr>
            <td colspan="2" class="border-top"></td>
        </tr>
        <tr>
            <td class="text-center desc-12 text-left"><b>O.I</b></td>
            <td class="text-center desc-12 text-left"> $oi_rc </td>
        </tr>
        
    </tbody>
</table>-->

@foreach($detalle as $d)
    @if($d["producto"] != null || $d["precio_lente"] != null)
    <hr>
        <table class="full-width">
            <thead>
                <tr>
                    <th style="text-align: center; background-color: #EEEEEE; border-bottom:1px solid #FFFFFF" colspan="2">
                        <h6><b>ALTERNATIVA {{ $loop->index + 1}}</b></h6>
                    </th>
                </tr>
              </thead>
            <tbody>
                @if($d["producto"] != null)
                <tr>
                    <td colspan="2" style="text-align: start; background-color: #EEEEEE; border-bottom:1px solid #E8E8E8">
                        <h6>
                            <b>
                                Montura
                            </b>
                        </h6>
                    </td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Producto: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["producto"]["nombre_producto"] }}</p></td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Marca: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["producto"]["marca"]["marca_producto"] }}</p></td>
                </tr>
                @if($d["producto"]["material"])
                <tr>
                    <td class="desc pt-3 desc-10"><b>Material: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["producto"]["material"]["nombre_material"] }}</p></td>
                </tr>
                @endif
                <tr>
                    <td class="desc pt-3 desc-10"><b>T. de montura: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["montura"] }}</p></td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Montaje: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["montaje"] }}</p></td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Precio: </b></td>
                    <td class="desc pt-3 desc-10"><p> S/. {{ $d["producto"]["precio_venta"] }}</p></td>
                </tr>
                @endif
                @if($d["precio_lente"] != null)
                <tr>
                    <td colspan="2" style="text-align: start; background-color: #EEEEEE; border-bottom:1px solid #E8E8E8">
                        <h6>
                            <b>
                                Lunas
                            </b>
                        </h6>
                    </td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Nombre comercial: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["precio_lente"]["nombre_propio"] }}</p></td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Nombre laboratorio: </b></td>
                    <td class="desc pt-3 desc-10"><p>{{ $d["precio_lente"]["nombre_laboratorio"] }}</p></td>
                </tr>
                <tr>
                    <td class="desc pt-3 desc-10"><b>Precio:</b></td>
                    <td class="desc pt-3 desc-10"><p> S/. {{ $d["precio_lente"]["precio_venta"] }}</p></td>
                </tr>
                @endif
            </tbody>
        </table>
    @endif
@endforeach
<br>
<table class="prices_table">
    <tbody>
        <tr>
            <td colspan="7" style="text-align:right" class="price-title desc pt-3 desc-10">
                <b>Total:</b>
            </td>
            <td colspan="2" class="price" height="30">
                 <span>S/.{{ $totalCotizacion }}</span>
            </td>
        </tr>
        <tr style="margin-top: 10px">
            <td colspan="7" style="text-align:right" class="price-title desc pt-3 desc-10">
                <b>Cobertura:</b>
            </td>
            <td colspan="2" class="price" height="30">
            </td>
          </tr>
        <tr style="margin-top: 10px">
            <td colspan="7" style="text-align:right;" class="price-title desc pt-3 desc-10">
                <b>Saldo:</b>
            </td>
            <td colspan="2" class="price" height="30">
            </td>
         </tr>
      </tbody>
</table>

<table class="full-width">
    <tr>
        <td class="desc pt-3" style="text-align:justify;" colspan="2"><b>Importante:</b><br>
            1) <b>Centro Óptico Guillén Tamayo</b>, a excepción de la garantía extendida, no se responsabiliza por el mal cuidado de los lentes (Lunas Ópticas). Una vez entregado el trabajo y dada la conformidad del cliente no hay lugar a reclamos posteriores por rayos, quiños, etc.<br><br>
            
            2) A excepción de una coordinación previa con el cliente, luego de los 30 días calendario de la fecha pactada de recojo, el Centro Óptico Guillén Tamayo S.R.L. se reserva el derecho de disponer los trabajos no recogidos para los fines que se vean por convenientes.
        </td>
    </tr>
    <tr>
        <td class="text-center desc pt-5"><br>
            ______________________<br>
            <br>Firma Vendedor<br>
        </td>
        <td class="text-center desc pt-5"><br>
            ______________________<br>
            <br>Firma Cliente<br>
        </td>
    </tr>
    <tr>
        <td class="text-center desc pt-5" colspan="2"><br>
            ________________________________<br>
        </td>
    </tr>
</table>
</body>
</html>