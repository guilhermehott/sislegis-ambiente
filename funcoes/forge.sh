# instala o Forge
forge_instalar() { instalar forge "$@"; }

# remove o Forge
forge_remover() { remover forge "$@"; }

# instala addons para o Forge
forge_instalar_addons() {
  echo "Instalando o addon para o Gradle ..."
  forge -i org.jboss.forge.addon:gradle

  echo "Instalando o addon para o AgularJS ..."
  forge -i org.jboss.forge.addon:angularjs
}

# vim: set ts=2 sw=2 expandtab:
