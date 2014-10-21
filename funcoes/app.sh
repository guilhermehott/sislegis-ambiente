# .SisLegis - Links
app_site() { browse http://github.com/pensandoodireito/sislegis-app; }
# .SisLegis - Links.fim

app_baixar() { baixar-projeto app; }
app_remover() { projetos && rm -rf app; }
app() { projetos && cd app; }
app_pull() { app && git pull; }
