#!/bin/bash

route GET "/" home
home() {
	htmlContent
	endHeaders
	
	title="Home"
	content="$(template "templates/home.fragment.templ")"
	template "templates/layout.html.templ"
}
