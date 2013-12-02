let g:pymode_rope_completion_bind = 'X'
let g:pymode_rope_autoimport = 0

source  plugin/pymode.vim 

describe 'pymode-plugin'

    before
        set filetype=python
    end

    after
        bd!
        bd!
    end

    it 'pymode rope auto open project in current working directory'
        let project_path = getcwd() . '/.ropeproject'
        Expect isdirectory(project_path)  == 0
        call pymode#rope#complete(0)
        Expect isdirectory(project_path)  == 1
    end

    it 'pymode rope completion'
        source  after/ftplugin/python.vim 
        Expect &ft == 'python'
        normal oimporX
        Expect getline('.') == 'import'
    end

end
