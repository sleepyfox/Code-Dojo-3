#!/bin/bash
echo 'Tests:'
vows temperature-spread/test/*.coffee --spec
echo 'Procedural version:'
coffee temperature-spread/temp-spread.coffee
echo 'Map-reduce version:'
coffee temperature-spread/temp-spread-mapreduce.coffee
