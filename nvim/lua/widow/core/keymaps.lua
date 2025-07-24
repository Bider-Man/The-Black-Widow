local opts = {noremap = true, silent = true}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv", {desc = "Moves lines down in visual selection"})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Moves lines down in visual selection"})

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "Moves down in buffer with lines centered"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "Moves up in buffer with lines centered"})

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("x", "<leader>p", [["_dp]])
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", {desc = "Clear search highlights", silent = true})
vim.keymap.set("n", "x", '"_x', opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Replaces the word that the cursor is on globally"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true, desc = "Makes the current file executable"})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlights when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR")
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>tf>", "<cmd>tabnew %<CR>")

vim.keymap.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"})
vim.keymap.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
vim.keymap.set("n", "<leader>se", "<C-w>=", {desc = "Makes split equal in size"})
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current Split"})

vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, {desc = "Copies file path to clipboard."})
