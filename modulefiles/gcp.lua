help([[
]])

prepend_path("MODULEPATH", "/apps/hpc-stack/libs/hpc-stack/modulefiles/stack")

local hpc_ver=os.getenv("hpc_ver") or "1.1.0"
local hpc_intel_ver=os.getenv("hpc_intel_ver") or "2021.3.0"
local hpc_impi_ver=os.getenv("hpc_impi_ver") or "2021.3.0"

load(pathJoin("hpc", hpc_ver))
load(pathJoin("hpc-intel", hpc_intel_ver))
load(pathJoin("hpc-impi", hpc_impi_ver))

load("common")

whatis("Description: GSI Monitoring environment on GCP with Intel Compilers")
