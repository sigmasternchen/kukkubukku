#!/bin/bash

route GET "/login" loginForm
loginForm() {
	if isLoggedIn; then
		redirect "/backend"
		endHeaders
	else
		htmlContent
		endHeaders
		
		title="Login"
		fail=0
		test "$(queryString "status")"
		content="$(template "templates/login.fragment.templ")"
		template "templates/layout.html.templ"
	fi
}

route POST "/login" login
login() {
	cacheFormData

	username="$(formData "username")"
	password="$(formData "password")"
	
	if loginUser "$username" "$password"; then
		setLoggedIn "$username"
		redirect "/backend"
	else
		redirect "/login?status=fail"
	fi
	
	endHeaders
}
