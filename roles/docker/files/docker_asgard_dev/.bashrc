# include .bash_common
if [ -f $HOME/.bash_common ]; then
    . $HOME/.bash_common
fi

#----------------------
# Custom Commands
#----------------------
alias cdda='cd $HOME/dev/asgard'
alias cdb='cd $HOME/dev/asgard/build'
alias cdd='cd $HOME/dev'
alias cddd='cd $HOME/dev/dataset/asgard'

#----------------------
# Asgard Valhalla
#----------------------
alias asgard_clone_valhalla='cd $HOME/dev/asgard && rm -rf libvalhalla && git clone https://github.com/valhalla/valhalla.git libvalhalla && cd libvalhalla && git submodule update --init --recursive --depth=1 && git reset --hard f7c8a5bef64833787ffcc7640eb7b85ee624836b && cd --'
alias asgard_build_valhalla='cd $HOME/dev/asgard && mkdir -p libvalhalla/build && cd libvalhalla/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_SERVICES=Off -DENABLE_NODE_BINDINGS=Off -DENABLE_BENCHMARKS=Off -DCMAKE_INSTALL_PREFIX:PATH=$HOME/dev/asgard/valhalla_install && make -j5 install && cd --'
alias asgard_build_valhalla_d='cd $HOME/dev/asgard && mkdir -p libvalhalla/build && cd libvalhalla/build && cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_SERVICES=Off -DENABLE_NODE_BINDINGS=Off -DENABLE_BENCHMARKS=Off -DCMAKE_INSTALL_PREFIX:PATH=$HOME/dev/asgard/valhalla_install && make -j5 install && cd --'
alias asgard_build_asgard='cd $HOME/dev/asgard && mkdir -p build && cd build && cmake .. -DVALHALLA_INCLUDEDIR=$HOME/dev/asgard/valhalla_install/include -DVALHALLA_LIBRARYDIR=$HOME/dev/asgard/valhalla_install/lib -DCMAKE_BUILD_TYPE=Release && make -j5 && cd --'
alias asgard_build_asgard_d='cd $HOME/dev/asgard && mkdir -p build && cd build && cmake .. -DVALHALLA_INCLUDEDIR=$HOME/dev/asgard/valhalla_install/include -DVALHALLA_LIBRARYDIR=$HOME/dev/asgard/valhalla_install/lib -DCMAKE_BUILD_TYPE=Debug && make -j5 && cd --'
alias asgard_test='cd $HOME/dev/asgard/build/asgard && ctest && cd --'
alias asgard_run='$HOME/dev/asgard/build/asgard/asgard'

asgard_create_data(){
    cd $HOME/dev/asgard && mkdir -p data
    cd $HOME/dev/asgard/scripts && ./create_asgard_data.sh -e $HOME/dev/asgard/valhalla_install/bin -i $HOME/dev/dataset/asgard -o $HOME/dev/asgard/data
}

export ASGARD_VALHALLA_CONF=/home/bbrisset/dev/asgard/data/valhalla.json

#----------------------
# Prompt
#----------------------
export PS1="DOCKER-ASGARD: $C\A $R\u$Y-DOCKER@$W\h $G\w$Y $w\$ $NONE"
