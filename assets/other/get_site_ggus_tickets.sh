#!/bin/bash
# This script gets the list of tickets open against a site.

for site in ZA-UJ ZA-UCT-ICTS ; do
  echo wget -O ${site}.xml " https://ggus.eu/index.php?mode=ticket_search&supportunit=&affectedsite=${site}&specattrib=none&status=open&typeofproblem=all&ticket_category=all&timeframe=any&from_date=11+May+2016&to_date=12+May+2016&untouched_date=&orderticketsby=REQUEST_ID&orderhow=desc&search_submit=GO%21&writeFormat=XML"
done
