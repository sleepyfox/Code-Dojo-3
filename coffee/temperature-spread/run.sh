#!/bin/bash
echo 'Tests:'
vows test/*.coffee --spec
echo 'Procedural version:'
coffee temp-spread.coffee
echo 'Map-reduce version:'
coffee temp-spread-mapreduce.coffee