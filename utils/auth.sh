#!/bin/bash

_sessionKeyUsername="username"

username=""

isLoggedIn() {
	username="$(getSessionValue "$_sessionKeyUsername")"
	test ! -z "$username"
	return
}

requireLoggedIn() {
	startSession
	
	if isLoggedIn; then
		echo > /dev/null # empty path
	else
		redirect "/login"
		endHeaders
		exit
	fi
}
