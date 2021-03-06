
################################################################
# This is a generated script based on design: system_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_top_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z045ffg900-2
#    set_property BOARD_PART xilinx.com:zc706:part0:1.0 [current_project]


# CHANGE DESIGN NAME HERE
set design_name system_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} ne "" && ${cur_design} eq ${design_name} } {

   # Checks if design is empty or not
   if { $list_cells ne "" } {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 1
   } else {
      puts "INFO: Constructing design in IPI design <$design_name>..."
   }
} elseif { ${cur_design} ne "" && ${cur_design} ne ${design_name} } {

   if { $list_cells eq "" } {
      puts "INFO: You have an empty design <${cur_design}>. Will go ahead and create design..."
   } else {
      set errMsg "ERROR: Design <${cur_design}> is not empty! Please do not source this script on non-empty designs."
      set nRet 1
   }
} else {

   if { [get_files -quiet ${design_name}.bd] eq "" } {
      puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

      create_bd_design $design_name

      puts "INFO: Making design <$design_name> as current_bd_design."
      current_bd_design $design_name

   } else {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 3
   }

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: Zynq_1
proc create_hier_cell_Zynq_1 { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Zynq_1() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR
  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir O clk_100mhz
  create_bd_pin -dir O clk_200mhz
  create_bd_pin -dir I hdmi_int
  create_bd_pin -dir O -from 0 -to 0 s_axi_aresetn
  create_bd_pin -dir O spdif_tx_o

  # Create instance: axi4_gp0, and set properties
  set axi4_gp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi4_gp0 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {0} CONFIG.M06_HAS_REGSLICE {1} CONFIG.NUM_MI {5} CONFIG.NUM_SI {1}  ] $axi4_gp0

  # Create instance: axi4_hp0, and set properties
  set axi4_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi4_hp0 ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {0} CONFIG.M00_HAS_DATA_FIFO {2} CONFIG.M00_HAS_REGSLICE {1} CONFIG.NUM_MI {1} CONFIG.NUM_SI {1} CONFIG.S00_HAS_DATA_FIFO {0} CONFIG.S00_HAS_REGSLICE {0} CONFIG.S01_HAS_DATA_FIFO {2} CONFIG.S01_HAS_REGSLICE {1}  ] $axi4_hp0

  # Create instance: axi_spdif_tx_0, and set properties
  set axi_spdif_tx_0 [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_spdif_tx:1.0 axi_spdif_tx_0 ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0 ]
  set_property -dict [ list CONFIG.CLKIN1_JITTER_PS {50.0} CONFIG.CLKOUT1_JITTER {327.996} CONFIG.CLKOUT1_PHASE_ERROR {264.435} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {12.288} CONFIG.PRIM_IN_FREQ {200.000} CONFIG.PRIM_SOURCE {No_buffer} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.USE_BOARD_FLOW {false} CONFIG.USE_DYN_PHASE_SHIFT {false} CONFIG.USE_LOCKED {false} CONFIG.USE_PHASE_ALIGNMENT {true} CONFIG.USE_SPREAD_SPECTRUM {false}  ] $clk_wiz_0

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]
  set_property -dict [ list CONFIG.C_AUX_RESET_HIGH {0}  ] $proc_sys_reset_1

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 processing_system7_1 ]
  set_property -dict [ list CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {25.000000} CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {50.000000} CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {25.000000} CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667.000000} CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_CLK0_FREQ {100000000} CONFIG.PCW_CLK1_FREQ {200000000} CONFIG.PCW_CLK2_FREQ {200000000} CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {800} CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {1} CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {100 Mbps} CONFIG.PCW_ENET0_RESET_ENABLE {1} CONFIG.PCW_ENET0_RESET_IO {MIO 47} CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} CONFIG.PCW_ENET1_RESET_ENABLE {0} CONFIG.PCW_ENET1_RESET_IO {<Select>} CONFIG.PCW_ENET_RESET_POLARITY {Active Low} CONFIG.PCW_EN_4K_TIMER {0} CONFIG.PCW_EN_CLK0_PORT {1} CONFIG.PCW_EN_CLK1_PORT {1} CONFIG.PCW_EN_CLK2_PORT {0} CONFIG.PCW_EN_CLK3_PORT {0} CONFIG.PCW_EN_CLKTRIG0_PORT {0} CONFIG.PCW_EN_EMIO_GPIO {0} CONFIG.PCW_EN_EMIO_TTC0 {1} CONFIG.PCW_EN_ENET0 {1} CONFIG.PCW_EN_GPIO {1} CONFIG.PCW_EN_I2C0 {1} CONFIG.PCW_EN_QSPI {1} CONFIG.PCW_EN_RST0_PORT {1} CONFIG.PCW_EN_SDIO0 {1} CONFIG.PCW_EN_TTC0 {1} CONFIG.PCW_EN_UART1 {1} CONFIG.PCW_EN_USB0 {1} CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_FCLK_CLK1_BUF {true} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_FPGA_FCLK1_ENABLE {1} CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {0} CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C0_RESET_ENABLE {1} CONFIG.PCW_I2C0_RESET_IO {MIO 46} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} CONFIG.PCW_I2C1_RESET_ENABLE {0} CONFIG.PCW_I2C1_RESET_IO {<Select>} CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {111.111115} CONFIG.PCW_I2C_RESET_POLARITY {Active Low} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_IRQ_F2P_MODE {REVERSE} CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_0_PULLUP {enabled} CONFIG.PCW_MIO_0_SLEW {slow} CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_10_PULLUP {enabled} CONFIG.PCW_MIO_10_SLEW {slow} CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_11_PULLUP {enabled} CONFIG.PCW_MIO_11_SLEW {slow} CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_12_PULLUP {enabled} CONFIG.PCW_MIO_12_SLEW {slow} CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_13_PULLUP {enabled} CONFIG.PCW_MIO_13_SLEW {slow} CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_14_PULLUP {enabled} CONFIG.PCW_MIO_14_SLEW {slow} CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_15_PULLUP {enabled} CONFIG.PCW_MIO_15_SLEW {slow} CONFIG.PCW_MIO_16_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_16_PULLUP {disabled} CONFIG.PCW_MIO_16_SLEW {slow} CONFIG.PCW_MIO_17_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_17_PULLUP {disabled} CONFIG.PCW_MIO_17_SLEW {slow} CONFIG.PCW_MIO_18_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_18_PULLUP {disabled} CONFIG.PCW_MIO_18_SLEW {slow} CONFIG.PCW_MIO_19_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_19_PULLUP {disabled} CONFIG.PCW_MIO_19_SLEW {slow} CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_1_PULLUP {enabled} CONFIG.PCW_MIO_1_SLEW {slow} CONFIG.PCW_MIO_20_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_20_PULLUP {disabled} CONFIG.PCW_MIO_20_SLEW {slow} CONFIG.PCW_MIO_21_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_21_PULLUP {disabled} CONFIG.PCW_MIO_21_SLEW {slow} CONFIG.PCW_MIO_22_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_22_PULLUP {disabled} CONFIG.PCW_MIO_22_SLEW {slow} CONFIG.PCW_MIO_23_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_23_PULLUP {disabled} CONFIG.PCW_MIO_23_SLEW {slow} CONFIG.PCW_MIO_24_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_24_PULLUP {disabled} CONFIG.PCW_MIO_24_SLEW {slow} CONFIG.PCW_MIO_25_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_25_PULLUP {disabled} CONFIG.PCW_MIO_25_SLEW {slow} CONFIG.PCW_MIO_26_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_26_PULLUP {disabled} CONFIG.PCW_MIO_26_SLEW {slow} CONFIG.PCW_MIO_27_IOTYPE {HSTL 1.8V} CONFIG.PCW_MIO_27_PULLUP {disabled} CONFIG.PCW_MIO_27_SLEW {slow} CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_28_PULLUP {disabled} CONFIG.PCW_MIO_28_SLEW {slow} CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_29_PULLUP {disabled} CONFIG.PCW_MIO_29_SLEW {slow} CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_2_SLEW {slow} CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_30_PULLUP {disabled} CONFIG.PCW_MIO_30_SLEW {slow} CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_31_PULLUP {disabled} CONFIG.PCW_MIO_31_SLEW {slow} CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_32_PULLUP {disabled} CONFIG.PCW_MIO_32_SLEW {slow} CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_33_PULLUP {disabled} CONFIG.PCW_MIO_33_SLEW {slow} CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_34_PULLUP {disabled} CONFIG.PCW_MIO_34_SLEW {slow} CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_35_PULLUP {disabled} CONFIG.PCW_MIO_35_SLEW {slow} CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_36_PULLUP {disabled} CONFIG.PCW_MIO_36_SLEW {slow} CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_37_PULLUP {disabled} CONFIG.PCW_MIO_37_SLEW {slow} CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_38_PULLUP {disabled} CONFIG.PCW_MIO_38_SLEW {slow} CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_39_PULLUP {disabled} CONFIG.PCW_MIO_39_SLEW {slow} CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_3_SLEW {slow} CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_40_PULLUP {disabled} CONFIG.PCW_MIO_40_SLEW {slow} CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_41_PULLUP {disabled} CONFIG.PCW_MIO_41_SLEW {slow} CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_42_PULLUP {disabled} CONFIG.PCW_MIO_42_SLEW {slow} CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_43_PULLUP {disabled} CONFIG.PCW_MIO_43_SLEW {slow} CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_44_PULLUP {disabled} CONFIG.PCW_MIO_44_SLEW {slow} CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_45_PULLUP {disabled} CONFIG.PCW_MIO_45_SLEW {slow} CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_46_PULLUP {enabled} CONFIG.PCW_MIO_46_SLEW {slow} CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_47_PULLUP {enabled} CONFIG.PCW_MIO_47_SLEW {slow} CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_48_PULLUP {disabled} CONFIG.PCW_MIO_48_SLEW {slow} CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_49_PULLUP {disabled} CONFIG.PCW_MIO_49_SLEW {slow} CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_4_SLEW {slow} CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_50_PULLUP {enabled} CONFIG.PCW_MIO_50_SLEW {slow} CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_51_PULLUP {enabled} CONFIG.PCW_MIO_51_SLEW {slow} CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_52_PULLUP {disabled} CONFIG.PCW_MIO_52_SLEW {slow} CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_53_PULLUP {disabled} CONFIG.PCW_MIO_53_SLEW {slow} CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_5_SLEW {slow} CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_6_SLEW {slow} CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_7_SLEW {slow} CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_8_SLEW {slow} CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 1.8V} CONFIG.PCW_MIO_9_PULLUP {enabled} CONFIG.PCW_MIO_9_SLEW {slow} CONFIG.PCW_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#USB Reset#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#SD 0#SD 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#I2C Reset#ENET Reset#UART 1#UART 1#I2C 0#I2C 0#Enet 0#Enet 0} CONFIG.PCW_MIO_TREE_SIGNALS {qspi1_ss_b#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_sclk#reset#qspi_fbclk#qspi1_sclk#qspi1_io[0]#qspi1_io[1]#qspi1_io[2]#qspi1_io[3]#cd#wp#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#reset#reset#tx#rx#scl#sda#mdc#mdio} CONFIG.PCW_M_AXI_GP0_FREQMHZ {100} CONFIG.PCW_NAND_CYCLES_T_AR {0} CONFIG.PCW_NAND_CYCLES_T_CLR {0} CONFIG.PCW_NAND_CYCLES_T_RC {2} CONFIG.PCW_NAND_CYCLES_T_REA {1} CONFIG.PCW_NAND_CYCLES_T_RR {0} CONFIG.PCW_NAND_CYCLES_T_WC {2} CONFIG.PCW_NAND_CYCLES_T_WP {1} CONFIG.PCW_NOR_CS0_T_CEOE {1} CONFIG.PCW_NOR_CS0_T_PC {1} CONFIG.PCW_NOR_CS0_T_RC {2} CONFIG.PCW_NOR_CS0_T_TR {1} CONFIG.PCW_NOR_CS0_T_WC {2} CONFIG.PCW_NOR_CS0_T_WP {1} CONFIG.PCW_NOR_CS0_WE_TIME {2} CONFIG.PCW_NOR_CS1_T_CEOE {1} CONFIG.PCW_NOR_CS1_T_PC {1} CONFIG.PCW_NOR_CS1_T_RC {2} CONFIG.PCW_NOR_CS1_T_TR {1} CONFIG.PCW_NOR_CS1_T_WC {2} CONFIG.PCW_NOR_CS1_T_WP {1} CONFIG.PCW_NOR_CS1_WE_TIME {2} CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} CONFIG.PCW_NOR_SRAM_CS0_T_RC {2} CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} CONFIG.PCW_NOR_SRAM_CS0_T_WC {2} CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {2} CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} CONFIG.PCW_NOR_SRAM_CS1_T_RC {2} CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} CONFIG.PCW_NOR_SRAM_CS1_T_WC {2} CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {2} CONFIG.PCW_NUM_F2P_INTR_INPUTS {2} CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.016} CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.018} CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.018} CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.016} CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.003} CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.006} CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.006} CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.003} CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {1} CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_PERIPHERAL_BOARD_PRESET {part0} CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} CONFIG.PCW_QSPI_GRP_IO1_ENABLE {1} CONFIG.PCW_QSPI_GRP_IO1_IO {MIO 0 9 .. 13} CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {0} CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 14} CONFIG.PCW_SD0_GRP_POW_ENABLE {0} CONFIG.PCW_SD0_GRP_WP_ENABLE {1} CONFIG.PCW_SD0_GRP_WP_IO {MIO 15} CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {25} CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} CONFIG.PCW_S_AXI_HP0_FREQMHZ {100} CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} CONFIG.PCW_TTC0_TTC0_IO {EMIO} CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} CONFIG.PCW_UART1_BAUD_RATE {115200} CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} CONFIG.PCW_UIPARAM_DDR_AL {0} CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} CONFIG.PCW_UIPARAM_DDR_BL {8} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.521} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.636} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.54} CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.621} CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} CONFIG.PCW_UIPARAM_DDR_CL {7} CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {92.3275} CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {92.3275} CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {92.3275} CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {92.3275} CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} CONFIG.PCW_UIPARAM_DDR_CWL {5.000000} CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {108.9255} CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {131.286} CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {131.83} CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {108.5285} CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.226} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.278} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.184} CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.309} CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {107.643} CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {132.917} CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {129.6135} CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {0} CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {108.6395} CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {8 Bits} CONFIG.PCW_UIPARAM_DDR_ENABLE {1} CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333313} CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} CONFIG.PCW_UIPARAM_DDR_PARTNO {Custom} CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {0} CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {0} CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} CONFIG.PCW_UIPARAM_DDR_T_FAW {25} CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {36.0} CONFIG.PCW_UIPARAM_DDR_T_RC {49.5} CONFIG.PCW_UIPARAM_DDR_T_RCD {7} CONFIG.PCW_UIPARAM_DDR_T_RP {7} CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} CONFIG.PCW_USB0_RESET_ENABLE {1} CONFIG.PCW_USB0_RESET_IO {MIO 7} CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} CONFIG.PCW_USB1_RESET_ENABLE {0} CONFIG.PCW_USB1_RESET_IO {<Select>} CONFIG.PCW_USB_RESET_POLARITY {Active Low} CONFIG.PCW_USE_CROSS_TRIGGER {0} CONFIG.PCW_USE_DMA0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_USE_M_AXI_GP0 {1} CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP1 {0} CONFIG.PCW_USE_S_AXI_HP2 {0} CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} CONFIG.preset {ZC706*}  ] $processing_system7_1

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list CONFIG.IN0_WIDTH {1} CONFIG.NUM_PORTS {2}  ] $xlconcat_0

  # Create instance: xlconstant_gnd_0, and set properties
  set xlconstant_gnd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_gnd_0 ]
  set_property -dict [ list CONFIG.CONST_VAL {0}  ] $xlconstant_gnd_0

  # Create interface connections
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi4_hp0/S00_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi4_gp0/M00_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi4_gp0/M01_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M02_AXI [get_bd_intf_pins axi4_gp0/M02_AXI] [get_bd_intf_pins axi_spdif_tx_0/S_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins axi4_gp0/M03_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M04_AXI [get_bd_intf_pins M04_AXI] [get_bd_intf_pins axi4_gp0/M04_AXI]
  connect_bd_intf_net -intf_net axi4_hp0_M00_AXI [get_bd_intf_pins axi4_hp0/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_spdif_tx_1_DMA_REQ [get_bd_intf_pins axi_spdif_tx_0/DMA_REQ] [get_bd_intf_pins processing_system7_1/DMA0_REQ]
  connect_bd_intf_net -intf_net processing_system7_1_DMA0_ACK [get_bd_intf_pins axi_spdif_tx_0/DMA_ACK] [get_bd_intf_pins processing_system7_1/DMA0_ACK]
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_pins DDR] [get_bd_intf_pins processing_system7_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_pins FIXED_IO] [get_bd_intf_pins processing_system7_1/FIXED_IO]
  connect_bd_intf_net -intf_net s00_axi_1 [get_bd_intf_pins axi4_gp0/S00_AXI] [get_bd_intf_pins processing_system7_1/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axi_spdif_tx_0/spdif_data_clk] [get_bd_pins clk_wiz_0/clk_out1]
  connect_bd_net -net logicvc_int_1 [get_bd_pins hdmi_int] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi4_gp0/ARESETN] [get_bd_pins axi4_gp0/M00_ARESETN] [get_bd_pins axi4_gp0/M01_ARESETN] [get_bd_pins axi4_gp0/M02_ARESETN] [get_bd_pins axi4_gp0/M03_ARESETN] [get_bd_pins axi4_gp0/M04_ARESETN] [get_bd_pins axi4_gp0/S00_ARESETN] [get_bd_pins axi4_hp0/ARESETN] [get_bd_pins axi4_hp0/M00_ARESETN] [get_bd_pins axi4_hp0/S00_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins axi_spdif_tx_0/DMA_REQ_RSTN] [get_bd_pins axi_spdif_tx_0/S_AXI_ARESETN] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
  connect_bd_net -net processing_system7_1_FCLK_CLK0 [get_bd_pins clk_100mhz] [get_bd_pins axi4_gp0/ACLK] [get_bd_pins axi4_gp0/M00_ACLK] [get_bd_pins axi4_gp0/M01_ACLK] [get_bd_pins axi4_gp0/M02_ACLK] [get_bd_pins axi4_gp0/M03_ACLK] [get_bd_pins axi4_gp0/M04_ACLK] [get_bd_pins axi4_gp0/S00_ACLK] [get_bd_pins axi4_hp0/ACLK] [get_bd_pins axi4_hp0/M00_ACLK] [get_bd_pins axi4_hp0/S00_ACLK] [get_bd_pins axi_spdif_tx_0/DMA_REQ_ACLK] [get_bd_pins axi_spdif_tx_0/S_AXI_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins processing_system7_1/DMA0_ACLK] [get_bd_pins processing_system7_1/FCLK_CLK0] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_1/S_AXI_HP0_ACLK]
  connect_bd_net -net processing_system7_1_FCLK_CLK1 [get_bd_pins clk_200mhz] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins processing_system7_1/FCLK_CLK1]
  connect_bd_net -net processing_system7_1_FCLK_RESET0_N [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins processing_system7_1/FCLK_RESET0_N]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_1/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_gnd_0_const [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconstant_gnd_0/dout]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Video_Display
proc create_hier_cell_Video_Display { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Video_Display() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CLKGEN
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HDMI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE_VDMA

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 axi_resetn
  create_bd_pin -dir I -type clk clk_100mhz
  create_bd_pin -dir I -type clk clk_200mhz
  create_bd_pin -dir O hdmi_int
  create_bd_pin -dir O hdmio_clk
  create_bd_pin -dir O -from 23 -to 0 hdmio_data
  create_bd_pin -dir O hdmio_de
  create_bd_pin -dir O hdmio_hsync
  create_bd_pin -dir O hdmio_vsync

  # Create instance: axi_clkgen_0, and set properties
  set axi_clkgen_0 [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_clkgen:1.0 axi_clkgen_0 ]

  # Create instance: axi_hdmi_tx_0, and set properties
  set axi_hdmi_tx_0 [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_hdmi_tx:1.0 axi_hdmi_tx_0 ]

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list CONFIG.c_enable_debug_info_6 {0} CONFIG.c_enable_debug_info_7 {0} CONFIG.c_enable_debug_info_14 {0} CONFIG.c_enable_debug_info_15 {0} CONFIG.c_include_mm2s_dre {0} CONFIG.c_include_s2mm {0} CONFIG.c_m_axis_mm2s_tdata_width {64} CONFIG.c_mm2s_genlock_mode {0} CONFIG.c_use_mm2s_fsync {1}  ] $axi_vdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI2_1 [get_bd_intf_pins S_AXI_CLKGEN] [get_bd_intf_pins axi_clkgen_0/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_HDMI_1 [get_bd_intf_pins S_AXI_HDMI] [get_bd_intf_pins axi_hdmi_tx_0/s_axi]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins S_AXI_LITE_VDMA] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_hdmi_tx_0/m_axis_mm2s] [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]

  # Create port connections
  connect_bd_net -net axi_clkgen_0_clk [get_bd_pins axi_clkgen_0/clk] [get_bd_pins axi_hdmi_tx_0/hdmi_clk]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_24_data [get_bd_pins hdmio_data] [get_bd_pins axi_hdmi_tx_0/hdmi_24_data]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_24_data_e [get_bd_pins hdmio_de] [get_bd_pins axi_hdmi_tx_0/hdmi_24_data_e]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_24_hsync [get_bd_pins hdmio_hsync] [get_bd_pins axi_hdmi_tx_0/hdmi_24_hsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_24_vsync [get_bd_pins hdmio_vsync] [get_bd_pins axi_hdmi_tx_0/hdmi_24_vsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_out_clk [get_bd_pins hdmio_clk] [get_bd_pins axi_hdmi_tx_0/hdmi_out_clk]
  connect_bd_net -net axi_hdmi_tx_0_m_axis_mm2s_fsync1 [get_bd_pins axi_hdmi_tx_0/m_axis_mm2s_fsync] [get_bd_pins axi_hdmi_tx_0/m_axis_mm2s_fsync_ret] [get_bd_pins axi_vdma_0/mm2s_fsync]
  connect_bd_net -net axi_resetn_1 [get_bd_pins axi_resetn] [get_bd_pins axi_clkgen_0/S_AXI_ARESETN] [get_bd_pins axi_hdmi_tx_0/s_axi_aresetn] [get_bd_pins axi_vdma_0/axi_resetn]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins hdmi_int] [get_bd_pins axi_vdma_0/mm2s_introut]
  connect_bd_net -net clk_200mhz_1 [get_bd_pins clk_200mhz] [get_bd_pins axi_clkgen_0/ref_clk]
  connect_bd_net -net clk_75mhz_1 [get_bd_pins clk_100mhz] [get_bd_pins axi_clkgen_0/S_AXI_ACLK] [get_bd_pins axi_hdmi_tx_0/m_axis_mm2s_clk] [get_bd_pins axi_hdmi_tx_0/s_axi_aclk] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set hdmio_clk [ create_bd_port -dir O hdmio_clk ]
  set hdmio_data [ create_bd_port -dir O -from 23 -to 0 hdmio_data ]
  set hdmio_de [ create_bd_port -dir O hdmio_de ]
  set hdmio_hsync [ create_bd_port -dir O hdmio_hsync ]
  set hdmio_vsync [ create_bd_port -dir O hdmio_vsync ]
  set spdif_tx [ create_bd_port -dir O spdif_tx ]
  set sys_clk [ create_bd_port -dir O sys_clk ]
  set sys_rd_cmd [ create_bd_port -dir O sys_rd_cmd ]
  set sys_rd_endcmd [ create_bd_port -dir I sys_rd_endcmd ]
  set sys_rdaddr [ create_bd_port -dir O -from 13 -to 2 sys_rdaddr ]
  set sys_rddata [ create_bd_port -dir I -from 31 -to 0 sys_rddata ]
  set sys_resetn [ create_bd_port -dir O -from 0 -to 0 sys_resetn ]
  set sys_wr_cmd [ create_bd_port -dir O sys_wr_cmd ]
  set sys_wraddr [ create_bd_port -dir O -from 13 -to 2 sys_wraddr ]
  set sys_wrdata [ create_bd_port -dir O -from 31 -to 0 sys_wrdata ]

  # Create instance: Video_Display
  create_hier_cell_Video_Display [current_bd_instance .] Video_Display

  # Create instance: Zynq_1
  create_hier_cell_Zynq_1 [current_bd_instance .] Zynq_1

  # Create instance: axi4_lite_controller_0, and set properties
  set axi4_lite_controller_0 [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi4_lite_controller:1.0 axi4_lite_controller_0 ]
  set_property -dict [ list CONFIG.C_SYS_ADDR_WIDTH {14} CONFIG.C_S_AXI_MIN_SIZE {0x00003FFF}  ] $axi4_lite_controller_0

  # Create interface connections
  connect_bd_intf_net -intf_net Zynq_1_M00_AXI [get_bd_intf_pins Zynq_1/M00_AXI] [get_bd_intf_pins axi4_lite_controller_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net Zynq_1_M01_AXI [get_bd_intf_pins Video_Display/S_AXI_HDMI] [get_bd_intf_pins Zynq_1/M01_AXI]
  connect_bd_intf_net -intf_net Zynq_1_M03_AXI [get_bd_intf_pins Video_Display/S_AXI_CLKGEN] [get_bd_intf_pins Zynq_1/M03_AXI]
  connect_bd_intf_net -intf_net Zynq_1_M04_AXI [get_bd_intf_pins Video_Display/S_AXI_LITE_VDMA] [get_bd_intf_pins Zynq_1/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins Zynq_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins Zynq_1/FIXED_IO]
  connect_bd_intf_net -intf_net s01_axi_1 [get_bd_intf_pins Video_Display/M_AXI_MM2S] [get_bd_intf_pins Zynq_1/S00_AXI]

  # Create port connections
  connect_bd_net -net Video_Display_hdmi_int [get_bd_pins Video_Display/hdmi_int] [get_bd_pins Zynq_1/hdmi_int]
  connect_bd_net -net Zynq_1_spdif_tx_o [get_bd_ports spdif_tx] [get_bd_pins Zynq_1/spdif_tx_o]
  connect_bd_net -net axi4_lite_controller_0_sys_clk [get_bd_ports sys_clk] [get_bd_pins axi4_lite_controller_0/sys_clk]
  connect_bd_net -net axi4_lite_controller_0_sys_rd_cmd [get_bd_ports sys_rd_cmd] [get_bd_pins axi4_lite_controller_0/sys_rd_cmd]
  connect_bd_net -net axi4_lite_controller_0_sys_rdaddr [get_bd_ports sys_rdaddr] [get_bd_pins axi4_lite_controller_0/sys_rdaddr]
  connect_bd_net -net axi4_lite_controller_0_sys_wr_cmd [get_bd_ports sys_wr_cmd] [get_bd_pins axi4_lite_controller_0/sys_wr_cmd]
  connect_bd_net -net axi4_lite_controller_0_sys_wraddr [get_bd_ports sys_wraddr] [get_bd_pins axi4_lite_controller_0/sys_wraddr]
  connect_bd_net -net axi4_lite_controller_0_sys_wrdata [get_bd_ports sys_wrdata] [get_bd_pins axi4_lite_controller_0/sys_wrdata]
  connect_bd_net -net clk_100mhz [get_bd_pins Video_Display/clk_100mhz] [get_bd_pins Zynq_1/clk_100mhz] [get_bd_pins axi4_lite_controller_0/S_AXI_LITE_ACLK]
  connect_bd_net -net clk_200mhz [get_bd_pins Video_Display/clk_200mhz] [get_bd_pins Zynq_1/clk_200mhz]
  connect_bd_net -net logicvc_1_blank_o [get_bd_ports hdmio_de] [get_bd_pins Video_Display/hdmio_de]
  connect_bd_net -net logicvc_1_d_pix_o [get_bd_ports hdmio_data] [get_bd_pins Video_Display/hdmio_data]
  connect_bd_net -net logicvc_1_hsync_o [get_bd_ports hdmio_hsync] [get_bd_pins Video_Display/hdmio_hsync]
  connect_bd_net -net logicvc_1_pix_clk_o [get_bd_ports hdmio_clk] [get_bd_pins Video_Display/hdmio_clk]
  connect_bd_net -net logicvc_1_vsync_o [get_bd_ports hdmio_vsync] [get_bd_pins Video_Display/hdmio_vsync]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_ports sys_resetn] [get_bd_pins Video_Display/axi_resetn] [get_bd_pins Zynq_1/s_axi_aresetn] [get_bd_pins axi4_lite_controller_0/S_AXI_LITE_ARESETN]
  connect_bd_net -net sys_rd_endcmd_1 [get_bd_ports sys_rd_endcmd] [get_bd_pins axi4_lite_controller_0/sys_rd_endcmd]
  connect_bd_net -net sys_rddata_1 [get_bd_ports sys_rddata] [get_bd_pins axi4_lite_controller_0/sys_rddata]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Video_Display/axi_vdma_0/Data_MM2S] [get_bd_addr_segs Zynq_1/processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x4000 -offset 0x43C00000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs axi4_lite_controller_0/S_AXI_LITE/reg0] SEG_axi4_lite_controller_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x79000000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_clkgen_0/S_AXI/reg0] SEG_axi_clkgen_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x70E00000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_hdmi_tx_0/s_axi/reg0] SEG_axi_hdmi_tx_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x75C00000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Zynq_1/axi_spdif_tx_0/S_AXI/reg0] SEG_axi_spdif_tx_1_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


