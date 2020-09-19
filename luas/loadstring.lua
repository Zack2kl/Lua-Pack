if not loadstring_old then
    loadstring_old = loadstring

    loadstring = function( lua )
        local random_name = (function()
            local str = ''

            for i=1, 12 do
                str = str .. string.char( math.random(65, 80) )
            end

            return str .. '.lua'
        end)()

        file.Write( random_name, lua )
        RunScript( random_name )
        file.Delete( random_name )
    end
end


-- Example 1; obfuscated
http.Get( 'https://pastebin.com/raw/SZLF0Db1', loadstring )


-- Example 2
loadstring([[
    return(function() 
        callbacks.Register( 'Draw', function()
            draw.Color(33, 33, 33, 190)
            draw.FilledRect(0, 30, 267, 54)
        
            draw.Color( 255, 0, 100, 255 )
            draw.Text( 6, 36, 'This is drawn using Example 2' )
        end)
    end)()
]])
