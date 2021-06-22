# include .bash_common
if [ -f $HOME/.bash_common ]; then
    . $HOME/.bash_common
fi

export PATH=$PATH:~/dev/build/navitia_docker/release/ed

#----------------------
# Custom Commands
#----------------------
alias cddn='cd $HOME/dev/navitia'
alias cdb='cd $HOME/dev/build/navitia_docker'
alias cdd='cd $HOME/dev'
alias cdr='cd $HOME/dev/run/kraken/docker'
alias cddd='cd $HOME/dev/dataset'

#----------------------
# Kraken
#----------------------
alias kraken_cmake_r='cd $HOME/dev/build/navitia_docker/release && cmake -DCMAKE_BUILD_TYPE=RELEASE $HOME/dev/navitia/source && cd -'
alias kraken_cmake_d='cd $HOME/dev/build/navitia_docker/debug && cmake -DCMAKE_BUILD_TYPE=DEBUG $HOME/dev/navitia/source && cd -'
alias kraken_make_r='cd $HOME/dev/build/navitia_docker/release && make -j6 && cd -'
alias kraken_make_d='cd $HOME/dev/build/navitia_docker/debug && make -j6 && cd -'
alias kraken_all_r='kraken_cmake_r && kraken_make_r'
alias kraken_all_d='kraken_cmake_d && kraken_make_d'
alias kraken_config='vim $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_run_r='$HOME/dev/build/navitia_docker/release/kraken/kraken $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_run_d='$HOME/dev/build/navitia_docker/debug/kraken/kraken $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_gdb_r='cd $HOME/dev/build/navitia_docker/release/kraken &&  gdb -tui --args ./kraken $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_gdb_d='cd $HOME/dev/build/navitia_docker/debug/kraken &&  gdb -tui --args ./kraken $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_tidy_r='cd $HOME/dev/build/navitia_docker/release && make tidy -j4'
alias kraken_tidy_d='cd $HOME/dev/build/navitia_docker/debug && make tidy -j4'

#----------------------
# Navitia
#----------------------
alias navitia_tests_r='cd /$HOME/dev/build/navitia_docker/release && make CTEST_OUTPUT_ON_FAILURE=1 test && cd -'
alias navitia_tests_d='cd /$HOME/dev/build/navitia_docker/debug && make CTEST_OUTPUT_ON_FAILURE=1 test && cd -'
alias navitia_docker_tests_r='cd $HOME/dev/build/navitia_docker/release && make docker_test && cd -'
alias navitia_docker_tests_d='cd $HOME/dev/build/navitia_docker/debug && make docker_test && cd -'

#----------------------
# Eitri
#----------------------
eitri_run(){
  run_eitri="cd $HOME/dev/navitia/source/eitri && PYTHONPATH=.:../navitiacommon python2.7 eitri.py -d $1 -e $HOME/dev/build/navitia_docker/release/ed"
  echo 'root' | su -c "$run_eitri" root
}

export PS1="DOCKER-NAVITIA: $C\A $R\u$Y-DOCKER@$W\h $G\w$Y $w\$ $NONE"
