--[[
    Main page
]]

--// Modules
local Template = require('resty.template')

--// Variables
local FilePath = ngx.var.root .. '/files/'
local Document = ngx.var.arg_Document;

--// Functions
local GetContent = function(Name)
    Name = Name or ''

    local File = io.open(FilePath .. Name, 'rb')

    if not File then 
        return ''
    end

    local Content = File:read('*a')

    File:close()

    return Content
end

--// Set the content type
ngx.header.content_type = 'text/html';

Template.render('index.html', { 
    Content = (Document ~= nil and GetContent(Document)) or ''
})

--// Exit saying all is a-okay
return ngx.exit(ngx.HTTP_OK)