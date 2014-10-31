# .SisLegis - Links
app_site() { browse http://github.com/pensandoodireito/sislegis-app; }
# .SisLegis - Links.fim

app_baixar() { baixar-projeto app; }
app_remover() { projetos && rm -rf app; }
app() { projetos && cd app; }
app_remote_add_upstream() { app && git remote add upstream http://github.com/pensandoodireito/sislegis-app; }
app_fetch_upstream() { app && git fetch upstream; }
app_merge_upstream_master() { app && git merge upstream/master; }
app_pull() { app && git pull; }
app_clean_package() { app && mvn clean package "$@"; }
