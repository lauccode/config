-- Charger l’API standard de vis
require('vis')

-- visrc.lua in home

-----------------------------------------------------------
-- Installation automatique de vis-plug si absent
-----------------------------------------------------------
local plug = (function ()
    if not pcall(require, 'plugins/vis-plug') then
        os.execute(
            'git clone --quiet https://github.com/erf/vis-plug ' ..
            (os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config') ..
            '/vis/plugins/vis-plug'
        )
    end
    return require('plugins/vis-plug')
end)()

-----------------------------------------------------------
-- Déclaration des plugins
-----------------------------------------------------------
local plugins = {
    -- Curseurs multiples
    { 'erf/vis-cursors' },
    -- Highlight avancé (alias hi)
    -- { 'erf/vis-highlight', alias = 'hi' },
    -- Thème Gruvbox (sera appliqué automatiquement)
    { 'samlwood/vis-gruvbox', theme = true, file = 'gruvbox' },
    -- LSP externe (alias lsp)
    { 'fischerling/vis-lspc', alias = 'lsp' },
}

-----------------------------------------------------------
-- Initialisation + installation automatique
-----------------------------------------------------------
plug.init(plugins, true)

-----------------------------------------------------------
-- Configuration globale
-----------------------------------------------------------
-- vis.events.subscribe(vis.events.INIT, function()
--     -- Exemple : configurer le plugin highlight via alias
--     plug.plugins.hi.patterns['+\\n'] = { style = 'back:#444444' }
-- end)

-----------------------------------------------------------
-- Configuration par fenêtre
-----------------------------------------------------------
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set nu')
end)

-- --vffzf
-- #!/usr/bin/env bash
-- fzf --preview 'bat --color=always {}' --preview-window '~3' \
--     --bind 'enter:become($EDITOR {1})'

-- --vrfzf
-- #!/usr/bin/env bash
-- # 1. Search for text in files using Ripgrep
-- # 2. Interactively restart Ripgrep with reload action
-- # 3. Open the file in Vis
-- RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
-- INITIAL_QUERY="${*:-}"
-- : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
--     --bind "start:reload:$RG_PREFIX {q}" \
--     --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
--     --delimiter : \
--     --preview 'bat --color=always {1} --highlight-line {2}' \
--     --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
--     --bind 'enter:become($EDITOR +{2} {1})'
