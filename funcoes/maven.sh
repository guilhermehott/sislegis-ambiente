# sincroniza o diretório de backup dos repositórios do Maven
maven_backup() {
   local m2_backup=$BACKUPS_DIR/.m2

   if [ -d "$AMBIENTE_HOME"/.m2 ]
   then
      mkdir -p "$m2_backup"
      rsync -av --update --delete "$AMBIENTE_HOME"/.m2/ "$m2_backup"/
   else
      echo 'Ainda não há nenhum diretório .m2 para ser backupeado!'
   fi
}

# ajusta o link do diretório das configurações do Maven
maven_link() {
   local old_m2
   if [ -L ~/.m2 ]
   then
      [ "`readlink ~/.m2`" == "$AMBIENTE_HOME"/.m2 ] && return 0
      rm ~/.m2
   elif [ -d ~/.m2 ]
   then
      old_m2=~/.m2.`date "+%Y-%m-%d.%H:%M:%S"`
      echo "Movendo ~/.m2 para $old_m2"
      mv ~/.m2 $old_m2
   fi
   cd
   echo "Ligando ~/.m2 a \"$AMBIENTE_HOME/.m2\""
   ln -s "$AMBIENTE_HOME"/.m2
   cd - > /dev/null
}

# restaura o Maven a partir de seu backup
maven_restore() {
   local m2_backup=$BACKUPS_DIR/.m2
   if [ -d "$m2_backup" ]
   then
      rsync -av --update --delete "$m2_backup"/ "$AMBIENTE_HOME"/.m2/
      maven_link
   else
      echo 'Ainda não há nenhum backup do diretório .m2!'
   fi
}

# instala o Maven
maven_instalar() { instalar maven "$@"; }

# remove o Maven
maven_remover() { remover maven "$@"; }

# chamando essa função aqui, a cada troca de ambiente o link do Maven será reapontado
maven_link
