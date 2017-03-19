#!/bin/bash
# Get sites from the goc
# See https://wiki.egi.eu/wiki/GOCDB/PI/Technical_Documentation#GOCDB_Programmatic_Interface
# we use xml2json to convert the xml to json.
# See https://github.com/Inist-CNRS/node-xml2json-command
# sudo npm install -g xml2json-command
wget --no-check-certificate -O result.xml 'https://goc.egi.eu/gocdbpi/public/?method=get_site_list&roc=AfricaArabia'
xml2json < result.xml > _data/goc_sites.json

# We can do funky things here like loop over the list of services in the site.
wget --no-check-certificate -O services.xml 'https://goc.egi.eu/gocdbpi/public/?method=get_service_endpoint&roc=AfricaArabia'
xml2json < result.xml > _data/site_services.json

wget --no-check-certificate -O services.xml 'https://goc.egi.eu/gocdbpi/public/?method=get_service_types'
xml2json < services.xml > _data/all_services.json 
