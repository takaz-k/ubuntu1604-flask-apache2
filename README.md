## Apache2 + Flask (Ubuntu 16.04)
Apache2 + Flaskの環境をUbuntu16.04環境に構築するDockerの例です

## Environment
Dockerが動く環境であればOKです

## Usage
```shell
$ docker-compose build

$ docker-compose up -d
```

ブラウザ等で以下にアクセスすればApache上でFlaskアプリが動作している結果を確認できます。  
- http://localhost:8080
- http://localhost:8080/hello
- http://localhost:8080/func