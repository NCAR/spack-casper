require("strict")
local hook = require("Hook")

local mapT =
{
   grouped = {
      ['/environment$'] = "NCAR Environments",
      ['/Core$'] = "Compilers and Core Software",
      ['modules[/%.%d]*/nvhpc/23%.1$'] = 'Compiler-dependent Software - [nvhpc/23.1]',
      ['modules[/%.%d]*/oneapi/2023%.0%.0$'] = 'Compiler-dependent Software - [oneapi/2023.0.0]',
      ['modules[/%.%d]*/openmpi/4%.1%.5/nvhpc/23%.1$'] = 'MPI-dependent Software - [nvhpc/23.1 + openmpi/4.1.5]',
      ['modules[/%.%d]*/openmpi/4%.1%.5/oneapi/2023%.0%.0$'] = 'MPI-dependent Software - [oneapi/2023.0.0 + openmpi/4.1.5]',
      ['modules[/%.%d]*/openmpi/4%.1%.5/gcc/12%.2%.0$'] = 'MPI-dependent Software - [gcc/12.2.0 + openmpi/4.1.5]',
      ['modules[/%.%d]*/gcc/12%.2%.0$'] = 'Compiler-dependent Software - [gcc/12.2.0]',
   },
}

function avail_hook(t)
   local availStyle = masterTbl().availStyle
   local styleT     = mapT[availStyle]
   if (not availStyle or availStyle == "system" or styleT == nil) then
      return
   end

   for k,v in pairs(t) do
      for pat,label in pairs(styleT) do
         if (k:find(pat)) then
            t[k] = label
            break
         end
      end
   end
end

hook.register("avail",avail_hook)
