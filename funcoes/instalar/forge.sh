instala_forge() {
  instala_aplicacao

  echo -e "\nInstalando o addon para o Gradle ..."
  forge -i org.jboss.forge.addon:gradle

  echo -e "\nInstalando o addon para o AgularJS ..."
  forge -i org.jboss.forge.addon:angularjs
}

remove_forge() {
  remove_aplicacao
}

# vim: set ts=2 sw=2 expandtab:
