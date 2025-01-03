help([[
]])

prepend_path("MODULEPATH", "/apps/ops/test/spack-stack-1.6.0-nco/envs/nco-intel-19.1.3.304/install/modulefiles/Core")

local stack_intel_ver=os.getenv("stack_intel_ver") or "19.1.3.304"
local stack_cray_mpich_ver=os.getenv("stack_cray_mpich_ver") or "8.1.9"
local cmake_ver=os.getenv("cmake_ver") or "3.23.1"

load(pathJoin("stack-intel", intel_ver))
load(pathJoin("stack-cray-mpich", cray_mpich_ver))
load(pathJoin("cmake", cmake_ver))

load("common")

whatis("Description: GSI Monitoring environment on WCOSS2")
