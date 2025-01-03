help([[
]])

prepend_path("MODULEPATH", "/apps/ops/test/spack-stack-1.6.0-nco/envs/nco-intel-19.1.3.304/install/modulefiles/Core")

local stack_intel_ver=os.getenv("stack_intel_ver") or "19.1.3.304"
local stack_cray_mpich_ver=os.getenv("stack_cray_mpich_ver") or "8.1.9"

local prod_util_ver=os.getenv("prod_util_ver") or "2.0.13"
local prod_envir_ver=os.getenv("prod_envir_ver") or "2.0.6"

load(pathJoin("stack-intel", intel_ver))
load(pathJoin("stack-cray-mpich", cray_mpich_ver))

prepend_path("MODULEPATH", "/apps/test/lmodules/core/")
load ("GrADS/2.2.2")
load(pathJoin("prod_util", prod_util_ver))
load(pathJoin("prod_envir", prod_envir_ver))

load("common-run")

whatis("Description: GSI Monitoring run-time environment on wcoss2")
