
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
        <title>{{ $compra->correlativo }}</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
    </head>
    <body>
        <div class="invoice-box">
			<table cellpadding="0" cellspacing="0">
				<tr class="top">
					<td colspan="4">
						<table>
							<tr>
								<td class="title">
									<img src="{{ asset('/images/illustrations/logo.png') }}" alt="Company logo" style="width: 100%; max-width: 300px" />
                                    <p style="font-size: 14px">Dirección: {{ $compra->sucursal['direccion_comercial'] }}</p>
								</td>

								<td style="text-align: right;font-size: 16px;">
                                    <table>
                                        <tr>
                                            <td style="border: 1px solid; text-align: center;">
                                                <div style="padding: 10px;">
                                                    <br>
                                                    Compra
                                                    <br>
                                                    <div style="font-size: 20px;">
                                                        <strong>#{{ $compra->correlativo }}</strong>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    
								</td>
							</tr>
						</table>
					</td>
				</tr>
            </table>
            <table cellpadding="0" cellspacing="0">
				<tr class="information">
					<td colspan="4">
						<table>
							<tr>
								<td  style="font-size: 14px">
                                    <strong>Guia/Factura:</strong>&nbsp;&nbsp;&nbsp;&nbsp;{{ $compra->guia_factura }}<br />
									<strong>Fecha:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{ $compra->fecha_parse }}<br />
                                    <strong>Proveedor:</strong>&nbsp;&nbsp;&nbsp;&nbsp;{{ $compra->proveedor['nombre'] }}<br />
                                    <strong>Dirección:</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{ $compra->proveedor['direccion'] }}
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr class="heading">
                    <td style="width: 13%">Cant.</td>
                    <td style="width: 57%">Detalle</td>
                    <td style="width: 15%">P.U</td>
                    <td style="width: 15%">P.T</td>
				</tr>
                @foreach($compra->detalle as $d)
                    <tr class="item">
                        <td class="quantity">{{ $d['cantidad'] }}</td>
                        <td class="description">{{ $d['nombre_producto'] }}</td>
                        <td class="price">S/. {{ $d['precio_compra'] }}</td>
                        <td class="price">S/. {{ $d['precio_total'] }}</td>
                    </tr>
                @endforeach
                <tr>
                    <td colspan="3" style="text-align:right;"><b>Subtotal: </b></td>
                    <td colspan="1" class="price">S/. {{ $compra->subtotal }}</td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:right;"><b>IGV (18%): </b></td>
                    <td colspan="1"  class="price">S/. {{ $compra->igv }}</td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:right;"><b>Total: </b></td>
                    <td colspan="1"  class="price">S/. {{ $compra->total }}</td>
                </tr>
			</table>


            <br/>
            <br/>
            <div>Detalle de Pagos:</div>
            <br/>
            <table style="width: 300px;">
                <tr class="heading">
                    <td>Fecha</td>
                    <td>Pago</td>
                </tr>
                @foreach($compra->pagos_deuda as $d)
                <tr class="item">
                    <td>{{ $d['fecha'] }}</td>
                    <td>S/. {{ $d['monto_abonado'] }}</td>
                </tr>
                @endforeach
            </table>
		</div>
    </body>
</html>
<style>
    body {
        font-size: 14px;
        font-family: Arial, sans-serif;
    }
    .invoice-box {
        max-width: 800px;
        margin: auto;
        padding: 30px;
        border: 1px solid #eee;
        font-size: 16px;
        line-height: 24px;
        font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        color: #555;
    }

    .invoice-box table {
        width: 100%;
        line-height: inherit;
        text-align: left;
    }

    .invoice-box table td {
        padding: 5px;
        vertical-align: top;
    }

    .invoice-box table tr td:nth-child(4) {
        text-align: right;
    }

    .invoice-box table tr.top table td {
        padding-bottom: 20px;
    }

    .invoice-box table tr.top table td.title {
        font-size: 30px;
        line-height: 30px;
        color: #333;
    }

    .invoice-box table tr.information table td {
        padding-bottom: 40px;
    }

    .invoice-box table tr.heading td {
        background: #eee;
        border-bottom: 1px solid #ddd;
        font-weight: bold;
    }

    .invoice-box table tr.details td {
        padding-bottom: 20px;
    }

    .invoice-box table tr.item td {
        border-bottom: 1px solid #eee;
    }

    .invoice-box table tr.item.last td {
        border-bottom: none;
    }

    .invoice-box table tr.total td:nth-child(2) {
        border-top: 2px solid #eee;
        font-weight: bold;
    }

    @media only screen and (max-width: 600px) {
        .invoice-box table tr.top table td {
            width: 100%;
            display: block;
            text-align: center;
        }

        .invoice-box table tr.information table td {
            width: 100%;
            display: block;
            text-align: center;
        }
    }

    /** RTL **/
    .invoice-box.rtl {
        direction: rtl;
        font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
    }

    .invoice-box.rtl table {
        text-align: right;
    }

    .invoice-box.rtl table tr td:nth-child(2) {
        text-align: left;
    }
</style>
