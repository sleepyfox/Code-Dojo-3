.PHONY: build build-browser build-node

build-browser:
	java -cp cljs.jar:src clojure.main build.clj

build-node:
	java -cp cljs.jar:src clojure.main node.clj
	
build: build-node
