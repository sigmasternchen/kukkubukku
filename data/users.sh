#!/bin/bash

createSalt() {
	head -c 12 /dev/urandom | base64
}

hashPassword() {
	password="$1"
	salt="$2"
	echo "$password$salt" | sha512sum | cut -d' ' -f1
}

createUser() {
	username="$1"
	password="$2"
	salt="$(createSalt)"
	password="$(hashPassword "$password" "$salt")"
	echo "INSERT INTO users (username, password, salt) VALUES (
		'$(escape "$username")',
		'$(escape "$password")',
		'$(escape "$salt")'
	)" | execute
}

loginUser() {
	username="$1"
	password="$2"

	result="$(echo "SELECT password, salt FROM users WHERE username='$(escape "$username")'" | query)"
	hash="$(echo "$result" | getColumns 1)"
	salt="$(echo "$result" | getColumns 2)"

	password="$(hashPassword "$password" "$salt")"

	test "$password" = "$hash"
	return
}
