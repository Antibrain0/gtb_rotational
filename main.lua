io.write("Please specify file path:\n")
file = io.read() --grab filename from host
if io.open(file) == nil then
  io.write("Filename Invalid!! Should be something like '/files/log.log' or '~/.minecraft/logs/<filename>'!!\n")
  io.write("Exiting...")
  os.exit() --ruh roh
else
  io.write("File found at " .. file .. "! Please wait...\n\n\n")
end

log_lines = {} --variables
matches = {}
themes = {}

for line in io.lines(file) do
  table.insert(log_lines, line) --add line to table
end

for i = 1, #log_lines do
  if string.match(log_lines[i], "The theme was:") then
    table.insert(themes, { string.sub(log_lines[i], 56, #log_lines[i] - 1), i, string.sub(log_lines[i], 2, 9) }) --add theme + line number + time to themes
  end
end

for i = 1, #themes do
  for j = 1, #themes do --iterate over each value for each value in table
    if themes[i][1] == themes[j][1] and themes[i][2] ~= themes[j][2] then --if match found
      table.insert(matches, { themes[j][1], themes[j][3], themes[j][2] }) --add theme,line num,time to matches
    end
  end
end

if #matches > 0 then
  for i = #matches,1,-1 do
    io.write("Repeats found at " ..
      matches[i][2] .. " At line " .. matches[i][3] .. " In file! '" .. matches[i][1] .. "'\n") --print all matches
  end
else
  io.write("No matches found!! Exiting...\n")
  os.exit() --womp womp
end
