# Folder organization

## Folder sim
 -- tb: Contain the testbench file used to validated the RISC-V controller
    -- tb_RV_DL : top testbench for the all system
 
## Folder src
    -- detector: contain detector fault controller
    -- RV: contain RISC-V controller file
     -- datapath: modified to enable use dual-lockstep
    -- RV_DL: contain RISC-V Dual-Lockstep components of integration
        -- RV_DL : top component that integrate 2 RISC-V with Detector, IM of backup and Fault Injector to debug
    -- unified_src: contain all necessary componen for a fast new project
