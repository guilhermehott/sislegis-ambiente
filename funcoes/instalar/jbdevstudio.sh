instala_jbdevstudio() {
  echo "Instalando o JBoss Developer Studio através do java ..."
  java -jar "$INSTALADORES_DIR/${!APP_INSTALADOR}" "$CONFIGURACOES_DIR/`uname`/jbdevstudio/InstallConfigRecord.xml"
}

remove_jbdevstudio() {
  java -jar "$FERRAMENTAS_DIR/jbdevstudio/Uninstaller/uninstaller.jar"
}

# vim: set ts=2 sw=2 expandtab:
