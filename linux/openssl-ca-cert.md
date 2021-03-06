## 1. 创建 openssl.cnf

```
[ ca ]
default_ca = subchen_ca

[ subchen_ca ]
certificate = ./ca-cert.pem
private_key = ./ca-key.pem
database = ./index.txt
serial = ./serial
new_certs_dir = ./certs

default_days = 3650
default_md = sha1

policy = subchen_ca_policy
x509_extensions = subchen_ca_extensions

[ subchen_ca_policy ]
commonName = supplied
stateOrProvinceName = optional
countryName = optional
emailAddress = optional
organizationName = optional
organizationalUnitName = optional

[ subchen_ca_extensions ]
basicConstraints = CA:false


[ req ]
default_bits = 2048
default_keyfile = ./ca-key.pem
default_md = sha1
prompt = yes
distinguished_name = root_ca_distinguished_name
x509_extensions = root_ca_extensions

[ root_ca_distinguished_name ]
countryName_default = CN

[ root_ca_extensions ]
basicConstraints = CA:true
keyUsage = cRLSign, keyCertSign

[ server_ca_extensions ]
basicConstraints = CA:false
keyUsage = keyEncipherment

[ client_ca_extensions ]
basicConstraints = CA:false
keyUsage = digitalSignature
```
## 2. 创建必要的文件和目录

```bash
mkdir certs
echo /dev/null > index.txt
echo 01 > serial
```

## 3. 创建自己的 CA 机构

```
openssl req -x509 -config openssl.cnf -newkey rsa:2048 -keyout ca-key.pem -days 3650 -out ca-cert.pem -nodes -subj /CN=SubchenCA/

// 如果需要，可以生成 cer 格式证书
openssl x509 -in ca-cert.pem -out ca-cert.cer -outform DER
```

## 4. 创建服务器端证书

```bash
openssl genrsa -out server-key.pem 2048
openssl req -new -key server-key.pem -out server-req.pem -nodes -subj /CN=subchen/O=server/
openssl ca -config openssl.cnf -in server-req.pem -out server-cert.pem -batch -extensions server_ca_extensions

// 将证书打包
openssl pkcs12 -export -out server-cert.p12 -in server-cert.pem -inkey server-key.pem -certfile ca-cert.pem -passout pass:secret
```

## 5. 创建客服端证书

```
openssl genrsa -out client-key.pem 2048
openssl req -new -key client-key.pem -out client-req.pem -nodes -subj /CN=subchen/O=client/
openssl ca -config openssl.cnf -in client-req.pem -out client-cert.pem -batch -extensions client_ca_extensions

// 将证书打包
openssl pkcs12 -export -out client-cert.p12 -in client-cert.pem -inkey client-key.pem -certfile ca-cert.pem -passout pass:secret
```

## 6. Verify

Check certs info

```bash
openssl x509 -noout -text -in ca-cert.pem
openssl x509 -noout -text -in server-cert.pem
openssl x509 -noout -text -in client-cert.pem
```

Check keys and certificates with OpenSSL

```bash
// In one terminal window execute the following command:
openssl s_server -accept 8443 -cert server-cert.pem -key server-key.pem -CAfile ca-cert.pem

// In another terminal window execute
openssl s_client -connect localhost:8443 -cert client-cert.pem -key client-key.pem -CAfile ca-cert.pem
```

If the certificates and keys have been correctly created, an SSL connection establishment sequence will appear and the terminals will be linked. Input from either terminal will appear on the other. If the trust chain could be established, the second terminal will display this confirmation:

```
Verify return code: 0 (ok)
```

If you receive an error, confirm that the certificates and keys were generated correctly

## 7. Usage on NodeJS

**Server**

```js
var https = require('https');  
var fs = require('fs');  
  
var options = {  
  ca: [fs.readFileSync('./ca-cert.pem')],  
  key: fs.readFileSync('./server-key.pem'),  
  cert: fs.readFileSync('./server-cert.pem')  
};  
  
// or using packaged cert file  
//var options = {  
//  pfx:fs.readFileSync('./server.p12'),  
//  passphrase:'your password'  
//};  
  
https.createServer(options, function(req, res){  
  res.writeHead(200);  
  res.end('hello world\n');  
}).listen(3000,'127.0.0.1');  
```

**Client**

```js
var https = require('https');  
var fs = require('fs');  
  
var options = {  
  hostname:'127.0.0.1',  
  port:3000,  
  path:'/',  
  method:'GET',  
  ca: [fs.readFileSync('./ca-cert.pem')],  
  key:fs.readFileSync('./client-key.pem'),  
  cert:fs.readFileSync('./client-cert.pem'),  
  agent:false  
};  
  
// or using packaged cert file  
//var options = {  
//  pfx:fs.readFileSync('./client.p12'),  
//  passphrase:'your password'  
//};  
  
options.agent = new https.Agent(options);  
var req = https.request(options, function(res) {  
  console.log("statusCode: ", res.statusCode);  
});  
  
req.end();  
```


## 8. References

* http://www.jinbuguo.com/linux/openssl_install.html
* http://www.rabbitmq.com/ssl.html
* https://langui.sh/2009/01/18/openssl-self-signed-ca/

## 9. 新方法: 使用 cfssl

* https://github.com/opsnull/follow-me-install-kubernetes-cluster/blob/master/01-TLS%E8%AF%81%E4%B9%A6%E5%92%8C%E7%A7%98%E9%92%A5.md
* https://coreos.com/os/docs/latest/generate-self-signed-certificates.html

