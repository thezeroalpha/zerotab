#!/usr/bin/env ruby
# Takes links YAML file on stdin, outputs HTML <ul> on stdout
require 'yaml'

begin
  categories = YAML.safe_load($stdin.read)
rescue StandardError
  warn "Couldn't parse input."
  exit 1
end

outlines = "<ul id='links'>\n"
categories.each_with_index do |(cat, links), i|
  outlines += <<~HTML
    <li>
      <a title="#{cat.downcase}" href="#" tabindex="#{i + 1}"><img src="img/#{cat.downcase}.svg"></a>
      <ul>
  HTML
  links.each do |link|
    outlines += if link.keys.first == '-'
                  "    <li class=\"separator\">#{link.values.first}</li>\n"
                else
                  "    <li><a href=\"#{link.values.first}\">#{link.keys.first}</a></li>\n"
                end
  end
  outlines += <<~HTML
      </ul>
    </li>
  HTML
end
outlines += '</ul>'

puts outlines
