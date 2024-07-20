local component = require("component")
local term = require("term")
local fs = require("filesystem")
local io = require("io")

local function clearScreen()
  term.clear()
  term.setCursor(1, 1)
end

local function printWelcomeMessage()
  print("CorOS'a Hoşgeldiniz!")
end

local function prompt()
  term.write("> ")
end

local function createFile(path)
  local file = io.open(path, "w")
  if file then
    file:close()
    print("Dosya oluşturuldu: " .. path)
  else
    print("Dosya oluşturulamadı: " .. path)
  end
end

local function writeFile(path, content)
  local file = io.open(path, "a")
  if file then
    file:write(content .. "\n")
    file:close()
    print("Dosyaya yazıldı: " .. path)
  else
    print("Dosyaya yazılamadı: " .. path)
  end
end

local function readFile(path)
  local file = io.open(path, "r")
  if file then
    local content = file:read("*all")
    file:close()
    return content
  else
    return nil
  end
end

local function executeCommand(command)
  if command:sub(1, 6) == "create" then
    local path = command:match("create%s+(%S+)")
    if path then
      createFile(path)
    else
      print("Geçersiz 'create' komutu.")
    end
  elseif command:sub(1, 5) == "write" then
    local path, content = command:match("write%s+(%S+)%s+(.*)")
    if path and content then
      writeFile(path, content)
    else
      print("Geçersiz 'write' komutu.")
    end
  elseif command:sub(1, 4) == "read" then
    local path = command:match("read%s+(%S+)")
    if path then
      local content = readFile(path)
      if content then
        print("Dosya içeriği:\n" .. content)
      else
        print("Dosya bulunamadı: " .. path)
      end
    else
      print("Geçersiz 'read' komutu.")
    end
  else
    print("Geçersiz komut.")
  end
end

local function main()
  clearScreen()
  printWelcomeMessage()
  while true do
    prompt()
    local input = io.read()
    executeCommand(input)
  end
end

main()
