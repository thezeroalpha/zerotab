#!/usr/bin/env ruby
# Takes links JSON on stdin, outputs HTML on stdout
require 'json'

begin
  categories = JSON.parse($stdin.read)
rescue JSON::ParserError
  warn "Couldn't parse input."
  exit 1
end

outlines = "<ul id='links'>\n"
categories.each do |cat|
  outlines += <<~EOF
    <li>
      <a title="#{cat["name"].downcase}" href="#"><img src="img/#{cat["name"].downcase}.svg"></a>
      <ul>
    EOF
  cat["links"].each do |link|
    if link[0] == '-'
      outlines += "    <hr>\n"
    else
      outlines += "    <li><a href='#{link[1]}'>#{link[0]}</a></li>\n"
    end
  end
  outlines += <<~EOF
      </ul>
    </li>
    EOF
end
outlines += "</ul>"

puts outlines
