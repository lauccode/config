-- load standard vis module, providing parts of the Lua API
require('vis')

-- git clone https://github.com/erf/vis-plug.git
local plug = require('plugins/vis-plug')

-- configure plugins in an array of tables with git urls and options 
local plugins = {

	-- load a plugin given a repo (https://github.com/ can be omitted and expects a 'init.lua' file)
	{ 'erf/vis-cursors' },

	-- first parameter is a shorthand for 'url'
	{ url = 'erf/vis-cursors' },

	-- specify the lua file to require (or theme to set) and give a ref (commit, branch, tag) to checkout
	-- { 'erf/vis-test', file = 'test', ref = 'some-branch' },

	-- specify an alias to later use to access plugin variables (see example below)
	{ 'erf/vis-highlight', alias = 'hi' },

	-- configure themes by setting 'theme = true'. The theme 'file' will be set on INIT
	{ 'samlwood/vis-gruvbox', theme = true, file = 'gruvbox' },
}

-- require and optionally install plugins on init
plug.init(plugins, true)

-- access plugins via alias
-- plug.plugins.hi.patterns[' +\n'] = { style = 'back:#444444' }


-- Mapping configuration example
vis.events.subscribe(vis.events.INIT, function()

end)

vis.events.subscribe(vis.events.WIN_OPEN, 
function(win)
	-- Your per window configuration options e.g.
	-- vis:command('set number')
    vis:command('set number')
end)
