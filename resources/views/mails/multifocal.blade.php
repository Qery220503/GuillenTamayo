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

        h1, h2, h3, h4{
            color: #043c77;
            text-align: center;
            text-transform: uppercase;
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
            font-size: 22px;
            color: #043c77;
            text-align: center;
            margin-bottom: 40px;
            margin-top: -20px;
        }

        h6 {
            font-size: 16px;
            color: #043c77;
        }

        hr {
            min-width: 80px;
            border-top: solid 4px #043c77;
        }

        .coupons {
            padding: 60px 10px;
        }

        .coupons div {
            max-width: 360px;
            margin: auto;
        }

        .container {
            background-color: #ddeaf8;
            padding: 40px 0px;
        }

        .video {
            background:linear-gradient(0deg, rgba(4, 60, 119, 0.3), rgba(4, 60, 119, 0.3)), url('{{ env("MAIL_IMAGE") }}');
            background-size:cover;
            min-height: 360px;
            display: flex;
        }

        .video a {
            margin: auto;
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
            background-color: rgb(4, 60, 119);
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
            <h3>¡Gracias por tu compra!</h3>
            <h5>Descubre cómo cuidar tus <br>nuevos <b class="orange">lentes multifocales</b></h5>
            <div class="video">
                <a href="https://www.youtube.com/watch?v=mOayPoTcS7U" target=”_blank”><img src="{{ env('ICON_VIDEO') }}" alt="play" width="80px"></a>
            </div>
        </div>
        <div class="coupons">
            <h4>Hola, <b class="orange">{{ ucwords($client->nombre_razon_social) }}</b></h4>
            <div>
                <p>Queremos asegurarnos de que aproveches al máximo tus nuevos <b>lentes multifocales</b>. Hemos preparado un video especial para ti que te guiará a través de los <b>mejores cuidados y consejos</b>.</p>
                <p>Mira el video y no dudes en contactarnos si tienes alguna pregunta.</p>
            </div>
        </div>
        <div class="copyright">
            <p>© 2023 Guillén Tamayo. Todos los derechos reservados.</p>
        </div>
    </div>
</body>
</html>