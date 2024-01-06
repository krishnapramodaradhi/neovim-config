return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true -- automatically calls require('Comment').setup()
}
