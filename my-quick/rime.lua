--- Reference:
--- usage: https://github.com/hchunhui/librime-lua/wiki#usage
--- api  : https://github.com/hchunhui/librime-lua/wiki/Scripting#candidate
function date_translator(input, seg)
    if (input == "idd") then
        --- Candidate(type, start, end, text, comment)
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), ""))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), ""))
    end
    if (input == "idt") then
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), ""))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H時%M分%S秒"), ""))
    end
    if (input == "itt") then
        yield(Candidate("date", seg.start, seg._end, os.date("%H:%M:%S"), ""))
        yield(Candidate("date", seg.start, seg._end, os.date("%H時%M分%S秒"), ""))
    end
 end
 
 --- 過濾器: 單字優先
 function single_char_first_filter(input)
    local l = {}
    for cand in input:iter() do
        if (utf8.len(cand.text) == 1) then
            yield(cand)
        else
            table.insert(l, cand)
        end
    end
    for i, cand in ipairs(l) do
        yield(cand)
    end
 end