io.write("Please specify file path:\n")
file = io.read()
if io.open(file) == nil then
  io.write("Filename Invalid!! Should be something like '/files/log.log' or '~/.minecraft/logs/<filename>'!!\n")
  io.write("Exiting...")
  os.exit()
else
  io.write("File found at " .. file .. "! Please wait...\n\n\n")
end

log_lines = {}
matches = {}
themes = {}

for line in io.lines(file) do
  table.insert(log_lines, line)
end

for i = 1, #log_lines do
  if string.match(log_lines[i], "The theme was:") then
    table.insert(themes, { string.sub(log_lines[i], 56, #log_lines[i] - 1), i, string.sub(log_lines[i], 2, 9) })
  end
end

for i = 1, #themes do
  for j = 1, #themes do
    if themes[i][1] == themes[j][1] and themes[i][2] ~= themes[j][2] then
      table.insert(matches, { themes[j][1], themes[j][3], themes[j][2] })
    end
  end
end

if #matches > 0 then
  for i = 1, #matches do
    io.write("Repeats found at " ..
      matches[i][2] .. " At line " .. matches[i][3] .. " In file! '" .. matches[i][1] .. "'\n")
  end
else
  io.write("No matches found!! Exiting...\n")
  os.exit()
end
