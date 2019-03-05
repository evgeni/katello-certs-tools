#!/bin/bash -e

for i in `seq 1 4`; do
katello-ssl-tool --gen-ca -p file:/etc/pki/katello/private/katello-default-ca.pwd --force --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --ca-cert-rpm katello-default-ca --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit
done

for i in `seq 1 4`; do
katello-ssl-tool --gen-server -p file:/etc/pki/katello/private/katello-default-ca.pwd --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name foo.example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit --cert-expiration 36500
katello-ssl-tool --gen-server -p file:/etc/pki/katello/private/katello-default-ca.pwd --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-hostname foo.example.com --set-common-name foo.example.com --server-cert java-client.crt --server-cert-req java-client.crt.req --server-key java-client.key --server-rpm java-client --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --set-country US --set-state "North Carolina" --set-city Raleigh --set-org candlepin --set-org-unit SomeOrgUnit --cert-expiration 7300
done

for i in `seq 1 4`; do
katello-ssl-tool --gen-client -p file:/etc/pki/katello/private/katello-default-ca.pwd --ca-cert-dir /etc/pki/katello-certs-tools/certs --set-common-name foo.example.com --ca-cert katello-default-ca.crt --ca-key katello-default-ca.key --set-country US --set-state "North Carolina" --set-city Raleigh --set-org Katello --set-org-unit SomeOrgUnit --cert-expiration 36500
done
