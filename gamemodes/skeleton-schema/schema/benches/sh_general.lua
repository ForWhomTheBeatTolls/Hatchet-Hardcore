local BENCH = {}

BENCH.Class = "general"
BENCH.Name = "Industrial Workbench"
BENCH.Desc = "Can be used to craft all kinds of items."
BENCH.Model = "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl"
BENCH.Illegal = true
BENCH.NotIllegalFor = {TEAM_CP}

impulse.RegisterBench(BENCH)