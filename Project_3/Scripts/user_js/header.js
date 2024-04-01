const template = document.createElement('template');
template.innerHTML = `
<header class="continer-fluid ">
<div id="menu-jk" class="header-bottom">
    <div class="container">
        <div class="row nav-row">
            <div class="col-lg-3 col-md-12 logo">
                <a class="" href="Index.chtml">
                    <img src="../../images/user_img/logo.jpg" alt="">
                    <a data-toggle="collapse" data-target="#menu" href="#menu"><i
                            class="fas d-block d-lg-none  small-menu fa-bars"></i></a>
                </a>

            </div>
            <div id="menu" class="col-lg-8 col-md-12 d-none d-lg-block nav-col">

                <ul class="navbad">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.html">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link " href="our_work.html">Our work</a>
                        <div class="dropdown-content">
                            <a href="our_work.html">Childrens</a>
                            <a href="our_work.html">Disabled</a>
                            <a href="our_work.html">Education</a>
                            <a href="our_work.html">Elderly</a>
                            <a href="our_work.html">Women</a>
                            <a href="our_work.html">Health</a>
                            <a href="our_work.html">Enviroment</a>
                        </div>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="campaign.html">Campaign</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="blog.html">Blog</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link " href="about_us.html">About Us</a>
                        <div class="dropdown-content">
                            <a href="what_we_do.html">What We Do</a>
                            <a href="mission.html">Our Mission</a>
                            <a href="team.html">Our Team</a>
                            <a href="partner.html">Our Partners</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact_us.html">Contact Us</a>
                    </li>
                </ul>
            </div>                    <div class="col-lg-1">
                <a class="nav-link login-btn" href="signin-signup.html">Login</a>
            </div>
        </div>
    </div>
</div>
</div>
</header>

`

document.body.appendChild(template.content);
