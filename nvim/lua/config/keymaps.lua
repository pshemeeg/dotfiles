local map = vim.keymap.set

-- Podstawowe
map("n", "<leader>w", ":w<CR>", { desc = "Zapisz" })
map("n", "<leader>q", ":q<CR>", { desc = "Zamknij" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Zapisz i zamknij" })

-- Poruszanie się między oknami (jak w Hyprland — hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Okno w lewo" })
map("n", "<C-l>", "<C-w>l", { desc = "Okno w prawo" })
map("n", "<C-k>", "<C-w>k", { desc = "Okno w górę" })
map("n", "<C-j>", "<C-w>j", { desc = "Okno w dół" })

-- Przenoszenie linii w górę/dół
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Przenieś linię w dół" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Przenieś linię w górę" })

-- Lepsze wcięcia w trybie visual (zostaje zaznaczenie)
map("v", "<", "<gv", { desc = "Wcięcie w lewo" })
map("v", ">", ">gv", { desc = "Wcięcie w prawo" })

-- Schowek systemowy
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Kopiuj do schowka" })
map("n", "<leader>p", '"+p', { desc = "Wklej ze schowka" })

-- Czyszczenie podświetlenia wyszukiwania
map("n", "<Esc>", ":noh<CR>", { desc = "Wyczyść podświetlenie" })

-- Podział okien
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Podziel pionowo" })
map("n", "<leader>sh", ":split<CR>", { desc = "Podziel poziomo" })

map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Formatuj kod" })
