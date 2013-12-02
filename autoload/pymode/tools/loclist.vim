let g:PymodeLocList= {}


fun! pymode#tools#loclist#init() "{{{
    return
endfunction "}}}


fun! g:PymodeLocList.init(raw_list) "{{{
    let obj = copy(self)
    let loc_list = filter(copy(a:raw_list), 'v:val["valid"] == 1')
    call obj.clear()
    return obj
endfunction "}}}


fun! g:PymodeLocList.current() "{{{
    if !exists("b:pymode_loclist")
        let b:pymode_loclist = g:PymodeLocList.init([])
    endif
    return b:pymode_loclist
endfunction "}}}


fun! g:PymodeLocList.is_empty() "{{{
    return empty(self._loclist)
endfunction "}}}


fun! g:PymodeLocList.clear() "{{{
    let self._loclist = []
    let self._messages = {}
endfunction "}}}


fun! g:PymodeLocList.extend(raw_list) "{{{
    call extend(self._loclist, a:raw_list)
    for issue in a:raw_list
        let self._messages[issue.lnum] = issue.text
    endfor
    return self
endfunction "}}}


fun! g:PymodeLocList.filter(filters) "{{{
    let loclist = []
    for error in self._loclist
        let passes_filters = 1
        for key in keys(a:filters)
            if get(error, key, '') !=? a:filters[key]
                let passes_filters = 0
                break
            endif
        endfor

        if passes_filters
            call add(loclist, error)
        endif

    endfor
    return loclist
endfunction "}}}
