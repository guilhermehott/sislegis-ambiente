# .SisLegis - Links
site_site() { browse http://github.com/pensandoodireito/sislegis-site; }
# .SisLegis - Links.fim

site_baixar() { baixar-projeto site; }
site_remover() { projetos && rm -rf site; }
site() { projetos && cd site; }
site_pull() { site && git pull; }
