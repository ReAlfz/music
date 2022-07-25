<html>

<head>
    <title>Spotify - Admin</title>
    <link rel="stylesheet" href="{{ asset("css/admin.css") }}">
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css'>
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
                        <i class="bi bi-tools" style="color:aliceblue;font-size: 25px;"></i>
                        <a class="nav-link" href="/admin/songs">Songs</a>
                    </li>
                </div>
            </div>

            <div class="nav-side-item">
                <div class="nav-view">
                    <li class="nav-item">
                        <i class="bi bi-tools" style="color:aliceblue;font-size: 25px;"></i>
                        <a class="nav-link" href="/admin/artist">Artist</a>
                    </li>
                </div>
            </div>


            
        </div>

        <div class="right-content">
            <div class="top-navbar">
                <div class="button-add">
                    <a href="@yield('urls')" class="add music">Add</a>
                </div>
            </div>

            <div class="content-data">
                
                @yield('content')

            </div>
        </div>
    </div>
</body>

</html>