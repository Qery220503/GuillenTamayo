<!DOCTYPE html>
<html>

<head>
    <style>
        body {
            font-family: Tahoma, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        p {
            text-align: center;
            color: #000000;
        }

        h1, h2, h3, h4, h5, h6{
            color: #043c77;
            text-align: center;
            text-transform: uppercase;
            margin: 10px;
        }

        h1 {
            font-size: 46px;
        }

        h2 {
            font-size: 40px;
        }

        h3 {
            font-size: 34px;
        }

        h4 {
            font-size: 28px;
            margin: 0;
        }

        h5 {
            margin-bottom: -10px;
            font-size: 22px;
        }

        h6 {
            font-size: 16px;
        }

        hr {
            min-width: 80px;
            border-top: solid 4px #043c77;
        }

        .date {
            max-width: 340px;
            margin: auto;
            display: flex;
            justify-content: space-between;
        }

        .date div {
            margin: auto;
        }

        .date h2 {
            margin-bottom: 2px;
            font-weight: 800;
        }

        .coupons {
            padding: 60px 10px;
        }

        .coupon {
            background-image: url('https://i.ibb.co/khcM5Sp/coupon.png');
            background-size: cover;
            padding: 20px;
            max-width: 200px;
            min-height: 80px;
            margin: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .coupon h3 {
            position: relative;
            z-index: 1;
            color: #ffffff;
            margin: auto;
        }

        .container {
            background-color: #ddeaf8;
            padding: 60px 10px;
        }

        .email-container {
            max-width: 580px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.15);
        }

        .header {
            padding: 20px 10px; 
            display: flex; 
        }
        .header img {
            max-width: 300px;
            margin: auto;
        }

        .copyright {
            background-color: #043c77;
            margin: -20px;
            margin-top: 20px;
            min-height: 140px;
            border-radius: 0 0 10px 10px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .copyright p {
            color: #ffffff;
            margin: auto;
        }

        .orange {
            color: #e15524;
        }
    </style>
</head>

<body>
    <div class="email-container">
        <div class="header">
            <img src="{{ env('LOGO_URL') }}" alt="Logo de Guillén Tamayo">
        </div>
        <div class="container">
            <h1>20% DSCTO</h1>
            <h5 class="orange">en tu próxima <br>compra</h5>
            <img src="{{ env('MAIL_BANNER') }}" alt="Lentes" width="100%">
            <h6>el cupón vence el:</h6>
            <div class="date">
                <div>
                    <h2>{{ date("d",strtotime($coupon->fecha_vencimiento)) }}</h2>
                    <hr>
                    <h5>día</h5>
                </div>
                <div>
                    <h2>{{ date("m",strtotime($coupon->fecha_vencimiento)) }}</h2>
                    <hr>
                    <h5>mes</h5>
                </div>
                <div>
                    <h2>{{ date("y",strtotime($coupon->fecha_vencimiento)) }}</h2>
                    <hr>
                    <h5>año</h5>
                </div>
            </div>
        </div>
        <div class="coupons">
            <h4>Hola, <b class="orange">{{ ucwords($client->nombre_razon_social) }}</b></h4>
            <p>Utiliza el <b>código del cupón</b> que aparece abajo<br> para obtener un <b>20% de descuento</b> en cualquiera de<br> nuestros productos.</p>
            <div class="coupon">
                <h3>{{ $coupon->codigo_cupon }}</h3>
            </div>
        </div>
        <div class="copyright">
            <p>© 2023 Guillén Tamayo. Todos los derechos reservados.</p>
        </div>
    </div>
</body>
</html>
