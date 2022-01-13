#!/bin/bash

route GET "/backend" backendHome
backendHome() {
	requireLoggedIn
	endHeaders
	
	title="Backend"
	content="$(template "templates/backend.fragment.templ")"
	template "templates/layout.html.templ"
}
