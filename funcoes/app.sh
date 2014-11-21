# .SisLegis - Links
app_site() { browse http://github.com/pensandoodireito/sislegis-app; }
# .SisLegis - Links.fim

app() { projetos && cd app; }
app_baixar() { baixar-app; }
app_remover() { projetos && rm -rf app; }
app_remote_add_upstream() { app && git remote add upstream http://github.com/pensandoodireito/sislegis-app; }
app_fetch_upstream() { app && git fetch upstream; }
app_merge_upstream_master() { app && git merge upstream/master; }
app_pull() { app && git pull; }
app_clean() { app && mvn clean; }
app_clean_package() { app && mvn clean package -DskipTests=true "$@"; }
app_package() { app && mvn package -DskipTests=true "$@"; }
app_deploy() {
    app
    local package=target/sislegis.war
    if [ -f $package ]
    then
        echo -n "Copiando \"$package\" para \"$JBOSS_DEPLOYMENTS\" ... "
        cp $package "$JBOSS_DEPLOYMENTS"/ && ok || falha
    else
        echo "\"$package\" não encontrado!"
    fi
}
app_undeploy() {
    app
    local package=$JBOSS_DEPLOYMENTS/sislegis.war
    if [ -f "$package" ]
    then
        echo -n "Removendo \"$package\" ... "
        rm -f "$package" && ok || falha
    else
        echo "\"`basename \"$package\"`\" não está implantado em \"$JBOSS_DEPLOYMENTS!\""
    fi
}
app_package_and_deploy() {
    app_package
    app_deploy
}
app_update_and_deploy() {
    app_fetch_upstream
    app_merge_upstream_master
    app_clean_package
    app_deploy
}

# vim: set ts=4 sw=4 expandtab:
