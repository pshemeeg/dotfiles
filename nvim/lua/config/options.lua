local opt = vim.opt

-- Numery linii
opt.number = true		-- pokaż numery linii
opt.relativenumber = true	-- numery relatywne (przydatne do skrótów)

-- Wcięcia
opt.tabstop = 2			-- tab = 2 spacje
opt.shiftwidth = 2		-- wcięcie = 2 spacje
opt.expandtab = true		-- zamień tab na spacje
opt.smartindent = true		-- automatyczne wcięcia

-- Wygląd
opt.termguicolors = true  -- pełne kolory
opt.cursorline = true     -- podświetl aktualną linię
opt.scrolloff = 8         -- zostaw 8 linii przy scrollowaniu
opt.signcolumn = "yes"    -- kolumna na ikony (git, błędy)
opt.wrap = false          -- nie zawijaj długich linii

-- Wyszukiwanie
opt.ignorecase = true     -- ignoruj wielkość liter
opt.smartcase = true      -- chyba że piszesz wielką literą
opt.hlsearch = false      -- nie podświetlaj po wyszukiwaniu

-- System
opt.clipboard = "unnamedplus" -- współdziel schowek z systemem
opt.undofile = true           -- pamiętaj historię zmian po zamknięciu
opt.swapfile = false          -- bez plików swap
opt.updatetime = 250          -- szybsza reakcja

-- Podział okien
opt.splitright = true    -- nowe okno po prawej
opt.splitbelow = true    -- nowe okno poniżej

-- Wyłącz nieużywane providery
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
