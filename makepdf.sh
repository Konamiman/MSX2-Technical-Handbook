#!/bin/sh

if [ ! -x "$(command -v pandoc)" ]; then
	echo "This conversion requires pandoc installed."
	echo "On Fedora, run 'dnf install pandoc'"
	exit 1
fi

if [ ! -x "$(command -v wkhtmltopdf)" ]; then
	echo "This conversion requires wkhtmltopdf installed."
	echo "On Fedora, run 'dnf install wkhtmltopdf'"
	exit 1
fi

pandoc -f gfm -t html5 --metadata pagetitle="MSX2 Technical Handbook" md/Chapter*.md md/Appendix?.md md/Appendices8and10.md -o msx2-technical-handbook.pdf
