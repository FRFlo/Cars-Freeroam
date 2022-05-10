local BlockedExplosions = {1, 4, 5, 6, 7, 9, 15, 6, 17, 18, 25, 32, 33, 35, 36, 37, 38}

AddEventHandler('explosionEvent',function(sender, ev)
    for _, v in ipairs(BlockedExplosions) do
      if ev.explosionType == v then
        CancelEvent()
        return
      end
    end
  end
)