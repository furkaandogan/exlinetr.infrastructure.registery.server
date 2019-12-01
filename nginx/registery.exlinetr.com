upstream registeruiyexlinetr{
    server 127.0.0.1:3001;
}

upstream registerstore{
    server 127.0.0.1:5000;
}

server{
    listen 80 ;
    listen [::]:80;

    server_name registery.exlinetr.com;

    
    auth_basic  "Administrator’s Area";
    auth_basic_user_file htpasswd;


    location /v2 {
        proxy_pass http://registerstore;
    }

    location / {
        proxy_pass http://registeruiyexlinetr;
    }
}

