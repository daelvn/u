tasks:
  make:    => sh "rockbuild -m --delete #{@v}" if @v
  release: => sh "rockbuild -m -t #{@v} u"     if @v
  compile: => sh "moonc u.moon"
  docs:    => sh "docsify serve docs" if uses "serve"
  pack: =>
    show "Packing using amalg.lua"
    @o    or= @output or "u.lua"
    modules = for file in wildcard "alfons/*.moon" do "alfons.#{filename file}" 
    sh "amalg.lua -o #{@o} #{table.concat modules, ' '}"