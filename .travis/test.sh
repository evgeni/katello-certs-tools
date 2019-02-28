#!/bin/bash

set -e

export LC_ALL=en_US.UTF-8

if [ -x /usr/bin/yum ]; then
  yum install -y docbook-utils openssl rpm-build
fi

docbook2man katello-ssl-tool.sgml

python setup.py install

for i in `seq 1 4`; do
katello-ssl-tool --gen-ca -p file:/etc/pki/katello/private/katello-default-ca.pwd --force --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --ca-cert-rpm katello-default-ca --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit
done

for i in `seq 1 4`; do
katello-ssl-tool --gen-server -p file:/etc/pki/katello/private/katello-default-ca.pwd --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name foo.example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit --cert-expiration 36500
done

for i in `seq 1 4`; do
katello-ssl-tool --gen-client -p file:/etc/pki/katello/private/katello-default-ca.pwd --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name foo.example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit --cert-expiration 36500
done
