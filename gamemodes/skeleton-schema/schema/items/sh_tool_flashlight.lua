local ITEM = {}

ITEM.UniqueID = "tool_flashlight"
ITEM.Name = "Flashlight"
ITEM.Desc = "A generic flashlight."
ITEM.Model = Model("models/maxofs2d/lamp_flashlight.mdl")
ITEM.FOV = 4
ITEM.CamPos = Vector(-160, 125.70928955078, 5.1509056091309)
ITEM.NoCenter = true
ITEM.Weight = 1

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = false

--ITEM.CraftSound = "gunmetal"
--ITEM.CraftTime = 4

impulse.RegisterItem(ITEM)