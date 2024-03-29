# Location variables
export INSTALLPATH_ROOT=/glade/u/apps/casper/default/spack/opt/spack
export MODULEPATH_ROOT=/glade/u/apps/casper/modules

# Lmod configuration
export LMOD_SYSTEM_NAME=casper
export LMOD_SYSTEM_DEFAULT_MODULES="ncarenv/23.10:intel/2023.2.1:ncarcompilers/1.0.0:openmpi/4.1.6:netcdf/4.9.2"

case "$MODULEPATH" in
    *"${MODULEPATH_ROOT}"*)
        ;;
    *)
        export MODULEPATH=$MODULEPATH_ROOT/environment
        ;;
esac

# Set defaults for Lmod behavior configuration
export LMOD_PACKAGE_PATH=/glade/work/csgteam/spack-deployments/casper/23.10/envs/public/util
export LMOD_CONFIG_DIR=/glade/work/csgteam/spack-deployments/casper/23.10/envs/public/util
export LMOD_AVAIL_STYLE=grouped:system

# Location of Lmod initialization scripts
export LMOD_ROOT=/glade/u/apps/casper/23.10/spack/opt/spack/lmod/8.7.24/gcc/7.5.0/m4jx

# Use shell-specific init
comm=`/bin/ps -p $$ -o cmd= |awk '{print $1}'|sed -e 's/-sh/csh/' -e 's/-csh/tcsh/' -e 's/-//g'`
shell=`/bin/basename $comm`

if [ -f $LMOD_ROOT/lmod/lmod/init/$shell ]; then
    . $LMOD_ROOT/lmod/lmod/init/$shell
else
    . $LMOD_ROOT/lmod/lmod/init/sh
fi

unset comm shell

# Set system default stuff
export NCAR_DEFAULT_PATH=/usr/local/bin:/usr/bin:/sbin:/bin
export NCAR_DEFAULT_MANPATH=/usr/local/share/man:/usr/share/man
export NCAR_DEFAULT_INFOPATH=/usr/local/share/info:/usr/share/info

export PATH=${PATH}:$NCAR_DEFAULT_PATH
export MANPATH=${MANPATH}:$NCAR_DEFAULT_MANPATH
export INFOPATH=${INFOPATH}:$NCAR_DEFAULT_INFOPATH

# Set PBS workdir if appropriate
if [ -n "$PBS_O_WORKDIR" ] && [ -z "$NCAR_PBS_JOBINIT" ]; then
    if [ -d "$PBS_O_WORKDIR" ]; then
        cd $PBS_O_WORKDIR
    fi

    export NCAR_PBS_JOBINIT=$PBS_JOBID
fi

# Load default modules
if [ -z "$__Init_Default_Modules" -o -z "$LD_LIBRARY_PATH" ]; then
  __Init_Default_Modules=1; export __Init_Default_Modules;
  module -q restore 
fi

# Hide specified modules
export LMOD_MODULERCFILE=/glade/work/csgteam/spack-deployments/casper/23.10/envs/public/util/hidden-modules
