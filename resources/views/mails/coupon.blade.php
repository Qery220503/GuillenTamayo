<!DOCTYPE html>
<html>

<head>
    <style>


        body {
            font-family: Tahoma, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .email-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: #f0f0f0;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            padding: 30px 10px; 
            display: flex; 
            justify-content: center;
            align-items: center;
            align-content: center;
        }
        .header img {
            max-width: 250px;
        }

        .discount {
            font-size: 100px;
            color: rgb(4, 60, 119);
            font-weight:900;
        }

        .ticket {
            background-color: #f0f0f0;
            border: 2px solid #ccc;
            padding: 20px;
            margin: 20px;
            border-radius: 5px;
            border-style: dashed
        }

        .ticket-code {
            font-size: 24px;
            font-weight: bold;
            color: rgb(4, 60, 119);
        }

        .content {
            padding: 0px 40px;
        }

        .disclaimer {
            text-align: center;
            padding: 40px 50px;
            color: #888;
            font-size: 12px;
            background-color: rgb(4, 60, 119);
            text-align: center;
            border-radius: 5px 5px 5px 5px;
        }

        .signature {
            
            font-size: 12px;
            text-align: center;
            padding: 20px 0;
            color: black;
            
        }
    </style>
</head>

<body>
    <div class="email-container">
        <div class="header" style="text-align: center;">
            <img src="{{ env('LOGO_URL') }}" alt="Logo de Guillén Tamayo">
        </div>

        <div>
            <img style="width: 100%" src="{{ env('MAIL_IMAGE') }}" alt="Logo de Guillén Tamayo">
        </div>

        <div class="content">
            <div style="width: 100%; padding: 10px;">
                <span style="font-size: 25px">Hola, <strong style="color: rgb(4, 60, 119);">{{ ucwords($client->nombre_razon_social) }}</strong></span><br/> 
                <span style="font-size: 25px">Tenemos un regalo para tí</span>
            </div>
        </div>
        <div style="text-align: center; padding: 5px 50px;">
            <span style="font-size: 100px; font-weight: bold; color: #333;">20%</span><br/>
            <span style="font-size: 15px">De descuento en tu próxima compra</span>
        </div>

        <div class="content">
            <div class="ticket">
                <p style="text-align: center; font-size: 15px;">Código de descuento:</p>
                <p style="text-align: center; font-size: 25px; font-weight: bold; color: rgb(4, 60, 119);">{{ $coupon->codigo_cupon }}</p>
                <p style="text-align: center; font-size: 15px;">Fecha de Vencimiento: {{ $coupon->fecha_vencimiento }}</p>
            </div>
            <div class="signature">
                <p style="font-size: 15px">Con cariño,</p>
                <p style="font-size: 15px">Todos los que hacen Guillén Tamayo</p>
            </div>

        </div>

        <div class="disclaimer">
            <p>© 2023 Guillén Tamayo. Todos los derechos reservados</p>
        </div>
    </div>
</body>

</html>
