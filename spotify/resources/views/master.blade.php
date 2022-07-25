<html>

<head>
    <title>Spotify - Web Player</title>
    <link rel="stylesheet" href="{{ asset("css/master.css") }}">
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
    <div class="wrapper">
        <div class="nav-side">
            <div class="logo">
                <img src="{{ asset("image/logos.png") }}">
            </div>

            <div class="nav-side-item">
                <div class="nav-view">
                    <li class="nav-item">
                        <span class="bi bi-house-door-fill" style="color:aliceblue;font-size: 25px;"></span>

                        <a class="nav-link" href="\">Home</a>
                    </li>
                </div>

                <div class="nav-view">
                    <li class="nav-item">
                        <span class="bi bi-search" style="color:aliceblue;font-size: 25px;"></span>

                        <a class="nav-link" href="/search">Search</a>
                    </li>
                </div>

                <div class="nav-view">
                    <li class="nav-item">
                        <span class="bi bi-folder-fill" style="color:aliceblue;font-size: 25px;"></span>

                        <a class="nav-link" href="/library">library</a>
                    </li>
                </div>
            </div>
        </div>

        <div class="right-content">
            <div class="top-navbar">
                <div class="button-login">
                    <a href="/login" class="login in">Login</a>
                </div>

                <div class="button-sign">
                    <a href="/" class="sign up">Sign up</a>
                </div>
            </div>

            <div class="content-data">
                @yield('content')
            </div>
        </div>
    </div>
    <script src="{{ asset("js/player.js") }}"></script>
</body>
</html>