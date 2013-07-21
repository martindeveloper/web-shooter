# Load dependencies
system = require 'system'
page = require('webpage').create()

# Settings object/struct
settings = {}
settings.url = ''
settings.dir = 'screenshots'
settings.applicationName = ''
settings.build = 14

# Colors object
colors = {}
colors.red = '\u001b[31m'
colors.blue = '\u001b[34m'
colors.green = '\u001b[32m'
colors.reset = '\u001b[0m'

# Print about info
console.log colors.green + 'Web page shooter version 0.1. (build ' + settings.build + ')' + colors.reset

# Check arguments
if system.args.length is 1
  console.log colors.red + '\n - To startup shooter you need to pass URL argument!'
  phantom.exit()
else
  for arg, i in system.args
    switch arg
      when '-p'
        settings.url = system.args[i + 1]
      when '-d'
        settings.dir = system.args[i + 1]
      when '-a'
        settings.applicationName = system.args[i + 1]
      when '-h'
        console.log '\nUsage: phantomjs app.js [arguments]'
        console.log '\nArguments:'
        console.log ' -p Specify page to load, with http://'
        console.log ' -d Output root directory, default \'./screenshots/\''
        console.log ' -a Name of application for name of sub directory'
        
        phantom.exit()

# Try to open url
if settings.url? and settings.url != ''
  startTime = (new Date).getTime()
  
  console.log '\n - Loading page: ' + colors.blue + settings.url + colors.reset

  page.open settings.url, (status) ->
    if status is 'fail'
      console.log colors.red + '\n - Can not open specified URL!'
    else
      path = './' + settings.dir + '/'
      console.log ' - Page loaded'
    
      url = settings.url.replace 'http://', ''
      url = url.replace 'https://', ''
      url = url.replace '.', '_'
      
      console.log ' - Saving screenshot'
      
      appName = if settings.applicationName then settings.applicationName else url
      path = (path + appName + '/' + (new Date()).getTime() + '.png')
      page.render path
      
      console.log ' - Screenshot saved at ' + colors.blue + path + colors.reset
      
      endTime = (new Date).getTime()
      deltaTime = endTime - startTime
      
      console.log '\n - Successful ended job at ' + colors.green + (deltaTime / 1000) + colors.reset + ' seconds'
    
    phantom.exit()