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

function focusMouse(f)
    local moved = f()
    if moved then
        local frame = hs.window.focusedWindow():frame()
        hs.mouse.setAbsolutePosition(frame.center)
    end
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
hs.hotkey.bind(mash, 'h', function() focusMouse(function() return hs.window.focusedWindow():focusWindowWest() end) end)
hs.hotkey.bind(mash, 'l', function() focusMouse(function() return hs.window.focusedWindow():focusWindowEast() end) end)
hs.hotkey.bind(mash, 'k', function() focusMouse(function() return hs.window.focusedWindow():focusWindowNorth() end) end)
hs.hotkey.bind(mash, 'j', function() focusMouse(function() return hs.window.focusedWindow():focusWindowSouth() end) end)

hs.notify.new({title='Hammerspoon', informativeText='Config loaded'}):send()
