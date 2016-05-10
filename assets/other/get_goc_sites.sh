#!/bin/bash
# Get sites from the goc
# we use xml2json to convert the xml to json.
# See https://github.com/Inist-CNRS/node-xml2json-command
# sudo npm install -g xml2json-command
wget --no-check-certificate -O result.xml 'https://goc.egi.eu/gocdbpi/public/?method=get_site_list&roc=AfricaArabia'
xml2json < result.xml > _data/goc_sites.json
