#!/bin/bash

DEFAULT_DOMAIN=www.example.com
ROOTCA_KEY=rootCA.key
ROOTCA_CRT=rootCA.crt

function color_off()
{
  echo -ne "\033[0m"
}
function color_green()
{
  echo -ne "\033[32m"
}
function color_red()
{
  echo -ne "\033[31m"
}
function echo_green()
{
  color_green
  echo "$*"
  color_off
}
function echo_red()
{
  color_red
  echo "$*"
  color_off
}

function create_root_ca()
{
  local subject

  read -p "Enter you domain [$DEFAULT_DOMAIN]: " DOMAIN
  if [ "x$DOMAIN" == "x" ]; then
    DOMAIN=$DEFAULT_DOMAIN
  fi
  echo_green "domain: $DOMAIN"

  subject="/C=CN/CN=$DOMAIN self-signed CA"
  echo_green "generate root CA key: $ROOTCA_KEY"
  openssl genrsa -out $ROOTCA_KEY 2048

  echo_green "generate self signed CA: $ROOTCA_CRT"
  openssl req -x509 -new -nodes -key $ROOTCA_KEY -sha256 -days 3650 \
    -subj "$subject" -out $ROOTCA_CRT

  echo_green ""
}

function create_site_ca()
{
  local subject
  local site_key=$DOMAIN.key
  local site_csr=$DOMAIN.csr
  local site_crt=$DOMAIN.crt
  local extension=extension.conf

  subject="/CN=$DOMAIN/O=${DOMAIN}/C=CN"

  echo_green "Create private key: $site_key"
  openssl genrsa -out $site_key 2048


  echo_green "Create certificate sign request: $site_csr"
  openssl req -new -key $site_key -sha256 -subj "$subject" -out $site_csr

  echo_green "generate x509v3 config file: $extension"
  echo "subjectAltName=DNS:${DOMAIN},DNS:*.${DOMAIN#www.}" >$extension
  echo_green "Sign the csr with self key, create ca: $site_crt"
  openssl x509 -req -sha256 \
    -in $site_csr -CA $ROOTCA_CRT -CAkey $ROOTCA_KEY \
    -out $site_crt -days 3650 \
    -extfile $extension -CAcreateserial
}

create_root_ca
create_site_ca
