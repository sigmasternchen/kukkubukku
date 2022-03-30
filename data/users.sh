#!/bin/bash

createSalt() {
	head -c 12 /dev/urandom | base64
}

hashPassword() {
	_password="$1"
	_salt="$2"
	echo "$_password$_salt" | sha512sum | cut -d' ' -f1
}

createUser() {
	local username="$1"
	local password="$2"
	local salt="$(createSalt)"
	local password="$(hashPassword "$password" "$salt")"
	echo "INSERT INTO users (username, password, salt) VALUES (
		'$(escape "$username")',
		'$(escape "$password")',
		'$(escape "$salt")'
	)" | execute
}

loginUser() {
	local username="$1"
	local password="$2"

	local result="$(echo "SELECT password, salt FROM users WHERE username='$(escape "$username")'" | query)"
	local hash="$(echo "$result" | getColumns 1)"
	local salt="$(echo "$result" | getColumns 2)"

	local password="$(hashPassword "$password" "$salt")"

	# return true if password is correct
	test "$password" = "$hash"
	return
}
