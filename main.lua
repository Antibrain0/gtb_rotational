io.write("Please specify filename.\nMake sure file is in same folder as this script.\nEnter FileName here:")
file = io.read() --grab filename from host
if io.open(file) == nil then
io.write("Filename Invalid!! Should be something like '/files/log.log' or '~/.minecraft/logs/<filename>'!!\n")
io.write("Exiting...") os.exit() --ruh roh
else io.write("File found at " .. file .. "! Please wait...\n\n\n") end
log_lines={}matches={}themes={}build={}
for line in io.lines(file) do
  table.insert(log_lines, line) --add line to table
end
for i = 1, #log_lines do
  if string.match(log_lines[i], "The theme was:") then
    table.insert(themes, { string.sub(log_lines[i], 56, #log_lines[i] - 1), i, string.sub(log_lines[i], 2, 9) }) --add theme + line number + time to themes
  end
end
for i = 1, #themes do
	if matches[themes[i][1]]==nil then matches[themes[i][1]]=0 end
	matches[themes[i][1]]=matches[themes[i][1]]+1 --add match
end
for k,v in pairs(matches) do
	if build[v]==nil then build[v]={} end
	table.insert(build[v],k.." : "..v.."\n") --sort by number found
end
for i=1,#build do
	for j=1,#build[i] do
		io.write(build[i][j]) --print themes to terminal
	end
end
