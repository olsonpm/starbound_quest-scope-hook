-------------
-- Imports --
-------------

require "/luahooks/hooks.lua"
require "/luahooks/utils.lua"


----------
-- Main --
----------

function init()
  luaHooks.initIfNotAlready()
  self.hooks = luaHooks.questScopeHook["/quests/scripts/questscopehook.lua"]

  luaHooks.utils.callHooksWithArgs(self.hooks.onInit, self)
end

function update(dt)
  luaHooks.utils.callHooksWithArgs(self.hooks.onUpdate, self, dt)
end
