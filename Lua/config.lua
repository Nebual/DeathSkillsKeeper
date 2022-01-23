local config = {}

-- Number of permanent skill points to lose on death
config.skillToLoseOnDeathFixed = 5

-- Don't drop skill below minimum:
-- "startMax" uses the Job's max starting skill (eg. Captain can start with Weapons 30),
-- "startMin" uses the low starting range (eg. Captain can start with Weapons 1),
-- a number (eg. 20) will set a fixed minimum
config.skillKeepAbove = "startMax"



return config
