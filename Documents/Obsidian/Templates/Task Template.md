---
type: task
name: <% tp.file.title %>
start_date: <% tp.date.now("YYYY-MM-DD")  %>
created: <% tp.date.now("YYYY-MM-DD") %>
project: OMS
tags:
  - OMS-TASK
  - <% tp.frontmatter['project'] %>
  - <% tp.frontmatter['project'] %>-CORE
completed: false
state: NOT-STARTED
priority: MEDIUM
url: https://tex.gerbil-cloud.ts.net:3000/oms/oms-bridge/pulls/
issue: https://tex.gerbil-cloud.ts.net:3000/oms/oms-bridge/issues/
---
---
# <% tp.file.title %>
## Description
*Project:* [[<% tp.frontmatter['project'] %>]]/[[<% tp.frontmatter['project'] %>-CORE]]. This task was created on [[<% tp.date.now() %>]].
[Issue URL](<% tp.frontmatter["issue"] %>)
[Pull Request URL](<% tp.frontmatter["url"] %>)

- [//] **TODO:** Add ticket description below
### Sub-tasks
- [//]

### Updates
- 

## Resources
- 

---
# Reference Links
```dataview
table without id file.inlinks
where file.name = this.file.name
```
