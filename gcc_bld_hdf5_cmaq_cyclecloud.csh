#!/bin/csh -f

#  -----------------------
#  Download and build CMAQ
#  -----------------------
setenv BUILD /shared/build-hdf5
setenv IOAPI_DIR $BUILD/ioapi-3.2_branch_20200828/Linux2_x86_64gfortmpi
setenv NETCDF_DIR $BUILD/install/lib
setenv NETCDFF_DIR $BUILD/install/lib
cd $BUILD
#git clone -b 5.3.2_singularity https://github.com/lizadams/CMAQ.git CMAQ_REPO
git clone -b main https://github.com/USEPA/CMAQ.git CMAQ_REPO_v533

echo "downloaded CMAQ"
cd CMAQ_REPO_v533
setenv CLUSTER /shared/cyclecloud-cmaq
cp $CLUSTER/bldit_project_v533_cyclecloud.csh /shared/build-hdf5/CMAQ_REPO_v533
./bldit_project_v533_cyclecloud.csh
module load mpi/hpcx-v2.9.0 
mkdir -p $BUILD/hpcx_gcc
cd $BUILD/hpcx_gcc/CMAQ_v533/CCTM/scripts/
cp $CLUSTER/config_cmaq_cyclecloud_hdf5.csh ../../config_cmaq.csh
./bldit_cctm.csh gcc |& tee ./bldit_cctm.log
cp $CLUSTER/run_scripts/HB120v3/run*cyclecloud.csh $BUILD/hpcx_gcc/CMAQ_v533/CCTM/scripts/
cd $BUILD/hpcx_gcc/CMAQ_v533/CCTM/scripts/

# submit job to the queue using 
# sbatch run_cctm_2016_12US2.256pe.csh
# if you get the following error it means the compute nodes are not running 
#sbatch: error: Batch job submission failed: Required partition not available (inactive or drain)

# if you get this error
# sbatch run_cctm_2016_12US2.256pe.csh
#sbatch: error: Batch job submission failed: More processors requested than permitted


# Check the number of processors on the machine, and whether you have hyperthreading turned off
#!/bin/csh -f
#SBATCH --nodes=16
#SBATCH --ntasks-per-node=16
#Model 	vCPU 	Memory (GiB) 	Instance Storage (GiB)
# c5.4xlarge 	16 	32 	EBS-Only

# created a run script to use only 8 cpu per node for 128 pe job
#sbatch run_cctm_2016_12US2.128pe.csh
