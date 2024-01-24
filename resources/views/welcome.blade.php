<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" style="scrollbar-color: #e1e0e0 #0000;">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!--<link rel="icon" href="/favicon.ico">-->
        <link rel="icon" href="/favicon.png">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="landing-url" content="{{ env('LANDING_URL') }}">
        <title>Admin </title>
        <!--Lux Laravel Starter-->
        <!-- Quicksand Font -->
        <!--<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"> -->
        <!--<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">-->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;600;700;800;900&display=swap" rel="stylesheet">


        <link href="{{ mix('dist/css/app.css') }}" rel="stylesheet">
    </head>
    <body>
        <noscript>
            <strong>We're sorry but this website doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
        </noscript>
        <div id="app"></div>
        <script src="{{ mix('dist/js/app.js') }}"></script>
    </body> 
</html>
