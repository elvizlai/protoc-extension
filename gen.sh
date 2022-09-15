#!/usr/bin/env bash

DST_DIR=.

# TODO: all gateway will move to dir gw using standalone mode
for pkg in `find . -path ./include -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq`;
do
    echo $pkg
    protoc -I=include -I=. --experimental_allow_proto3_optional \
		--go_out=$DST_DIR --go_opt=$xxm,paths=source_relative \
		--go-grpc_out=$DST_DIR --go-grpc_opt=$xxm,paths=source_relative \
		`find "${pkg}" -maxdepth 1 -name '*.proto'` || ret=$?
done

