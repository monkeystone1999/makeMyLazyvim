-- Force .h files to be treated as C++ headers instead of C headers
vim.filetype.add({
  extension = {
    h = "cpp",  -- Treat .h files as C++ headers
  },
})
