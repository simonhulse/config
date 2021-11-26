function ftplugin#tex#ToggleConceal()
    current = :set conceallevel?
    if current == 0
        :set conceallevel=2
    else
        :set conceallevel=0
    endif
endfunction
