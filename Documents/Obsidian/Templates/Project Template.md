---
type: project
created: <% tp.date.now() %>
name: <% tp.file.title %>
tags:
  - <% tp.file.title %>
  - OMS
---
---
# <% tp.file.title %>
## About

## Teams
```dataview
list
where type="person" and team="<% tp.file.title %>"
```

# Reference Links
```dataview
table without id file.inlinks
where file.name = this.file.name
```
