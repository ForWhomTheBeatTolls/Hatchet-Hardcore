function impulse.PlayGesture(ply, gesture, slot)

    if not ( ply ) then

        ply = LocalPlayer()

    end



    if not ( slot ) then

        slot = GESTURE_SLOT_CUSTOM

    end



    ply:AddVCDSequenceToGestureSlot(slot, ply:LookupSequence(gesture), 0, 1)

end