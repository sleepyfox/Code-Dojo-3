#!/bin/bash
echo 'Tests:'
vows --spec test/*.coffee

echo 'OO version:'
coffee temp-spread-OO.coffee
