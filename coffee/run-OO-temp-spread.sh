#!/bin/bash
echo 'Tests:'
vows --spec OO-temperature-spread/test/*.coffee

echo 'OO version:'
coffee OO-temperature-spread/temp-spread-OO.coffee
