# sislegis-ambiente

Scripts para montagem do ambiente de desenvolvimento do [SISLEGIS] em [Darwin] ([OS X]), Linux ([Fedora]/[Ubuntu]) e [Cygwin] (Windows).

## montagem do ambiente no Fedora
Os passos a seguir demonstram a instalação do ambiente num Fedora 20. Nesse documento é utilizada a [vm-fedora](http://gdriv.es/vm-fedora), uma máquina virtual (VM) Fedora configurada por [Paulo Jerônimo] conforme os passos descritos em http://github.com/paulojeronimo/vms/. Essa VM contém, em sua instalação, apenas os pacotes básicos do Fedora. Obviamente, os passos de montagem desse ambiente podem ser replicados em qualquer outra máquina com um Fedora instalado nessa mesma versão. Se você estiver utilizando tua própria máquina para executar os passos a seguir, a recomendação é que você, em primeiro lugar, crie um novo usuário para seguir os passos apresentados. Do contrário, você pode utilizar o usuário da própria VM. Fazemos esta recomendação pelo fato de que vários arquivos localizados no `$HOME` do usuário serão configurados nos próximos passos.

Teu primeiro passo, antes de começar a configurar tua máquina (ou a vm-fedora), é fazer um fork deste projeto e do projeto [sislegis-dotfiles] para a tua conta no GitHub. O motivo disso é simples: tanto este projeto quando o sislegis-dotfiles serão coisas que você evoluirá continuamente. E, para salvar tuas alterações, você desejará fazer um push delas para o teu fork e, às vezes, fazer um `pull request` de tuas mudanças.

Seguindo em frente, se você está utilizando a vm-fedora, logue-se nela com o usuário `aluno` e a senha `@lun0123`. Se você está utilizando tua própria máquina, para criar um novo usuário em teu ambiente, denominado `sislegis`, execute os seguintes comandos para criar e se tornar esse usuário:
```bash
sudo useradd -m -s /bin/bash -G wheel sislegis
sudo su - sislegis
```

Se estiver utilizando a vm-fedora e quiser fazer um túnel reverso para acessar sua console a partir de teu HOST, execute o comando a seguir (_substituindo `pj` pelo nome de teu nome de usuário em tua máquina_):
```bash
ssh -f -N -R 2222:localhost:22 pj@base
```

Em seguida, a partir do teu HOST execute:
```bash
ssh -p 2222 aluno@localhost
```

Execute a instalação dos pacotes necessários para o download e a execução dos scripts do ambiente:
```bash
sudo yum -y install git tar unzip wget
```

Copie e cole estes comandos no shell:
```bash
unset ok
while [[ ! $ok =~ ^[Ss]$ ]]
do
   read -p 'Teu usuário no GitHub..........: ' GH_USER
   read -p 'Teu email no GitHub............: ' GH_EMAIL
   read -p 'Teu nome nos commits do GitHub.: ' GH_NAME
   read -p "Ok? (s p/ confirmar) " ok
done
```

Crie e verifique (com os comandos a seguir) se o arquivo `~/.github` está com as informações corretas solicitadas no loop anterior. Em caso negativo, reexecute este loop.
```bash
echo -e "GH_USER='$GH_USER'\nGH_EMAIL='$GH_EMAIL'\nGH_NAME='$GH_NAME'" > ~/.github
cat ~/.github
```

Baixe e instale o teu fork do projeto [sislegis-dotfiles] da seguinte forma:
```bash
mkdir -p github.com/$GH_USER
cd !$
git clone http://!$/sislegis-dotfiles
./sislegis-dotfiles/install
```

Faça o logout e o logon novamente. Observe que, ao refazer o logon, vários arquivos terão sido adicionados no diretório `$HOME` do usuário.

Ajuste as configurações do Git executando os comandos a seguir:
```bash
source ~/.github
git config --global user.name "$GH_NAME"
git config --global user.email "$GH_EMAIL"
```

Baixe e instale este projeto da seguinte forma:
```bash
cd github.com/$GH_USER
git clone http://!$/sislegis-ambiente
cd && ln -s $OLDPWD/sislegis-ambiente SisLegis
cd SisLegis && setenv "$PWD/ambiente"
```

Faça o logout e o logon novamente.

### instalação do Fedy
O [Fedy] é um software livre que apresenta um conjunto de scripts bash para facilitar a instalação de softwares proprietários no Fedora, como é o caso do [Oracle JDK].

Instale-o:
```bash
sudo bash -c "cd /tmp; curl http://satya164.github.io/fedy/fedy-installer -o fedy-installer && chmod +x fedy-installer && ./fedy-installer"
```

### instalação do JDK
Faça e teste a instalação do [Oracle JDK] (neste momento a versão 1.8.0_25) através da execução dos seguintes comandos:
```bash
sudo fedy -e oracle_jdk
java -version
```

### instalação das ferramentas Maven, Gradle, JBoss Forge e WildFly
Para tornar a instalação do ambiente de desenvolvimento homogênea entre diferentes plataformas é que existe esse projeto que você baixou e está utilizando.

Sua idéia básica é que, nas instalações das ferramentas, sejam utilizados o script `~/.scripts/instalar` (pertencente ao projeto [sislegis-dotfiles]) e as configurações realizadas em `~/SisLegis/configuracoes`. Também são utilizadas funções específicas ao ambiente e essas estão no diretório `~/SisLegis/funcoes`. 

É claro que, hoje em dia, existem soluções interessantes que também poderiam ser utilizadas para resolver o problema de instalações de ambientes (algo conhecido como provisionamento). Só para citar algumas das ferramentas mais conhecidas, temos o [Puppet] e o [Chef]. Entretanto, os scripts deste projeto (escritos apenas em Bash) cumprem o seu papel a contento.

Façamos instalação do [Maven] através da execução do seguinte comando:
```bash
maven_instalar
```

Observe a saída do comando acima e note que, após sua execução, o Maven está instalado e disponível no diretório `~/SisLegis/ferramentas/`.

Façamos também a instalação do [Gradle], do [JBoss Forge] e do [WildFly] executando os seguintes comandos:
```bash
gradle_instalar
#forge_instalar
jboss_instalar
```

## montagem do ambiente no Darwin
TODO

## montagem do ambiente no Cygwin
TODO - (_talvez eu (PJ) nunca escreva isso_)

## todo
* Estes scripts ainda precisam de adaptações para que possam funcionar nos seguintes sistemas:
    * [Ubuntu]
    * [Cygwin]

[Paulo Jerônimo]:http://github.com/paulojeronimo
[SISLEGIS]:http://pensandoodireito.github.io/sislegis-site
[sislegis-dotfiles]:http://github.com/pensandoodireito/sislegis-dotfiles
[Darwin]:http://support.apple.com/kb/ta25634
[OS X]:https://www.apple.com/osx/what-is/
[Fedora]:http://fedoraproject.org
[Ubuntu]:http://www.ubuntu.com/
[Cygwin]:http://cgywin.com
[Fedy]:http://satya164.github.io/fedy/
[Oracle JDK]:http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html
[Puppet]:http://puppetlabs.com/
[Chef]:https://www.getchef.com/
[Maven]:https://maven.apache.org
[Gradle]:http://www.gradle.org/
[JBoss Forge]:http://forge.jboss.org/
[WildFly]:http://wildfly.org/

<!---
vim: set syntax=markdown:
--->
