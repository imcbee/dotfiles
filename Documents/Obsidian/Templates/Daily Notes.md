---
type: daily-notes
tags: [daily-notes]
date: <% tp.file.title %>
created: <% tp.date.now("YYYY-MM-DD") %>
---
# <% tp.file.title %>  Notes
 << [[<% tp.date.now("YYYY-MM-DD", -1) %>]] | [[<% tp.date.now("YYYY-MM-DD", 1) %>]] >>

<% tp.web.daily_quote() %>

--vod 

---
# Today's Task
## <u>General Tasks</u>
```tasks
not done
tags do not include #OMS-TASK
path does not include OMS/
```
## <u>OMS-Tasks</u>
```dataview
table state, priority, start_date, url
where type = "task" and file.name != "Task Template" and completed = false
```
## [[Reminders]]
```dataviewjs
dv.pagePaths('"OMS/Reminders"').forEach(pagePath => {  
	dv.paragraph("![["+pagePath+"]]")  
})
```
## [[MARS-OMS Running Questions]]
```dataviewjs
dv.pagePaths('"OMS/MARS-OMS Running Questions"').forEach(pagePath => {  
	dv.paragraph("![["+pagePath+"]]")  
})
```
---
# Standups
## [[OMS Core Daily Standup]]

## [[OMS "Standup of Standups"]]

---
