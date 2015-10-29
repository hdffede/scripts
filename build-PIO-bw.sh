#!/bin/bash
#   ___  __           _      __     __
#  / _ )/ /_ _____   | | /| / /__ _/ /____ _______
# / _  / / // / -_)  | |/ |/ / _ `/ __/ -_) __(_-<
#/____/_/\_,_/\__/   |__/|__/\_,_/\__/\__/_/ /___/
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Build script to build hdf5 on Blue Waters

source /opt/modules/default/init/bash
#####################################
#MODULES
#####################################
module list

#####################################
#ENV
#####################################

export CC="cc"
export FC="ftn"
export CXX="CC"


#####################################
#BUILD
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
