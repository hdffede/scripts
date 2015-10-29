#!/bin/bash
#   ___  __           _      __     __
#  / _ )/ /_ _____   | | /| / /__ _/ /____ _______
# / _  / / // / -_)  | |/ |/ / _ `/ __/ -_) __(_-<
#/____/_/\_,_/\__/   |__/|__/\_,_/\__/\__/_/ /___/
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Build script to build PIO on Blue Waters

source /opt/modules/default/init/bash
#####################################
# CONFIG
#####################################
#
#$COMPILER = "Default"
$COMPILER = "Intel"
#$COMPILER = "PGI"

#####################################
# MODULES
#####################################
module list
# select module based on compiler preference
if [$COMPILER eq 'Intel']; then
  module swap PrgEnv-cray PrgEnv-intel
else
  if [$COMPILER eq 'PGI']; then
    module swap PrgEnv-cray PrgEnv-pgi
  else
    $COMPILER = "Default"
  fi
fi

echo "Compiler was set to ${COMPILER}"

module load torque
module load git
module load cmake
module load cray-hdf5-parallel/1.8.14
module load cray-netcdf-hdf5parallel/4.3.3.1
module load cray-parallel-netcdf/1.6.0

module list
#####################################
# ENV
#####################################

export CC="cc"
export FC="ftn"
export CXX="CC"


#####################################
# BUILD
#####################################
<<COMMENT
 cmake -DCMAKE_VERBOSE_MAKEFILE=TRUE \
-DPREFER_STATIC=TRUE \
-DNetCDF_PATH=${NETCDF_DIR} \
-DPnetCDF_PATH=${PARALLEL_NETCDF_DIR} \
-DHDF5_PATH=${HDF5_DIR} \
-DMPI_C_INCLUDE_PATH=${MPICH_DIR}/include \
-DMPI_Fortran_INCLUDE_PATH=${MPICH_DIR}/include \
-DMPI_C_LIBRARIES=${MPICH_DIR}/lib/libmpich.a \
-DMPI_Fortran_LIBRARIES=${MPICH_DIR}/lib/libmpichf90.a \
-DCMAKE_SYSTEM_NAME=Catamount \
../PIO_source/

 make
<<COMMENT
