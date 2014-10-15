instala_maven() {
   instala_aplicacao
   echo -n "Criando o diretório \"$AMBIENTE_HOME\"/.m2 ... "
   mkdir -p "$AMBIENTE_HOME"/.m2 && ok || falha
   maven_restore
}

remove_maven() {
   maven_backup
   echo -n "Removendo o diretório \"$AMBIENTE_HOME\./m2 ... "
   rm -rf "$AMBIENTE_HOME"/.m2 && ok || falha
   echo -n "Removendo o link ~/.m2 ... " 
   [ -L ~/.m2 ] && [ "`readlink ~/.m2`" == "$AMBIENTE_HOME/.m2" ] && rm ~/.m2 && ok || falha
   remove_aplicacao
}
