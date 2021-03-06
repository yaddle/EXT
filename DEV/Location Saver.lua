menuIcon = "http://i.imgur.com/5YiKv0l.png"

local scrVer = "1.4"

local justDumpped = false
local dumpTimer = 0

local justSaved = false
local saveTimer = 0

local PMenuLS = MenuElement({type = MENU, id = "PMenuLS", name = "Location List Creator", leftIcon = menuIcon})
PMenuLS:MenuElement({id = "Enabled", name = "Enabled", value = true})

PMenuLS:MenuElement({id = "arraySize",name = "List Count", value = 1, min = 1, max = 5, step = 1})
PMenuLS:MenuElement({id = "arrayCurrent",name = "Current List", value = 1, min = 1, max = 5, step = 1})
PMenuLS:MenuElement({id = "locationRead",name = "Save to List", key = string.byte("A")})
PMenuLS:MenuElement({id = "locationSave",name = "Write Lists to File", key = string.byte("P")})
PMenuLS:MenuElement({id = "createArray",name = "Clear Lists / New Lists", key = string.byte("N")})

locationArray = {}
emptyArray = {}
arraySize = {0,0,0,0,0,0,0,0,0,0}
locationArray1 = {}
locationArray2 = {}
locationArray3 = {}
locationArray4 = {}
locationArray5 = {}

--if i == 1 and arraySize[i] ~= 0 then

function OnLoad()
	justDumpped = false
	dumpTimer = 0

	BuildLocationArray()
end

function OnTick()
	--print(myHero:GetSpellData(1).castTime)
	if not PMenuLS.Enabled:Value() then return end

	if justDumpped then
		dumpTimer = dumpTimer + 1;
		if dumpTimer >= 30 then
			justDumpped = false
			dumpTimer = 0
		end
	else
		if PMenuLS.createArray:Value() then
			BuildLocationArray()
		end
		if PMenuLS.locationSave:Value() then
			SaveLocationsToFile2()
		end
	end

	if justSaved then
		saveTimer = saveTimer + 1;
		if saveTimer >= 15 then
			justSaved = false
			saveTimer = 0
		end
	else
		if PMenuLS.locationRead:Value() then
			SaveLocationToArray2()
		end
	end
end

function OnDraw()


end


function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function SaveLocationToArray()
	local arrayCurrent = PMenuLS.arrayCurrent:Value()
	local currentPosition = Vector(math.floor(myHero.pos.x + 0.5),math.floor(myHero.pos.y + 0.5),math.floor(myHero.pos.z + 0.5))
	table.insert(locationArray[arrayCurrent],currentPosition)
	arraySize[arrayCurrent] = arraySize[arrayCurrent] + 1
	print("(" .. currentPosition.x .. ", " .. currentPosition.y .. ", " .. currentPosition.z .. ") Added to list at: " .. arrayCurrent .. ", " .. arraySize[arrayCurrent])

	justSaved = true
	saveTimer = 0
end

function SaveLocationToArray2()
	local arrayCurrent = PMenuLS.arrayCurrent:Value()
	local currentPosition = Vector(math.floor(myHero.pos.x + 0.5),math.floor(myHero.pos.y + 0.5),math.floor(myHero.pos.z + 0.5))

	if arrayCurrent == 1 then
		table.insert(locationArray1,currentPosition)
	elseif arrayCurrent == 2 then
		table.insert(locationArray2,currentPosition)
	elseif arrayCurrent == 3 then
		table.insert(locationArray3,currentPosition)
	elseif arrayCurrent == 4 then
		table.insert(locationArray4,currentPosition)
	elseif arrayCurrent == 5 then
		table.insert(locationArray5,currentPosition)
	else

	end
	arraySize[arrayCurrent] = arraySize[arrayCurrent] + 1
	print("(" .. currentPosition.x .. ", " .. currentPosition.y .. ", " .. currentPosition.z .. ") Added to list at: " .. arrayCurrent .. ", " .. arraySize[arrayCurrent])

	justSaved = true
	saveTimer = 0
end

function SaveLocationsToFile()
	local currentPosition;
	local fileName = os.date("%c") .. "-loc"
	local fileText = ""
	fileText = fileName .. "\n\n"
	fileName = fileName:gsub("%/", "-")
	fileName = fileName:gsub("%:", "_")
	print(fileName)

	for i=1,PMenuLS.arraySize:Value(),1 do
		fileText = fileText .. "{"
		for ii = 1, arraySize[i],1 do
			currentPosition = locationArray[i][ii]
			fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
			if ii < arraySize[i] then
				fileText = fileText .. ", "
			end
		end
		if i < PMenuLS.arraySize:Value() then
			fileText = fileText .. "},\n"
		else
			fileText = fileText .. "}"
		end
	end

	fileText = fileText .. "\n\nGenerated with Bobs Dev Tool."

	local file = io.open(COMMON_PATH .. fileName .. ".txt", "w")
	file:write(fileText)
	file:close()
	print(COMMON_PATH .. fileName .. ".txt")

	justDumpped = true
	dumpTimer = 0
end

function SaveLocationsToFile2()
	local currentPosition;
	local fileName = "Locations-" .. os.date("%c")
	local fileText = ""
	fileText = fileName .. "\n\n"
	fileName = fileName:gsub("%/", "-")
	fileName = fileName:gsub("%:", "_")
	print(fileName)

	for i=1,PMenuLS.arraySize:Value(),1 do
		fileText = fileText .. "{"

		if i == 1 then
			for ii = 1, arraySize[i],1 do
				currentPosition = locationArray1[ii]
				fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
				if ii < arraySize[i] then
					fileText = fileText .. ", "
				end
			end

		elseif i == 2 then
			for ii = 1, arraySize[i],1 do
				currentPosition = locationArray2[ii]
				fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
				if ii < arraySize[i] then
					fileText = fileText .. ", "
				end
			end

		elseif i == 3 then
			for ii = 1, arraySize[i],1 do
				currentPosition = locationArray3[ii]
				fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
				if ii < arraySize[i] then
					fileText = fileText .. ", "
				end
			end
			
		elseif i == 4 then
			for ii = 1, arraySize[i],1 do
				currentPosition = locationArray4[ii]
				fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
				if ii < arraySize[i] then
					fileText = fileText .. ", "
				end
			end

		elseif i == 5 then
			for ii = 1, arraySize[i],1 do
				currentPosition = locationArray5[ii]
				fileText = fileText .. "Vector(" ..  currentPosition.x .. "," .. currentPosition.y.. "," .. currentPosition.z .. ")"
				if ii < arraySize[i] then
					fileText = fileText .. ", "
				end
			end
		else

		end

		if i < PMenuLS.arraySize:Value() then
			fileText = fileText .. "},\n"
		else
			fileText = fileText .. "}"
		end
	end

	fileText = fileText .. "\n\nGenerated with Bobs List Creator Version: " .. scrVer .. ". \n(http://gamingonsteroids.com/topic/21041-dev-tool-location-list-creator/)"

	local file = io.open(COMMON_PATH .. fileName .. ".txt", "w")
	file:write(fileText)
	file:close()
	print(COMMON_PATH .. fileName .. ".txt")

	justDumpped = true
	dumpTimer = 0
end

function BuildLocationArray()
	locationArray = {}
	arraySize = {0,0,0,0,0,0,0,0,0,0}

	locationArray1 = {}
	locationArray2 = {}
	locationArray3 = {}
	locationArray4 = {}
	locationArray5 = {}

	print("Array Built")

	justDumpped = true
	dumpTimer = 0
end