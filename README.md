# sgen
### A super simple generator for common things in Silverstripe, Models, Controllers etc

#### Usage: ruby sgen [options] [name]
### Options
- -c or --controller (Controller)
- -p or --page (Page,Page_Controller)
- -m or --model (DataObject)
- -a or --admin (ModelAdmin)
- -h or --help For this help text

#### Example: ruby sgen --model Animal

### Notes
#### Currently creates files at the in the follwing deirectories only:
- app/controllers/
- app/pages/
- app/models/
- app/admin/
