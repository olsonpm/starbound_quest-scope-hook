## Starbound - Quest Scope Hook

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
#### Table of Contents
- [What is it?](#what-is-it)
- [Why create it?](#why-create-it)
- [How to install it?](#how-to-install-it)
- [How it works](#how-it-works)
- [Notes](#notes)
- [Todo ideas](#todo-ideas)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### What is it?
This mod enables dependent mods to write functions which will run during the
init and update [Lua Hooks](https://github.com/olsonpm/starbound_lua-hooks)
of an ever-lasting invisible quest.  Your function will thus have access to
globals such as [`player`](https://starbounder.org/Modding:Lua/Tables/Player)
which are available in quest contexts, which is the purpose of this mod.


### Why create it?
I'm new to modding, but this seemed to be the easiest way for me to keep track
of whether a player contained an item in their inventory.  Because
`player_primary.lua` doesn't have access to the [`player`](https://starbounder.org/Modding:Lua/Tables/Player)
global, I use this mod in my [Health Monitor](https://github.com/olsonpm/starbound_health-monitor)
to poll the inventory and send a message to the player if the health monitor is
added or removed.  It can then stop or start the low health effect accordingly.


### How to install it
[Like this](https://github.com/olsonpm/starbound_health-monitor/blob/master/docs/how-to-install.md)


### How to use it
This mod makes use of my [Lua Hooks](https://github.com/olsonpm/starbound_lua-hooks)
mod to expose hooks, so first you'll need to add an init script as explained on
that repo.

Assume the following
1. you have a mod named `my-mod`
2. you patched the `initscripts.json` to add a script `my-init-script.lua`
3. you want to print "quest init ran!" when the invisible quest runs `init()`
4. and you want to print "quest update ran!" when the invisible quest runs `update()`

You would achieve 3 & 4 by writing:

```lua
-- /mods/my-mod/my-init-script.lua


--
-- just some convenience variables
--
local questScopeHooks = luaHooks.questScopeHook["/quests/scripts/questscopehook.lua"]

local functionsToRun = {
  onQuestInit = questScopeHooks.onInit,
  onQuestUpdate = questScopeHooks.onUpdate
}


--
-- now for the functions we want to call (assumptions 3 & 4)
--
local willRunOnQuestInit = function()
  sb.logInfo("quest init ran!")
end

-- this will spew a lot of lines in starbound.log!
local willRunOnQuestUpdate = function()
  sb.logInfo("quest update ran!")
end


--
-- and finally insert the functions into the hooks
--
table.insert(functionsToRun.onQuestInit, willRunOnQuestInit)
table.insert(functionsToRun.onQuestUpdate, willRunOnQuestUpdate)
```


### Notes

- I didn't know what `dt` value to put for the quest so I arbitrarily coded it
to 30.  If you feel this should be a different value then you should file an
issue so I can understand why.  I'm open to changing it.

- Currently this only exposes the `init()` and `update()` methods of the quest.
If you want more to be added just file an issue.
