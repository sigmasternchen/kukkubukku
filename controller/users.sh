#!/bin/bash

route GET "/login" loginForm
loginForm() {
	htmlContent
	endHeaders
	
	title="Login"
	content="$(template "templates/login.fragment.templ")"
	template "templates/layout.html.templ"
}

route POST "/login" login
login() {
	username="$(formData "username")"
	password="$(formData "password")"

	if loginUser "$username" "$password"; then
		echo "ok"
	else
		echo "ko"
	fi
}
