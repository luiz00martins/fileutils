--- Fileutils Library for ComputerCraft
--- @author PentagonLP, SkyTheCodeMaster
--- @version 1.0

--- Stores a file in a desired location
--- @param filepath string: Filepath where to create file (if file already exists, it gets overwritten)
--- @param content string: Content to store in file
local function storeFile(filepath,content)
	local writefile = fs.open(filepath,"w")
	writefile.write(content)
	writefile.close()
end

--- Reads a file from a desired location
--- @param filepath string: Filepath to the file to read
--- @param createnew string?: Content to store in new file and return if file does not exist
--- @return string|false: Content of the file; If createnew is nil and file doesn't exist boolean false is returned
local function readFile(filepath,createnew)
	local readfile = fs.open(filepath,"r")
	if not readfile then
		if not (createnew == nil) then
			storeFile(filepath,createnew)
			return createnew
		else
			return false
		end
	end
	local content = readfile.readAll()
	readfile.close()
	if content == nil then
		return false
	end
	return content
end

--- Stores a table in a file
--- @param filepath string: Filepath where to create file (if file already exists, it gets overwritten)
--- @param data table: Table to store in file
local function storeData(filepath,data)
	storeFile(filepath,textutils.serialize(data):gsub("\n",""))
end

--- Reads a table from a file in a desired location
--- @param filepath string: Filepath to the file to read
--- @param createnew boolean: If true, an empty table is stored in new file and returned if file does not exist
--- @return table|false: Table thats stored in the file; If createnew is false and file doesn't exist boolean false is returned
local function readData(filepath,createnew)
	if createnew then
		local content = readFile(filepath,textutils.serialize({}):gsub("\n",""))
		if content == false then
			return false
		else
			return textutils.unserialize(content)
		end
	else
		local content = readFile(filepath,nil)
		if content == false then
			return false
		else
			return textutils.unserialize(content:gsub("\n",""))
		end
	end
end

return {
	storeFile = storeFile,
	readFile = readFile,
	storeData = storeData,
	readData = readData,
}