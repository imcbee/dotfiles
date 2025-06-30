---
type: meeting
created: <% tp.date.now() %>
name: <% tp.file.title %>
project: OMS
occurrence:
optional:
day:
tags:
  - meeting-<% tp.frontmatter['occurrence'] %>
---
# <% tp.file.title %>
## Purpose
*Project:* [[<% tp.frontmatter['project'] %>]]

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
