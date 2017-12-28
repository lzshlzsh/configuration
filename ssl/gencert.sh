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
  echo -e "$*"
  color_off
}
function echo_red()
{
  color_red
  echo -e "$*"
  color_off
}

function input_domain()
{
  read -p "Enter you domain [$DEFAULT_DOMAIN]: " DOMAIN
  if [ "x$DOMAIN" == "x" ]; then
    DOMAIN=$DEFAULT_DOMAIN
  fi
  echo_green "domain: $DOMAIN"
}

function create_root_ca()
{
  local subject

  input_domain

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

  if ! [ -r $ROOTCA_CRT ] || ! [ -r $ROOTCA_KEY ]; then
    echo_red "Cannot read both $ROOTCA_CRT and $ROOTCA_KEY"
    echo_red "Please use --new_root or -n option"
    return 1
  fi

  input_domain

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

function clear_all()
{
  rm -fv *.key *.csr *.crt *.conf *srl
}

function usage()
{
  echo_green "usage: $0 -h|--help -n|--new_root -c|--clear"
  echo_green "\t: -h|--help, show this help message"
  echo_green "\t: -n|--new_root, new root CA"
  echo_green "\t: -c|--clear, clear all temp file"
}

TEMP=`getopt -o h,n,c -l help,new_root,clear -- "$@"`
if [ $? -ne 0 ]; then
  echo_red "wrong option"
  usage
  exit 1
fi
eval set -- $TEMP

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -n|--new_root)
      create_root_ca
      ;;
    -c|--clear)
      clear_all
      exit 0
      ;;
    --)
      ;;
    *)
      ;;
  esac
  shift
done
create_site_ca
