% cyclecloud-cmaq documentation master file, created by
%   sphinx-quickstart on Tue Jan 11 11:07:40 2022.
%   You can adapt this file completely to your liking, but it should at least
%   contain the root `toctree` directive.

## CMAQ on Azure Tutorial

```{warning}
This documentation is under continuous development.
Previous version is available here: <a href="https://cyclecloud-cmaq.readthedocs.io/en/cmaqv5.3.3/">CMAQv5.3.3 on Azure Tutorial</a>
```

## Community Multiscale Air Quality Model

The Community Multiscale Air Quality (CMAQ) modeling system an active open-source development project of the U.S. EPA. The CMAQ system is a Linux-based suite of models that requires significant computational resources and specific system configurations to run. CMAQ combines current knowledge in atmospheric science and air quality modeling, multi-processor computing techniques, and an open-source framework to deliver fast, technically sound estimates of ozone, particulates, toxics and acid deposition. 

* For additional background on CMAQ please visit the <a href="http://www.epa.gov/CMAQ">U.S. EPA CMAQ Website</a>.
* CMAQ is a community modeling effort that is supported by the <a href="http://www.cmascenter.org">Community Modeling and Analysis System (CMAS) Center</a> at the University of North Caroline at Chapel Hill.

## Tutorial Overview

This document provides tutorials and information on using Microsoft Azure Online Portal to create either a single Virtual Machine or a Cycle Cloud Cluster to run CMAQ. The tutorials are aimed at users with cloud computing experience that are already familiar with Azure.  For those with no cloud computing experience we recommend reviewing the Additional Resources listed in [chapter 15](user_guide_cyclecloud/help/index.md) of this document.

This document provides three hands-on tutorials that are designed to be read in order.  The Introductory Tutorial will walk you through setting up an Azure Account and logging into the Azure Portal Website.  You will learn how to set up your Azure Resource ID, configure and create a demo virtual machine, and exit and delete the virtual machine and all of the resources associated with it by deleting resource group.  The Intermediate Tutorial steps you through running a CMAQ test case on a single Virtual Machine with instructions to install CMAQ, libraries, and input data.  The Advanced Tutorial explains how to create a CycleCloud (High Performance Cluster) for larger compute jobs and install CMAQ, requried libraries and input data.  The remaining sections provide instructions on post-processing CMAQ output, comparing output and runtimes from multiple simulations, and copying output from CycleCloud to an Amazon Web Services (AWS) Simple Storage Service (S3) bucket.

## GMD Paper

Efstathiou, C. I., Adams, E., Coats, C. J., Zelt, R., Reed, M., McGee, J., Foley, K. M., Sidi, F. I., Wong, D. C., Fine, S., and Arunachalam, S.: Enabling high-performance cloud computing for the Community Multiscale Air Quality Model (CMAQ) version 5.3.3: performance evaluation and benefits for the user community, Geosci. Model Dev., 17, 7001–7027, <a href="https://doi.org/10.5194/gmd-17-7001-2024">https://doi.org/10.5194/gmd-17-7001-2024</a>, 2024. 
<a href="https://gmd.copernicus.org/articles/17/7001/2024/gmd-17-7001-2024.pdf>Enabling high-performance cloud computing for the Community Multiscale Air Quality Model (CMAQ) version 5.3.3: performance evaluation and benefits for the user community"</a>

## Azure Subscriptions 

The ability to use resources available in the Microsoft Azure Cloud is limited by quotas that are set at the subscription level. This tutorial was developed using UNC Chapel Hill's Enterprise account. Additional effort is being made to identify how to use a pay-as-you-go account, but these instructions have not been finalized. There may also be differences in how managed identies and user level permissions are set by the administrator of your enterprise level account that are not covered in this tutorial.

## Why might I need to use Azure Virtual Machine or CycleCloud?

An Azure Virtual Machine may be configured to run code compiled with Message Passing Interface (MPI) on a single high performance compute node. The intermediate tutorial demonstrates how to run CMAQ interactively on a single virtual machine running CMAQ with OpenMPI on multiple cpus.

The Azure CycleCloud may be configured to be the equivalent of a High Performance Computing (HPC) environment, including using job schedulers such as Slurm, running on multiple nodes/virtual machines using code compiled with Message Passing Interface (MPI), and reading and writing output to a high performance, low latency shared disk.  The advantage of using the slurm scheduler is that the number of compute nodes that will be provisioned can be adjusted to meet requirements of a given simulation. In addition, the user can reduce costs by using Spot instances rather than On-Demand for the compute nodes. CycleCloud also supports submitting multiple jobs to the job submission queue.

Our goal is make this user guide to running CMAQ on either a single Virtual Machine or the CycleCloud Cluster as helpful and user-friendly as possible. Any feedback is both welcome and appreciated.


Additional information on Azure CycleCloud:

<a href="https://techcommunity.microsoft.com/t5/azure-compute-blog/performance-amp-scalability-of-hbv3-vms-with-milan-x-cpus/ba-p/2939814">CycleCloud HPC Scalabilty</a>

<a href="https://azure.microsoft.com/en-gb/features/azure-cyclecloud/">Azure CycleCloud</a>


```{toctree}
   :numbered: 3
:caption: 'Contents:'
:maxdepth: 2

user_guide_cyclecloud/demo/index.md
user_guide_cyclecloud/System-Req/index.md
user_guide_cyclecloud/cmaq-vm/index.md
user_guide_cyclecloud/install/index.md
user_guide_cyclecloud/benchmark_cmaqv54+_hbv3_beeond/index.md
user_guide_cyclecloud/post/index.md
user_guide_cyclecloud/qa/index.md
user_guide_cyclecloud/timing/index.md
user_guide_cyclecloud/output/index.md
user_guide_cyclecloud/logout/index.md
user_guide_cyclecloud/Performance-Opt/index.md
user_guide_cyclecloud/help/index.md
user_guide_cyclecloud/future/index.md
user_guide_cyclecloud/contribute/index.md
user_guide_cyclecloud/optional/index.md
```
