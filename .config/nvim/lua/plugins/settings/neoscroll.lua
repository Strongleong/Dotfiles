local cmp_status_ok, neoscroll = pcall(require, 'neoscroll')
if not cmp_status_ok then
    return
end
neoscroll.setup()
