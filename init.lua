local mash = {"cmd", "alt", "ctrl"}

-- Toggle a window between its normal size, and being maximized
frameCache = {}
function toggle_window_maximized()
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        win:maximize()
    end
end

hs.hotkey.bind(mash, 'return', function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(mash, 'r', hs.reload)
hs.hotkey.bind(mash, 'f', toggle_window_maximized)
hs.hotkey.bind(mash, '`', hs.openConsole)
hs.hotkey.bind(mash, '.', hs.hints.windowHints)

-- multi monitor
hs.hotkey.bind(mash, 'n', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, 'p', hs.grid.pushWindowPrevScreen)

-- change focus
hs.hotkey.bind(mash, 'h', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():focusWindowSouth() end)

hs.notify.new({title='Hammerspoon', informativeText='Config loaded'}):send()
