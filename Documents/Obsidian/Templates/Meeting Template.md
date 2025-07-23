---
type: meeting
created: <% tp.date.now() %>
date: <% tp.date.now() %>
name: <% tp.file.title %>
alias: []
project: OMS
occurrence:
optional:
day:
tags:
  - meeting-<% tp.frontmatter['occurrence'] %>
  - <% tp.frontmatter['project'] %>
---
---
# <% tp.file.title %>
## Purpose
*Project:* [[<% tp.frontmatter['project'] %>]]
*Date:* [[<% tp.date.now() %>]]

## Attendees
```dataview
list
where type="person"
```

# Reference Links
```dataview
table without id file.inlinks
where file.name = this.file.name
```
