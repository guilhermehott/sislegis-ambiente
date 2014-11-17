instala_jboss() {
   instala_aplicacao

   echo "Criando o arquivo /etc/default/wildfly.conf ..."
   cat <<EOF | sudo tee /etc/default/wildfly.conf &> /dev/null
JAVA_HOME="/usr/lib/jvm/java"
JBOSS_USER=$USER
JBOSS_HOME="$JBOSS_HOME"
JBOSS_MODE=standalone
JBOSS_PARAMS="-b 0.0.0.0"
EOF

   echo "Criando o arquivo /etc/init.d/jboss ..."
   sudo cp $JBOSS_HOME/bin/init.d/wildfly-init-redhat.sh /etc/init.d/jboss
   sudo patch /etc/init.d/jboss < "$FUNCOES_DIR"/instalar/jboss.patch

   echo "Configurando inicialização automática ..."
   sudo chkconfig jboss on
}

remove_jboss() {
   local jboss_files="\
/etc/init.d/jboss \
/etc/default/wildfly.conf \
"
   for f in $jboss_files
   do
      echo "Removendo o arquivo \"$f\""
      sudo rm -f $f
   done

   remove_aplicacao
}

# vim: set ts=3 sw=3 expandtab:
