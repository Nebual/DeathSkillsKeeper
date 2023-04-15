local config = {}

-- Number of permanent skill points to lose on death (vanilla: 0, no cap)
config.skillToLoseOnDeathFixed = 10
-- Fraction of skill points above minimum to lose (vanilla: 0.75)
config.skillToLoseOnDeathPercent = 0.3333
-- Note: if both Fixed and Percent are enabled (> 0), then loss will be the lesser of the two (Fixed will be the upper limit of loss)
-- eg. Fixed=10, Percent=0.33, KeepAbove=startMax: A captain who dies with 40 Weapons (which has a startMax of 35) will lose 1.6 skill.
-- A captain who dies with 50 Weapons will lose 5 skill, and 90 Weapons will lose 10 skill.

-- Don't drop skill below minimum:
-- "startMax" uses the Job's max starting skill (eg. Captain can start with Weapons 35),
-- "startMin" uses the low starting range (eg. Captain can start with Weapons 1),
-- a number (eg. 20) will set a fixed minimum
config.skillKeepAbove = "startMax"



return config
