#[[ "$MMLSPARK_PROFILE" != "" ]] || . "$HOME/.mmlspark_profile"

# .bashrc

# User specific aliases and functions

#alias su="$HOME/.bin/su"
alias less='less -r'
alias vi='vim'
alias gitlog='git log --graph --all --decorate'
alias gitst='git status'
alias arthas='$HOME/.software/arthas/as.sh'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function sf2_old_pb()
{
  MYLOCAL="$HOME/.mylocal"
  export PATH="$MYLOCAL/bin:$PATH"
  export C_INCLUDE_PATH="$MYLOCAL/include:$C_INCLUDE_PATH"
  export CPLUS_INCLUDE_PATH="$MYLOCAL/include:$CPLUS_INCLUDE_PATH"
  export LD_LIBRARY_PATH="$MYLOCAL/lib:$LD_LIBRARY_PATH"
  export LIBRARY_PATH="$MYLOCAL/lib:$LIBRARY_PATH"
}
#sf2_old_pb

export JAVA_HOME="$HOME/.software/jdk8/"
export PATH="$JAVA_HOME/bin:$PATH"
export CLASSPATH="$CLASSPATH:$JAVA_HOME/lib"

#
export SCALA_HOME="$HOME/.software/scala-2.12"
export PATH="$SCALA_HOME/bin:$PATH"
#export CLASSPATH="$CLASSPATH:$(echo $(find $SCALA_HOME/ -name '*.jar') | tr ' ' ':')"

#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
#export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

export SVN_EDITOR=vim

export CSCOPE_DB="$HOME/.cscope/cscope.out"

#export PATH="/opt/vtune_amplifier_xe/bin64:$PATH"
#export PATH="/opt/phantomjs/bin:$PATH"

#export PATH="$PATH:/usr/local/zookeeper/bin"

#if [ -f /opt/intel/vtune_amplifier_xe/amplxe-vars.sh ]; then
#    . /opt/intel/vtune_amplifier_xe/amplxe-vars.sh >/dev/null 2>&1
#fi

#prevent dialogue /usr/libexec/openssh/gnome-ssh-askpass
export SSH_ASKPASS=

export GOPATH=$HOME/.go
export PATH="$PATH:$GOPATH/bin"

#export STORM_HOME=$HOME/SecureCRT/apache-storm-1.1.1
#export PATH="$PATH:$STORM_HOME/bin"

function hadoop2() {
  export HADOOP_HOME=$HOME/GPL/hadoop-2.9.2
  export HBASE_HOME=$HOME/GPL/hbase-1.4.9
  export HIVE_HOME=$HOME/GPL/apache-hive-2.3.5-bin
  export HCAT_LOG_DIR=$HIVE_HOME/logs
  export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$HIVE_HOME/bin:$HIVE_HOME/hcatalog/sbin"
}

function hadoop3() {
  export HADOOP_HOME=$HOME/GPL/hadoop-3.3.4
  export HBASE_HOME=$HOME/GPL/hbase-2.4.5
  export HIVE_HOME=$HOME/GPL/apache-hive-3.1.3-bin
  export HCAT_LOG_DIR=$HIVE_HOME/logs
  export PATH="$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$HIVE_HOME/bin:$HIVE_HOME/hcatalog/sbin"
}

hadoop2

export PYTHONPATH=$HOME/programming/python-test/site-packages
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_USER_NAME=hadoop

export PATH=$PATH:$HOME/.software/helm/linux-amd64

export PATH="$PATH:$HOME/.ft"

export MAVEN_HOME=$HOME/.software/apache-maven
export PATH=$PATH:$MAVEN_HOME/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

export PATH=$HOME/.software/apache-pulsar/bin:$PATH
export PATH=/opt/Qt/QtIFW-4.5.2/bin:$PATH

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export PATH="$(brew --prefix bison)/bin:$PATH"
export PATH="$HOME/programming/bash-test/oceanus:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"

export PS1='lzs:\W\$ '
eval "$(/opt/homebrew/bin/brew shellenv)"
