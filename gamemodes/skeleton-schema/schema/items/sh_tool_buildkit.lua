local ITEM = {}

ITEM.UniqueID = "tool_buildkit"
ITEM.Name = "Building Kit"
ITEM.Desc =  "A magical piece of Combine technology. Can manifest props from the elements in the atmosphere."
ITEM.Model = Model("models/weapons/w_defuser.mdl")
ITEM.FOV = 38.644699140401
ITEM.CamPos = Vector(0, 25, 18.91117477417)
ITEM.NoCenter = true
ITEM.Weight = 5

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.CanStack = false

ITEM.Equipable = true
ITEM.EquipGroup = "tertiary"

impulse.RegisterItem(ITEM)
