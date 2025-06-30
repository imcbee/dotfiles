---
type: person
created: <% tp.date.now() %>
name: <% tp.file.title %>
company: Black Cape
project: OMS
team: <% tp.frontmatter['project'] %>-
location:
tags:
  - person
  - <% tp.frontmatter['project'] %>
  - <% tp.frontmatter['team'] %>
---
---
# <% tp.file.title %>
Company: [[<% tp.frontmatter['company'] %>]]
Project: [[<% tp.frontmatter['project'] %>]]
Team: [[<% tp.frontmatter['team'] %>]]

## About
- 

# Reference Links
```dataview
table without id file.inlinks
where file.name = this.file.name
```
