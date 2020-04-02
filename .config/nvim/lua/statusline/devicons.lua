local M = {}

local extensionTable = {

  -- Filetype
  ['awk']             = '',
  ['chaskell']        = '',
  ['cfg']             = '',
  ['clojure']         = '',
  ['cpp']             = '',
  ['css']             = '',
  ['diff']            = '',
  ['dosbatch']        = '',
  ['dosini']          = '',
  ['erlang']          = '',
  ['forth']           = '',
  ['go']              = '',
  ['haskell']         = '',
  ['hex']             = '',
  ['html']            = '',
  ['icon']            = '',
  ['java']            = '',
  ['javascript']      = '',
  ['javascriptreact'] = '',
  ['json']            = '',
  ['less']            = '',
  ['lhaskell']        = '',
  ['lisp']            = '',
  ['lua']             = '',
  ['markdown']        = '',
  ['msql']            = '',
  ['mysql']           = '',
  ['ocaml']           = 'λ',
  ['php']             = '',
  ['python']          = '',
  ['rmd']             = '',
  ['ruby']            = '',
  ['rust']            = '',
  ['sass']            = '',
  ['scala']           = '',
  ['scss']            = '',
  ['twig']            = '',
  ['typescriptreact'] = '',
  ['vim']             = '',
  ['vue']             = '﵂',
  ['xhtml']           = '',
  ['xml']             = '',
  ['yml']             = '',
  ['zsh']             = '',

  -- Extension
  ['bin']          = '',
  ['coffee']       = '',
  ['conf']         = '',
  ['d']            = '',
  ['dart']         = '',
  ['db']           = '',
  ['dump']         = '',
  ['dylib']        = '',
  ['f#']           = '',
  ['fsi']          = '',
  ['fsx']          = '',
  ['hbs']          = '',
  ['ini']          = '',
  ['lock']         = '',
  ['log']          = '',
  ['mustache']     = '',
  ['pl']           = '',
  ['plist']        = '况',
  ['pm']           = '',
  ['pp']           = '',
  ['ps1']          = '',
  ['rmeta']        = '',
  ['rss']          = '',
  ['slim']         = '',
  ['sln']          = '',
  ['so']           = '',
  ['styl']         = '',
  ['suo']          = '',
  ['swift']        = '',
  ['t']            = '',
  ['toml']         = '',
  ['ts']           = '',
  ['tsx']          = '',
  ['txt']          = '',
  ['gz']           = '',
  ['zip']          = '',
  ['ai']           = '',
  ['psd']          = '',
  ['psb']          = '',
  ['jpg']          = '',
  ['jpeg']         = '',
  ['bmp']          = '',
  ['png']          = '',
  ['gif']          = '',
  ['fsscript']     = '',
  ['timestamp']    = '﨟',
  ['xcplayground'] = '',
  ['ejs']          = '',
  ['jsx']          = '',
  ['js']           = '',
  ['es']           = '',
  ['mjs']          = '',
  ['bat']          = '',
  ['sys']          = '',
  ['c++']          = '',
  ['cxx']          = '',
  ['cc']           = '',
  ['cp']           = '',
  ['c']            = '',
  ['cljs']         = '',
  ['edn']          = '',
  ['clj']          = '',
  ['cljx']         = '',
  ['cljc']         = '',
  ['rej']          = '',
  ['erl']          = '',
  ['hrl']          = '',
  ['yaws']         = '',
  ['ex']           = '',
  ['exs']          = '',
  ['eex']          = '',
  ['fs']           = '',
  ['ft']           = '',
  ['fth']          = '',
  ['h']            = '',
  ['hpp']          = '',
  ['hxx']          = '',
  ['h32']          = '',
  ['ico']          = '',
  ['icn']          = '',
  ['htm']          = '',
  ['xht']          = '',
  ['hs']           = '',
  ['hs-boot']      = '',
  ['lhs']          = '',
  ['chs']          = '',
  ['jav']          = '',
  ['jsonp']        = '',
  ['lsp']          = '',
  ['jl']           = '',
  ['el']           = '',
  ['cl']           = '',
  ['L']            = '',
  ['md']           = '',
  ['mdown']        = '',
  ['mkd']          = '',
  ['mkdn']         = '',
  ['mdwn']         = '',
  ['ml']           = 'λ',
  ['mli']          = 'λ',
  ['mll']          = 'λ',
  ['mly']          = 'λ',
  ['phtml']        = '',
  ['ctp']          = '',
  ['py']           = '',
  ['pyc']          = '',
  ['pyo']          = '',
  ['pyd']          = '',
  ['pyw']          = '',
  ['ptl']          = '',
  ['pyi']          = '',
  ['rs']           = '',
  ['rlib']         = '',
  ['sh']           = '',
  ['bash']         = '',
  ['csh']          = '',
  ['fish']         = '',
  ['ksh']          = '',
  ['sql']          = '',
  ['rb']           = '',
  ['rbw']          = '',
  ['Rmd']          = '',
  ['Smd']          = '',
  ['smd']          = '',
  ['xul']          = '',
  ['wsdl']         = '',
  ['wpl']          = '',
  ['xmi']          = '',
  ['csproj']       = '',
  ['csproj.user']  = '',
  ['ui']           = '',
  ['xlf']          = '',
  ['xliff']        = '',
  ['yaml']         = '',

  -- Exact Match
  ['.bashprofile']       = '',
  ['.bashrc']            = '',
  ['.ds_store']          = '',
  ['.gitconfig']         = '',
  ['.gitignore']         = '',
  ['.gitlab-ci.yml']     = '',
  ['.gvimrc']            = '',
  ['.vimrc']             = '',
  ['.zshrc']             = '',
  ['_gvimrc']            = '',
  ['_vimrc']             = '',
  ['docker-compose.yml'] = '',
  ['dockerfile']         = '',
  ['dropbox']            = '',
  ['favicon.ico']        = '',
  ['gruntfile.coffee']   = '',
  ['gruntfile.js']       = '',
  ['gruntfile.ls']       = '',
  ['gulpfile.coffee']    = '',
  ['gulpfile.js']        = '',
  ['gulpfile.ls']        = '',
  ['license']            = '',
  ['mix.lock']           = '',
  ['node_modules']       = '',
  ['procfile']           = '',
  ['react.jsx']          = ''

}

M.deviconTable = setmetatable(extensionTable,{
  __index = function(extensionTable, key)
    local i = string.find(key, '[.*]')
    if i ~= nil then
      return extensionTable[string.sub(key, i+1)]
    end
  end
})

return M
