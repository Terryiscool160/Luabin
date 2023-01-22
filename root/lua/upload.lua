--[[
    Handle for uploading files
]]

--// Variables
local FilePath = ngx.var.root .. '/files/'

--// Define functions
local RandomString = function()
    local Return = ''

	for _ = 1, 15 do
		Return = Return .. string.char(math.random(97, 122))
	end

	return Return
end

local Write = function(Name, Content)
    local File = io.open(FilePath .. Name, 'w')
    
    File:write(Content)
    File:close()
end

local FileExists = function(Name)
    local File = io.open(FilePath .. Name, 'rb')

    if File then
        File:close()
    end

    return File ~= nil
end

--// Get method
local Method = ngx.req.get_method()

--// Set what we're returning
ngx.header.content_type = 'text/plain'

if Method ~= 'POST' then
    --// don't 
    return ngx.exit(ngx.HTTP_BAD_REQUEST)
end

--// Read then body
ngx.req.read_body();

local Body = ngx.req.get_body_data()

--// Do presence check
if Body == nil or Body == '' then
    --// Didn't provide any actual content
    return ngx.say('No content')
end

if (string.match(Body, 'text=')) then
    --// Cut out the "content=" because im using forms and i genuinely hate html
    Body = string.sub(Body, 6)
end

--// Decode
Body = ngx.unescape_uri(Body)

--// Some checks for stuff
if (string.len(Body) < 10 or string.len(Body) > 10000) then
    return ngx.say('Content < 10 or > 10_000')
end

--// Handle actually making the file now
local String = RandomString()

while FileExists(String) do
    String = RandomString()
end

--// Write 
Write(String, Body)

--// Redirect to their new file
return ngx.redirect('index?document=' .. String)