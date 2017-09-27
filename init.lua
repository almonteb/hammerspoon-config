local mash = {"cmd", "alt", "ctrl"}

-- Toggle a window between its normal size, and being maximized
frameCache = {}
function toggleWindowMaximized()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

-- Brings focus to the scren by setting focus on the front-most application in it.
-- Also move the mouse cursor to the center of the screen. This is because
-- Mission Control gestures & keyboard shortcuts are anchored, oddly, on where the
-- mouse is focused.
function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(hs.window.orderedWindows(), hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
  local pt = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.setAbsolutePosition(pt)
end


hs.hotkey.bind(mash, 'return', function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(mash, 'r', hs.reload)
hs.hotkey.bind(mash, 'f', toggleWindowMaximized)
hs.hotkey.bind(mash, '`', hs.openConsole)
hs.hotkey.bind(mash, '.', hs.hints.windowHints)

-- multi monitor
hs.hotkey.bind(mash, 'n', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, 'p', hs.grid.pushWindowPrevScreen)

-- change focus
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():focusWindowSouth() end)

hs.hotkey.bind(mash, 'h', function() focusScreen(hs.window.focusedWindow():screen():next()) end)
hs.hotkey.bind(mash, 'l', function() focusScreen(hs.window.focusedWindow():screen():previous()) end)


hs.notify.new({title='Hammerspoon', informativeText='Config loaded'}):send()
