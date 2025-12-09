#!/bin/bash

cd $(dirname $0)

sed -e "s/<StdProvServFqdn>/prod.v6mig.v6connect.net/g" openssl.cnf.base \
	| sed -e "s/<StdProvServFqdn_DNS1>/redirect.v6mig.v6connect.net/g" \
	> openssl.cnf

# ca-private
openssl genrsa -out ca-privatekey.pem 2048
# ca CSR
openssl req -new -key ca-privatekey.pem -out ca-csr.pem -config openssl.cnf
# ca CRT
#openssl req -new -x509 -key ca-privatekey.pem -in ca-csr.pem -sha512 -out ca-crt.pem -days 3560
openssl req -new -x509 -config openssl.cnf \
	-key ca-privatekey.pem \
	-in ca-csr.pem -sha512 \
	-out ca-crt.pem -days 3560 
# for https server
cat ca-privatekey.pem ca-crt.pem > server.pem
