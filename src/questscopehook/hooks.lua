--
-- Just provide the schema here.  Ideally luaHooks would provide functions that
--   validate input but we can add it if and when people start running
--   into errors
--

luaHooks.questScopeHook = {
  ["/quests/scripts/questscopehook.lua"] = {
    onInit = {},
    onUpdate = {}
  }
}
