<!DOCTYPE html>
<html>

<head>
    
    <style>
        @font-face {
            font-family: 'Quicksand';
            src: url("{{ asset('fonts/QuickSand/Quicksand-Regular.ttf') }}");
        }

        body {
            font-family: 'Quicksand', Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .email-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            /*background-color: rgb(4, 60, 119);*/
            color: white;
            text-align: center;
            padding: 20px 0;
        }

        .header img {
            max-width: 250px;
        }

        .video-link {
            text-align: center;
            padding: 20px 0;
        }

        .video-link a {
            background-color: rgb(4, 60, 119);
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
        }

        .message {
            text-align: center;
            padding: 20px 0;
        }

        .content {
            padding: 0px 40px;
        }

        .disclaimer {
            text-align: center;
            padding: 40px 0;
            color: #888;
            font-size: 12px;
            background-color: rgb(4, 60, 119);
            text-align: center;
            border-radius: 5px 5px 5px 5px;
        }

        .signature {
            text-align: center;
            padding: 20px 0;
            color: rgb(4, 60, 119);
        }
    </style>
</head>

<body>
    <div class="email-container">
        <div class="header">
            <!-- Coloca aquí tu imagen de logotipo -->
            <img src="{{ $message->embed(asset('images/illustrations/logo.png'))}}" alt="Logo de Guillén Tamayo">
        </div>

        <div class="content">
            <div class="message">
                <p>Solicitamos puedas ver este video con detenimiento, ya que encontrarás una serie de consejos que te ayudarán a mejorar la rapidez de adaptación de tu nuevo lente multifocal.</p>
                <p>Felicitaciones por esta nueva adquisición.</p>
            </div>
            <div class="video-link">
                <a href="https://youtu.be/mOayPoTcS7U">Ver Video</a>
            </div>
            <div class="signature">
                <p>Con cariño,</p>
                <p>Todos los que hacen Guillén Tamayo</p>
            </div>

        </div>

        <div class="disclaimer">
            <p>© 2023 Guillén Tamayo. Todos los derechos reservados. Este correo electrónico es confidencial y está destinado únicamente al destinatario especificado. Si ha recibido este correo electrónico por error, le rogamos que lo elimine y notifique al remitente. Gracias.</p>
        </div>
    </div>
</body>

</html>
