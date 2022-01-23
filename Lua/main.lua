local config = dofile("Mods/DeathSkillsKeeper/Lua/config.lua")


if SERVER then
	print("DeathSkillsKeeper enabled")
	LuaUserData.RegisterType("Barotrauma.Range`1[System.Single]")

	function getSkillPrefabByIdentifier(characterInfo, identifier)
		if characterInfo == nil or characterInfo.Job == nil then return end
		local jobPrefab = characterInfo.Job.Prefab
		for k2, someSkillPrefab in pairs(jobPrefab.Skills) do
			if someSkillPrefab.Identifier == identifier then
				return someSkillPrefab
			end
		end
	end

	function getSkillMinimum(skillPrefab)
		if skillPrefab == nil then return 10 end

		if config.skillKeepAbove == "startMax" then
			return skillPrefab.LevelRange.End
		elseif config.skillKeepAbove == "startMin" then
			return skillPrefab.LevelRange.Start
		elseif config.skillKeepAbove and config.skillKeepAbove > 0 then
			return config.skillKeepAbove
		else
			return 10
		end
	end

	function reduceSkills(characterInfo)
		if config.skillToLoseOnDeathFixed > 0 then
			if characterInfo and characterInfo.Job then
				for k, skill in pairs(characterInfo.Job.Skills) do
					local skillPrefab = getSkillPrefabByIdentifier(characterInfo, skill.Identifier)
					local minimum = getSkillMinimum(skillPrefab)
					if skill.Level > minimum then
						local oldLevel = skill.Level
						skill.Level = math.max(1, skill.Level - config.skillToLoseOnDeathFixed, minimum)
						print("lowering skill ", skill.Identifier, " from ", oldLevel, " to ", skill.Level)
					end
				end
			end
		end
	end
	
	Hook.Add("reduceCharacterSkills", "DeathSkillsKeeper.reduceCharacterSkills", function(characterInfo)
		print("DeathSkillsKeeper hooked2 ", characterInfo)
		reduceSkills(characterInfo)

		return false -- return anything to prevent further execution (vanilla stats drop)
	end)
	
	Hook.HookMethod("Barotrauma.Networking.RespawnManager", "ReduceCharacterSkills", function (instance, ptable)
		print("DeathSkillsKeeper hooked3", ptable.characterInfo)
		
		reduceSkills(ptable.characterInfo)

		return false -- return anything to prevent further execution (vanilla stats drop)
	end, Hook.HookMethodType.Before)
	--]]
	print("DeathSkillsKeeper finished hooking")
end

